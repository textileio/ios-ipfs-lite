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

+ (BOOL)launch:(NSString *)datastorePath debug:(BOOL)debug lowMem:(BOOL)lowMem error:(NSError **)error {
    long port;
    BOOL started = MobileStart(datastorePath, debug, lowMem, &port, error);
    if (!started) {
        return started;
    }
    NSString *host = [NSString stringWithFormat:@"localhost:%ld", port];
    IpfsLiteApi.instance.client = [[TTEIpfsLite alloc] initWithHost:host];
    return YES;
}

- (instancetype)init {
    if (self = [super init]) {
        self.activeStreamHandlers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addFileFromInput:(NSInputStream *)input params:(TTEAddParams *)params completion:(void (^)(TTENode * _Nullable, NSError * _Nullable))completion {
    ResponseHandler<TTEAddFileResponse *> *handler = [[ResponseHandler alloc] init];
    __block TTEAddFileResponse *response;
    handler.receive = ^(TTEAddFileResponse *resp){
        response = resp;
    };
    handler.close = ^(NSDictionary *metadata, NSError *error){
        completion(response.node, error);
    };
    
    GRPCStreamingProtoCall *call = [self.client addFileWithResponseHandler:handler callOptions:[self defaultCallOptions]];
    
    [call start];
    
    TTEAddFileRequest *request = [[TTEAddFileRequest alloc] init];
    [request setAddParams:params];
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
    [self getFileToOutput:output cid:cid completion:^(NSError * _Nullable error) {
        NSData *data = [output propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
        completion(data, error);
    }];
}

- (void)getFileToOutput:(NSOutputStream *)output cid:(NSString *)cid completion:(void (^)(NSError * _Nullable))completion {
    NSMutableArray<TTEGetFileResponse *> *queue = [[NSMutableArray alloc] init];
    __block BOOL shouldWriteDirect = NO;
    
    TTEGetFileRequest *request = [[TTEGetFileRequest alloc] init];
    [request setCid:cid];
    
    ResponseHandler<TTEGetFileResponse *> *handler = [[ResponseHandler alloc] init];
    handler.receive = ^(TTEGetFileResponse *resp){
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
        TTEGetFileResponse *item = [queue firstObject];
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
    TTEHasBlockRequest *request = [[TTEHasBlockRequest alloc] init];
    [request setCid:cid];
    ResponseHandler<TTEHasBlockResponse *> *handler = [[ResponseHandler alloc] init];
    __block TTEHasBlockResponse *response;
    handler.receive = ^(TTEHasBlockResponse *resp) {
        response = resp;
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(response.hasBlock, error);
    };
    GRPCUnaryProtoCall *call = [self.client hasBlockWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}

- (void)getNodeForCid:(NSString *)cid completion:(void (^)(TTENode * _Nullable, NSError * _Nullable))completion {
    TTEGetNodeRequest *request = [[TTEGetNodeRequest alloc] init];
    [request setCid:cid];
    
    ResponseHandler<TTEGetNodeResponse *> *handler = [[ResponseHandler alloc] init];
    __block TTEGetNodeResponse *response;
    handler.receive = ^(TTEGetNodeResponse *resp) {
        response = resp;
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(response.node, error);
    };
    
    GRPCUnaryProtoCall *call = [self.client getNodeWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}
- (void)getNodesForCids:(NSMutableArray<NSString *> *)cids handler:(void (^)(BOOL, TTENode * _Nullable, NSError * _Nullable))handler {
    TTEGetNodesRequest *request = [[TTEGetNodesRequest alloc] init];
    [request setCidsArray:cids];
    
    ResponseHandler<TTEGetNodesResponse *> *respHandler = [[ResponseHandler alloc] init];
    respHandler.receive = ^(TTEGetNodesResponse *resp) {
        switch (resp.optionOneOfCase) {
            case TTEGetNodesResponse_Option_OneOfCase_Node:
                handler(NO, resp.node, nil);
                break;
            case TTEGetNodesResponse_Option_OneOfCase_Error: {
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
    TTERemoveNodeRequest *request = [[TTERemoveNodeRequest alloc] init];
    [request setCid:cid];
    
    ResponseHandler<TTERemoveNodeResponse *> *handler = [[ResponseHandler alloc] init];
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(error);
    };
    
    GRPCUnaryProtoCall *call = [self.client removeNodeWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}

- (void)removeNodesForCids:(NSMutableArray<NSString *> *)cids completion:(void (^)(NSError * _Nullable))completion {
    TTERemoveNodesRequest *request = [[TTERemoveNodesRequest alloc] init];
    [request setCidsArray:cids];
    
    ResponseHandler<TTERemoveNodesResponse *> *handler = [[ResponseHandler alloc] init];
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(error);
    };
    
    GRPCUnaryProtoCall *call = [self.client removeNodesWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}

- (void)resolveLinkInNodeWithCid:(NSString *)cid path:(NSMutableArray<NSString *> *)path completion:(void (^)(TTELink * _Nullable, NSArray<NSString *> * _Nullable, NSError * _Nullable))completion {
    TTEResolveLinkRequest *request = [[TTEResolveLinkRequest alloc] init];
    [request setNodeCid:cid];
    [request setPathArray:path];
    
    ResponseHandler<TTEResolveLinkResponse *> *handler = [[ResponseHandler alloc] init];
    __block TTEResolveLinkResponse *response;
    handler.receive = ^(TTEResolveLinkResponse *resp) {
        response = resp;
    };
    handler.close = ^(NSDictionary * _Nullable metadata, NSError * _Nullable error) {
        completion(response.link, response.remainingPathArray, error);
    };
    
    GRPCUnaryProtoCall *call = [self.client resolveLinkWithMessage:request responseHandler:handler callOptions:[self defaultCallOptions]];
    [call start];
}

- (void)treeInNodeWithCid:(NSString *)cid fromPath:(NSString *)path depth:(int)depth completion:(void (^)(NSArray<NSString *> * _Nullable, NSError * _Nullable))completion {
    TTETreeRequest *request = [[TTETreeRequest alloc] init];
    [request setNodeCid:cid];
    [request setPath:path];
    [request setDepth:depth];
    
    ResponseHandler<TTETreeResponse *> *handler = [[ResponseHandler alloc] init];
    __block TTETreeResponse *response;
    handler.receive = ^(TTETreeResponse *resp) {
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
