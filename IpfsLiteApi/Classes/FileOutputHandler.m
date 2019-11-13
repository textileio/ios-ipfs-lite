#import "FileOutputHandler.h"

@interface FileOutputHandler()

@property (nonatomic, copy) void (^onSpaceAvailable)(NSStream *);
@property (nonatomic, copy) void (^onEnd)(NSStream *);
@property (nonatomic, copy) void (^onError)(NSStream *, NSError *);

@end

@implementation FileOutputHandler

- (instancetype)initWithOnSpaceAvailable:(void (^)(NSStream *))onSpaceAvailable onEnd:(void (^)(NSStream * _Nonnull))onEnd onError:(void (^)(NSStream * _Nonnull, NSError * _Nonnull))onError {
    if (self = [super init]) {
        self.onSpaceAvailable = onSpaceAvailable;
        self.onEnd = onEnd;
        self.onError = onError;
    }
    return self;
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventHasSpaceAvailable: {
            self.onSpaceAvailable(stream);
            break;
        }
        case NSStreamEventEndEncountered:
            self.onEnd(stream);
            break;
        case NSStreamEventErrorOccurred:
            self.onError(stream, stream.streamError);
            break;
        default:
            break;
    }
}

@end
