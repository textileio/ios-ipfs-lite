#import "IpfsLiteApi.h"
#import <Mobile/Mobile.h>
#import "ResponseHandler.h"
#import "FileInputHandler.h"

const int CHUNK_SIZE = 1024*32;

@interface IpfsLiteApi()
@property (nonatomic, strong) NSMutableDictionary<NSValue *, FileInputHandler *> *activeInputHandlers;
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
    
    GRPCStreamingProtoCall *addCall = [self.client addFileWithResponseHandler:handler callOptions:options];
    
    [addCall start];
    
    AddFileRequest *request = [[AddFileRequest alloc] init];
    [request setAddParams:addParams];
    [addCall writeMessage:request];
    
    FileInputHandler *inputHandler = [[FileInputHandler alloc] initWithChunkSize:CHUNK_SIZE onBytes:^(NSInteger length, uint8_t *bytes) {
        [request setChunk:[NSData dataWithBytes:bytes length:length]];
        [addCall writeMessage:request];
    } onEnd:^(NSStream *stream) {
        NSValue *key = [NSValue valueWithPointer:(__bridge const void * _Nullable)(stream)];
        [self.activeInputHandlers removeObjectForKey:key];
        [addCall finish];
    } onError:^(NSStream *stream, NSError *error) {
        NSValue *key = [NSValue valueWithPointer:(__bridge const void * _Nullable)(stream)];
        [self.activeInputHandlers removeObjectForKey:key];
        [addCall cancel];
    }];
    
    NSValue *key = [NSValue valueWithPointer:(__bridge const void * _Nullable)(input)];
    [self.activeInputHandlers setObject:inputHandler forKey:key];
    
    [input setDelegate:inputHandler];
    [input scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [input open];
}

- (NSOutputStream *)getFileWithCid:(NSString *)cid error:(NSError * _Nullable __autoreleasing *)error {
    return [[NSOutputStream alloc] init];
}

- (void)stop:(NSError * _Nullable __autoreleasing *)error {
    
}

@end
