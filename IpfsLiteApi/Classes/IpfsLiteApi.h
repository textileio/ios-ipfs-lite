#import <Foundation/Foundation.h>
#import "IpfsLite.pbrpc.h"
#import "IpfsLite.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface IpfsLiteApi : NSObject

@property (nonatomic, strong) IpfsLite *client;

+ (BOOL)launch:(NSString *)datastorePath debug:(BOOL)debug error:(NSError **)error;
+ (IpfsLiteApi *)instance;

- (void)addFileWithParams:(AddParams *)addParams input:(NSInputStream *)input completion:(void (^)(Node * _Nullable node, NSError * _Nullable error))completion;
- (NSOutputStream *)getFileWithCid:(NSString *)cid error:(NSError **)error;
- (void)stop:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
