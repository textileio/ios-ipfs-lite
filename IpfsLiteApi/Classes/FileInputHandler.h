#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileInputHandler : NSObject <NSStreamDelegate>

- (instancetype)initWithChunkSize:(int)chunkSize onBytes:(void (^)(NSInteger length, uint8_t *bytes))onBytes onEnd:(void (^)(NSStream *stream))onEnd onError:(void (^)(NSStream *stream, NSError *error))onError;

@end

NS_ASSUME_NONNULL_END
