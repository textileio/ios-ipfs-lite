#import "StreamHandler.h"

@interface StreamHandler()

@property (nonatomic, copy, nullable) void (^onBytes)(NSStream * _Nonnull);
@property (nonatomic, copy, nullable) void (^onSpaceAvailable)(NSStream * _Nonnull);
@property (nonatomic, copy, nullable) void (^onEnd)(NSStream * _Nonnull);
@property (nonatomic, copy, nullable) void (^onError)(NSStream * _Nonnull, NSError * _Nonnull);

@end

@implementation StreamHandler

- (instancetype)initWithOnBytes:(void (^)(NSStream * _Nonnull))onBytes onSpaceAvailable:(void (^)(NSStream * _Nonnull))onSpaceAvailable onEnd:(void (^)(NSStream * _Nonnull))onEnd onError:(void (^)(NSStream * _Nonnull, NSError * _Nonnull))onError {
    if (self = [super init]) {
        self.onBytes = onBytes;
        self.onSpaceAvailable = onSpaceAvailable;
        self.onEnd = onEnd;
        self.onError = onError;
    }
    return self;
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable: {
            if (self.onBytes) {
                self.onBytes(stream);
            }
            break;
        }
        case NSStreamEventHasSpaceAvailable: {
            if (self.onSpaceAvailable) {
                self.onSpaceAvailable(stream);
            }
            break;
        }
        case NSStreamEventEndEncountered: {
            if (self.onEnd) {
                self.onEnd(stream);
            }
            break;
        }
        case NSStreamEventErrorOccurred: {
            if (self.onError) {
                self.onError(stream, stream.streamError);
            }
            break;
        }
        default:
            break;
    }
}


@end
