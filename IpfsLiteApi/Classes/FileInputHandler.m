#import "FileInputHandler.h"

@interface FileInputHandler()

@property (nonatomic, assign) int chunkSize;
@property (nonatomic, copy) void (^onBytes)(NSInteger, uint8_t *);
@property (nonatomic, copy) void (^onEnd)(NSStream *);
@property (nonatomic, copy) void (^onError)(NSStream *, NSError *);

@end

@implementation FileInputHandler

- (instancetype)initWithChunkSize:(int)chunkSize onBytes:(void (^)(NSInteger, uint8_t *))onBytes onEnd:(void (^)(NSStream *))onEnd onError:(void (^)(NSStream *, NSError *))onError {
    if (self = [super init]) {
        self.chunkSize = chunkSize;
        self.onBytes = onBytes;
        self.onEnd = onEnd;
        self.onError = onError;
    }
    return self;
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    switch (eventCode) {
        case NSStreamEventHasBytesAvailable: {
            uint8_t buf[self.chunkSize];
            NSInteger len = 0;
            len = [(NSInputStream *)stream read:buf maxLength:self.chunkSize];
            if(len) {
                self.onBytes(len, buf);
            }
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
