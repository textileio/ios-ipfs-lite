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
    __block AddFileResponse *response;
    handler.receive = ^(AddFileResponse *resp){
        response = resp;
    };
    handler.close = ^(NSDictionary *metadata, NSError *error){
        completion(response.node, error);
    };
    
    GRPCStreamingProtoCall *call = [self.client addFileWithResponseHandler:handler callOptions:[self defaultCallOptions]];
    
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
    NSOutputStream *output = [NSOutputStream outputStreamToMemory];
    [self getFileWithCid:cid toOutput:output completion:^(NSError * _Nullable error) {
        NSData *data = [output propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        completion(data, error);
    }];
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
    
    GRPCUnaryProtoCall *call = [self.client getFileWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    
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

- (void)hasBlock:(NSString *)cid completion:(void (^)(BOOL, NSError * _Nullable))completion {
    HasBlockRequest *request = [[HasBlockRequest alloc] init];
    [request setCid:cid];
    ResponseHandler<HasBlockResponse *> *handler = [[ResponseHandler alloc] init];
    __block HasBlockResponse *response;
    handler.receive = ^(HasBlockResponse *resp) {
        response = resp;
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(response.hasBlock, error);
    };
    GRPCUnaryProtoCall *call = [self.client hasBlockWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}

- (void)getNodeForCid:(NSString *)cid completion:(void (^)(Node * _Nullable, NSError * _Nullable))completion {
    GetNodeRequest *request = [[GetNodeRequest alloc] init];
    [request setCid:cid];
    
    ResponseHandler<GetNodeResponse *> *handler = [[ResponseHandler alloc] init];
    __block GetNodeResponse *response;
    handler.receive = ^(GetNodeResponse *resp) {
        response = resp;
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(response.node, error);
    };
    
    GRPCUnaryProtoCall *call = [self.client getNodeWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}
- (void)getNodesForCids:(NSMutableArray<NSString *> *)cids handler:(void (^)(BOOL, Node * _Nullable, NSError * _Nullable))handler {
    GetNodesRequest *request = [[GetNodesRequest alloc] init];
    [request setCidsArray:cids];
    
    ResponseHandler<GetNodesResponse *> *respHandler = [[ResponseHandler alloc] init];
    respHandler.receive = ^(GetNodesResponse *resp) {
        switch (resp.optionOneOfCase) {
            case GetNodesResponse_Option_OneOfCase_Node:
                handler(NO, resp.node, nil);
                break;
            case GetNodesResponse_Option_OneOfCase_Error: {
                NSError *e = [NSError errorWithDomain:@"ipfs-lite" code:0 userInfo:@{NSLocalizedDescriptionKey : resp.error}];
                handler(NO, nil, e);
                break;
            }
            default:
                break;
        }
    };
    respHandler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        handler(YES, nil, error);
    };
    
    GRPCUnaryProtoCall *call = [self.client getNodesWithMessage:request responseHandler:respHandler callOptions:[self defaultCallOptions]];
    [call start];
}

- (void)removeNodeForCid:(NSString *)cid completion:(void (^)(NSError * _Nullable))completion {
    RemoveNodeRequest *request = [[RemoveNodeRequest alloc] init];
    [request setCid:cid];
    
    ResponseHandler<RemoveNodeResponse *> *handler = [[ResponseHandler alloc] init];
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(error);
    };
    
    GRPCUnaryProtoCall *call = [self.client removeNodeWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}

- (void)removeNodesForCids:(NSMutableArray<NSString *> *)cids completion:(void (^)(NSError * _Nullable))completion {
    RemoveNodesRequest *request = [[RemoveNodesRequest alloc] init];
    [request setCidsArray:cids];
    
    ResponseHandler<RemoveNodesResponse *> *handler = [[ResponseHandler alloc] init];
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(error);
    };
    
    GRPCUnaryProtoCall *call = [self.client removeNodesWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}

- (void)resolveLinkInNodeWithCid:(NSString *)cid path:(NSMutableArray<NSString *> *)path completion:(void (^)(Link * _Nullable, NSArray<NSString *> * _Nullable, NSError * _Nullable))completion {
    ResolveLinkRequest *request = [[ResolveLinkRequest alloc] init];
    [request setNodeCid:cid];
    [request setPathArray:path];
    
    ResponseHandler<ResolveLinkResponse *> *handler = [[ResponseHandler alloc] init];
    __block ResolveLinkResponse *response;
    handler.receive = ^(ResolveLinkResponse *resp) {
        response = resp;
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(response.link, response.remainingPathArray, error);
    };
    
    GRPCUnaryProtoCall *call = [self.client resolveLinkWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}

- (void)treeInNodeWithCid:(NSString *)cid fromPath:(NSString *)path depth:(int)depth completion:(void (^)(NSArray<NSString *> * _Nullable, NSError * _Nullable))completion {
    TreeRequest *request = [[TreeRequest alloc] init];
    [request setNodeCid:cid];
    [request setPath:path];
    [request setDepth:depth];
    
    ResponseHandler<TreeResponse *> *handler = [[ResponseHandler alloc] init];
    __block TreeResponse *response;
    handler.receive = ^(TreeResponse *resp) {
        response = resp;
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(response.pathsArray, error);
    };
    
    GRPCUnaryProtoCall *call = [self.client treeWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}

- (BOOL)stop:(NSError * _Nullable __autoreleasing *)error {
    return MobileStop(error);
}

- (GRPCMutableCallOptions *)defaultCallOptions {
    GRPCMutableCallOptions *options = [[GRPCMutableCallOptions alloc] init];
    options.transportType = GRPCTransportTypeInsecure;
    return options;
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
