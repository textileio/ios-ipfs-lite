//
//  IpfsLiteApi.m
//  Pods
//
//  Created by Aaron Sutula on 11/7/19.
//

#import "IpfsLiteApi.h"
#import <Mobile/Mobile.h>

@implementation IpfsLiteApi

+ (IpfsLiteApi *)instance {
    static IpfsLiteApi *instnace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instnace = [[self alloc] init];
    });
    return instnace;
}

+ (BOOL)launch:(NSString *)datastorePath error:(NSError **)error {
    BOOL started = MobileStart(datastorePath, error);
    if (!started) {
        return started;
    }
    IpfsLiteApi.instance.client = [[IpfsLite alloc] initWithHost:@"localhost:10000"];
    return YES;
}

@end
