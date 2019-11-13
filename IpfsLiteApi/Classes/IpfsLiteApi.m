#import "IpfsLiteApi.h"
#import <Mobile/Mobile.h>
#import "ResponseHandler.h"
#import "FileInputHandler.h"
#import "FileOutputHandler.h"

const int CHUNK_SIZE = 1024*32;

@interface IpfsLiteApi()
@property (nonatomic, strong) NSMutableDictionary<NSValue *, FileInputHandler *> *activeInputHandlers;
@property (nonatomic, strong) NSMutableDictionary<NSValue *, FileOutputHandler *> *activeOutputHandlers;
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
        self.activeInputHandlers = [[NSMutableDictionary alloc] init];
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
    
    FileInputHandler *inputHandler = [[FileInputHandler alloc] initWithChunkSize:CHUNK_SIZE onBytes:^(NSInteger length, uint8_t *bytes) {
        [request setChunk:[NSData dataWithBytes:bytes length:length]];
        [call writeMessage:request];
    } onEnd:^(NSStream *stream) {
        [stream close];
        [stream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        NSValue *key = [NSValue valueWithPointer:(__bridge const void * _Nullable)(stream)];
        [self.activeInputHandlers removeObjectForKey:key];
        [call finish];
    } onError:^(NSStream *stream, NSError *error) {
        [stream close];
        [stream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        NSValue *key = [NSValue valueWithPointer:(__bridge const void * _Nullable)(stream)];
        [self.activeInputHandlers removeObjectForKey:key];
        [call cancel];
    }];
    
    NSValue *key = [NSValue valueWithPointer:(__bridge const void * _Nullable)(input)];
    [self.activeInputHandlers setObject:inputHandler forKey:key];
    
    [input setDelegate:inputHandler];
    [input scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [input open];
}

- (void)getFileWithCid:(NSString *)cid completion:(void (^)(NSData * _Nullable, NSError * _Nullable))completion {
    NSMutableData *data = [[NSMutableData alloc] init];
    ResponseHandler<GetFileResponse *> *handler = [[ResponseHandler alloc] init];
    handler.receive = ^(GetFileResponse *resp) {
        NSLog(@"got %ld bytes", [resp.chunk length]);
        [data appendData:resp.chunk];
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        if (error) {
            NSLog(@"completed rpc with error: %@", error.localizedDescription);
            completion(nil, error);
        } else {
            NSLog(@"complete rpc successfully");
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

//- (void)getFileWithCid:(NSString *)cid toOutput:(NSOutputStream *)output completion:(void (^)(NSError * _Nullable))completion {
//    GRPCMutableCallOptions *options = [[GRPCMutableCallOptions alloc] init];
//    options.transportType = GRPCTransportTypeInsecure;
//
//    ResponseHandler<GetFileResponse *> *handler = [[ResponseHandler alloc] init];
//    handler.receive = ^(GetFileResponse *resp){
//        completion(nil);
//    };
//    handler.close = ^(NSDictionary *metadata, NSError *error){
//        completion(error);
//    };
//    GetFileRequest *request = [[GetFileRequest alloc] init];
//    [request setCid:cid];
//    GRPCUnaryProtoCall *call = [self.client getFileWithMessage:request responseHandler:handler callOptions:options];
////    [call start];
//
//
//    NSMutableData *data = [[NSMutableData alloc] init];
//    __block BOOL shouldWriteDirect = NO;
//    __block NSInteger byteIndex = 0;
//
//    FileOutputHandler *outputHandler = [[FileOutputHandler alloc] initWithOnSpaceAvailable:^(NSStream * _Nonnull stream) {
//        NSLog(@"space available");
////        uint8_t *readBytes = (uint8_t *)[data mutableBytes];
////        readBytes += byteIndex; // instance variable to move pointer
////        NSInteger data_len = [data length];
////        NSUInteger len = ((data_len - byteIndex >= 1024) ? 1024 : (data_len - byteIndex));
////
////        if (len == 0) {
////            shouldWriteDirect = YES;
////            return;
////        } else {
////            shouldWriteDirect = NO;
////        }
////
////        uint8_t buf[len];
////        (void)memcpy(buf, readBytes, len);
////        len = [(NSOutputStream *)stream write:(const uint8_t *)buf maxLength:len];
////        byteIndex += len;
//    } onEnd:^(NSStream * _Nonnull stream) {
//        NSLog(@"stream end");
//    } onError:^(NSStream * _Nonnull stream, NSError * _Nonnull error) {
//        NSLog(@"stream error: %@", error.localizedDescription);
//        [call cancel];
//    }];
//
//    NSValue *key = [NSValue valueWithPointer:(__bridge const void * _Nullable)(output)];
//    [self.activeOutputHandlers setObject:outputHandler forKey:key];
//
//    [output setDelegate:outputHandler];
//    [output scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    [output open];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [output close];
//        [output removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//        completion(nil);
//    });
//}

- (BOOL)stop:(NSError * _Nullable __autoreleasing *)error {
    return MobileStop(error);
}

@end
