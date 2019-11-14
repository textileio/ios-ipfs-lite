#import <Foundation/Foundation.h>
#import "IpfsLite.pbrpc.h"
#import "IpfsLite.pbobjc.h"

NS_ASSUME_NONNULL_BEGIN

@interface IpfsLiteApi : NSObject

@property (nonatomic, strong) IpfsLite *client;

+ (BOOL)launch:(NSString *)datastorePath debug:(BOOL)debug error:(NSError **)error;
+ (IpfsLiteApi *)instance;

- (void)addFileWithParams:(AddParams *)addParams input:(NSInputStream *)input completion:(void (^)(Node * _Nullable node, NSError * _Nullable error))completion;
- (void)getFileWithCid:(NSString *)cid toOutput:(NSOutputStream *)output completion:(void (^)(NSError * _Nullable error))completion;
- (void)getFileWithCid:(NSString *)cid completion:(void (^)(NSData * _Nullable data, NSError * _Nullable error))completion;
- (void)hasBlock:(NSString *)cid completion:(void (^)(BOOL hasBlock, NSError * _Nullable error))completion;
- (void)getNodeForCid:(NSString *)cid completion:(void (^)(Node * _Nullable node, NSError * _Nullable error))completion;
- (void)getNodesForCids:(NSMutableArray<NSString *> *)cids handler:(void (^)(BOOL done, Node * _Nullable node, NSError * _Nullable error))handler;
- (void)removeNodeForCid:(NSString *)cid completion:(void (^)(NSError * _Nullable error))completion;
- (void)removeNodesForCids:(NSMutableArray<NSString *> *)cids completion:(void (^)(NSError * _Nullable error))completion;
- (void)resolveLinkInNodeWithCid:(NSString *)cid path:(NSMutableArray<NSString *> *)path completion:(void (^)(Link * _Nullable link, NSArray<NSString *> * _Nullable remainingPath, NSError * _Nullable error))completion;
- (void)treeInNodeWithCid:(NSString *)cid fromPath:(NSString * _Nullable)path depth:(int)depth completion:(void (^)(NSArray<NSString *> * _Nullable paths, NSError * _Nullable error))completion;
- (BOOL)stop:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
