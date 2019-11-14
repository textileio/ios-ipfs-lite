//
//  StreamHandler.h
//  Pods
//
//  Created by Aaron Sutula on 11/13/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StreamHandler : NSObject <NSStreamDelegate>

- (instancetype)initWithOnBytes:(void (^_Nullable)(NSStream *stream))onBytes onSpaceAvailable:(void (^_Nullable)(NSStream *stream))onSpaceAvailable onEnd:(void (^_Nullable)(NSStream *stream))onEnd onError:(void (^_Nullable)(NSStream *stream, NSError *error))onError;

@end

NS_ASSUME_NONNULL_END
