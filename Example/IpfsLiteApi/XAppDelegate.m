//
//  XAppDelegate.m
//  IpfsLiteApi
//
//  Created by Aaron Sutula on 11/07/2019.
//  Copyright (c) 2019 Aaron Sutula. All rights reserved.
//

#import "XAppDelegate.h"
#import <IpfsLiteApi/IpfsLiteApi-umbrella.h>

@implementation XAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString *repoPath = [documents stringByAppendingPathComponent:@"ipfs-lite"];
//    NSError *error;
//    [IpfsLiteApi launch:repoPath debug:false error:&error];
//    if (error) {
//        NSLog(@"error launching: %@", error.localizedDescription);
//    }
//    
////    NSInputStream *input = [[NSInputStream alloc] initWithData:[@"Hello there\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpeg"];
//    NSInputStream *input = [[NSInputStream alloc] initWithFileAtPath:path];
//    [IpfsLiteApi.instance addFileWithParams:[[AddParams alloc] init] input:input completion:^(Node * _Nullable node, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"got error: %@", error.localizedDescription);
//            return;
//        }
//        NSLog(@"got node: %@", node);
//        NSOutputStream *output = [NSOutputStream outputStreamToMemory];
//        [IpfsLiteApi.instance getFileWithCid:node.block.cid toOutput:output completion:^(NSError * _Nullable error) {
//            if (error) {
//                NSLog(@"Completed with error: %@", error.localizedDescription);
//                return;
//            }
//            NSLog(@"complete");
//            NSData *data = [output propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
////            NSString *val = [NSString stringWithUTF8String:[data bytes]];
////            NSLog(@"VALUE = %@", val);
//            UIImage *image = [UIImage imageWithData:data];
//            NSLog(@"COOOL");
//        }];
//    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
