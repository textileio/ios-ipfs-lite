//
//  IpfsLiteApi.h
//  Pods
//
//  Created by Aaron Sutula on 11/7/19.
//

#import <Foundation/Foundation.h>
#import "IpfsLite.pbrpc.h"

NS_ASSUME_NONNULL_BEGIN

@interface IpfsLiteApi : NSObject

@property (nonatomic, strong) IpfsLite *client;

+ (BOOL)launch:(NSString *)datastorePath error:(NSError **)error;
+ (IpfsLiteApi *)instance;

@end

NS_ASSUME_NONNULL_END
