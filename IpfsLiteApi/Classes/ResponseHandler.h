#import <Foundation/Foundation.h>
#import "IpfsLite.pbrpc.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResponseHandler<__covariant ObjectType : GPBMessage *> : NSObject<GRPCProtoResponseHandler>

@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, copy, nullable) void (^receive)(ObjectType resp);
@property (nonatomic, copy, nullable) void (^close)(NSDictionary * _Nullable metadata, NSError * _Nullable error);

- (instancetype)initWithReceive:(void (^)(ObjectType message))receive close:(void (^)(NSDictionary *trailingMetadata, NSError *error))close;

@end

NS_ASSUME_NONNULL_END
