#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileOutputHandler : NSObject <NSStreamDelegate>

- (instancetype)initWithOnSpaceAvailable:(void (^)(NSStream *stream))onSpaceAvailable onEnd:(void (^)(NSStream *stream))onEnd onError:(void (^)(NSStream *stream, NSError *error))onError;

@end

NS_ASSUME_NONNULL_END
