//
//  XAppDelegate.m
//  IpfsLiteApi
//
//  Created by Aaron Sutula on 11/07/2019.
//  Copyright (c) 2019 Aaron Sutula. All rights reserved.
//

#import "XAppDelegate.h"
#import <IpfsLiteApi/IpfsLiteApi-umbrella.h>

@interface ResponseHandler : NSObject<GRPCProtoResponseHandler>

@end

// A response handler object dispatching messages to main queue
@implementation ResponseHandler

- (dispatch_queue_t)dispatchQueue {
    return dispatch_get_main_queue();
}

- (void)didReceiveProtoMessage:(GPBMessage *)message {
    NSLog(@"%@", message);
}

- (void)didCloseWithTrailingMetadata:(NSDictionary *)trailingMetadata error:(NSError *)error {
    NSLog(@"closed - %@", error.localizedDescription);
}

@end

@implementation XAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *repoPath = [documents stringByAppendingPathComponent:@"ipfs-lite"];
    NSError *error;
    [IpfsLiteApi launch:repoPath error:&error];
    if (error) {
        NSLog(@"error launching: %@", error.localizedDescription);
    }
    
    ResponseHandler *h = [[ResponseHandler alloc] init];
    
    GRPCMutableCallOptions *options = [[GRPCMutableCallOptions alloc] init];
    options.transportType = GRPCTransportTypeInsecure;
    
    GRPCStreamingProtoCall *addCall = [IpfsLiteApi.instance.client addFileWithResponseHandler:h callOptions:options];
    
    AddParams *addParams = [[AddParams alloc] init];
    AddFileRequest *addParamsRequest = [[AddFileRequest alloc] init];
    [addParamsRequest setAddParams:addParams];
    
    [addCall start];
    
    [addCall writeMessage:addParamsRequest];
    
    AddFileRequest *addChunkRequest = [[AddFileRequest alloc] init];
    [addChunkRequest setChunk:[@"Hello there" dataUsingEncoding:kCFStringEncodingUTF8]];
    
    [addCall writeMessage:addChunkRequest];
    
    [addCall finish];
    
//    GetFileRequest *request = [[GetFileRequest alloc] init];
//    [request setCid:@"QmY7Yh4UquoXHLPFo2XbhXkhBvFoPwmQUSa92pxnxjQuPU"];
//    
//    GRPCUnaryProtoCall *call = [IpfsLiteApi.instance.client getFileWithMessage:request responseHandler:h callOptions:options];
//    
//    [call start];
    
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
