#import "IpfsLiteApi.h"
#import <Mobile/Mobile.h>
#import "ResponseHandler.h"
#import "StreamHandler.h"

const int CHUNK_SIZE = 1024*32;

@interface IpfsLiteApi()
@property (nonatomic, strong) NSMutableDictionary<NSValue *, StreamHandler*> *activeStreamHandlers;
@end

@implementation IpfsLiteApi

+ (IpfsLiteApi *)instance {
    static IpfsLiteApi *instnace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instnace = [[self alloc] init];
    });
    return instnace;
}

+ (BOOL)launch:(NSString *)datastorePath debug:(BOOL)debug error:(NSError **)error {
    long port;
    BOOL started = MobileStart(datastorePath, debug, &port, error);
    if (!started) {
        return started;
    }
    NSString *host = [NSString stringWithFormat:@"localhost:%ld", port];
    IpfsLiteApi.instance.client = [[IpfsLite alloc] initWithHost:host];
    return YES;
}

- (instancetype)init {
    if (self = [super init]) {
        self.activeStreamHandlers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addFileWithParams:(AddParams *)addParams input:(NSInputStream *)input completion:(void (^)(Node * _Nullable, NSError * _Nullable))completion {
    ResponseHandler<AddFileResponse *> *handler = [[ResponseHandler alloc] init];
    handler.receive = ^(AddFileResponse *resp){
        completion(resp.node, nil);
    };
    handler.close = ^(NSDictionary *metadata, NSError *error){
        if (error) {
            completion(nil, error);
        }
    };
    
    GRPCMutableCallOptions *options = [[GRPCMutableCallOptions alloc] init];
    options.transportType = GRPCTransportTypeInsecure;
    
    GRPCStreamingProtoCall *call = [self.client addFileWithResponseHandler:handler callOptions:options];
    
    [call start];
    
    AddFileRequest *request = [[AddFileRequest alloc] init];
    [request setAddParams:addParams];
    [call writeMessage:request];
    
    StreamHandler *sh = [[StreamHandler alloc] initWithOnBytes:^(NSStream * _Nonnull stream) {
        uint8_t buf[CHUNK_SIZE];
        NSInteger len = 0;
        len = [(NSInputStream *)stream read:buf maxLength:CHUNK_SIZE];
        if(len) {
            [request setChunk:[NSData dataWithBytes:buf length:len]];
            [call writeMessage:request];
        }
    } onSpaceAvailable:^(NSStream * _Nonnull stream) {
    } onEnd:^(NSStream * _Nonnull stream) {
        [self unbindStream:stream];
        [call finish];
    } onError:^(NSStream * _Nonnull stream, NSError * _Nonnull error) {
        [self unbindStream:stream];
        [call cancel];
    }];
    
    [self bindStreamHandler:sh toStream:input];
}

- (void)getFileWithCid:(NSString *)cid completion:(void (^)(NSData * _Nullable, NSError * _Nullable))completion {
    NSMutableData *data = [[NSMutableData alloc] init];
    ResponseHandler<GetFileResponse *> *handler = [[ResponseHandler alloc] init];
    handler.receive = ^(GetFileResponse *resp) {
        [data appendData:resp.chunk];
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
        } else {
            completion(data, nil);
        }
    };
    
    GRPCMutableCallOptions *options = [[GRPCMutableCallOptions alloc] init];
    options.transportType = GRPCTransportTypeInsecure;
    
    GetFileRequest *request = [[GetFileRequest alloc] init];
    [request setCid:cid];
    GRPCUnaryProtoCall *call = [self.client getFileWithMessage:request responseHandler:handler callOptions:options];
    [call start];
}

- (void)getFileWithCid:(NSString *)cid toOutput:(NSOutputStream *)output completion:(void (^)(NSError * _Nullable))completion {
    NSMutableArray<GetFileResponse *> *queue = [[NSMutableArray alloc] init];
    __block BOOL shouldWriteDirect = NO;
    
    GetFileRequest *request = [[GetFileRequest alloc] init];
    [request setCid:cid];
    
    ResponseHandler<GetFileResponse *> *handler = [[ResponseHandler alloc] init];
    handler.receive = ^(GetFileResponse *resp){
        if (shouldWriteDirect) {
            [output write:[resp.chunk bytes] maxLength:[resp.chunk length]];
        } else {
            [queue addObject:resp];
        }
    };
    handler.close = ^(NSDictionary *metadata, NSError *error){
        [self unbindStream:output];
        completion(error);
    };
    
    GRPCMutableCallOptions *options = [[GRPCMutableCallOptions alloc] init];
    options.transportType = GRPCTransportTypeInsecure;
    
    GRPCUnaryProtoCall *call = [self.client getFileWithMessage:request responseHandler:handler callOptions:options];
    
    StreamHandler *sh = [[StreamHandler alloc] initWithOnBytes:^(NSStream * _Nonnull stream) {
    } onSpaceAvailable:^(NSStream * _Nonnull stream) {
        GetFileResponse *item = [queue firstObject];
        if (item) {
            shouldWriteDirect = NO;
            [queue removeObjectAtIndex:0];
            [(NSOutputStream *)stream write:[item.chunk bytes] maxLength:[item.chunk length]];
        } else {
            shouldWriteDirect = YES;
        }
    } onEnd:^(NSStream * _Nonnull stream) {
        NSLog(@"!!!UNHANDLED STREAM HANDLER ON END!!!");
    } onError:^(NSStream * _Nonnull stream, NSError * _Nonnull error) {
        [call cancel];
        [self unbindStream:stream];
        completion(error);
    }];
    
    [self bindStreamHandler:sh toStream:output];
    
    [call start];
}

- (void)getNodeForCid:(NSString *)cid completion:(void (^)(Node * _Nullable, NSError * _Nullable))completion {
    GetNodeRequest *request = [[GetNodeRequest alloc] init];
    [request setCid:cid];
    
    ResponseHandler<GetNodeResponse *> *handler = [[ResponseHandler alloc] init];
    handler.receive = ^(GetNodeResponse *resp) {
        completion(resp.node, nil);
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
        }
    };
    
    GRPCMutableCallOptions *options = [[GRPCMutableCallOptions alloc] init];
    options.transportType = GRPCTransportTypeInsecure;
    
    GRPCUnaryProtoCall *call = [self.client getNodeWithMessage:request responseHandler:handler callOptions:options];
    [call start];
}

- (BOOL)stop:(NSError * _Nullable __autoreleasing *)error {
    return MobileStop(error);
}

- (void)bindStreamHandler:(StreamHandler *)streamHandler toStream:(NSStream *)stream {
    NSValue *key = [NSValue valueWithPointer:(__bridge const void * _Nullable)(stream)];
    [self.activeStreamHandlers setObject:streamHandler forKey:key];
    [stream setDelegate:streamHandler];
    [stream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [stream open];
}

- (void)unbindStream:(NSStream *)stream {
    [stream close];
    [stream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    stream.delegate = nil;
    NSValue *key = [NSValue valueWithPointer:(__bridge const void * _Nullable)(stream)];
    [self.activeStreamHandlers removeObjectForKey:key];
}

@end
