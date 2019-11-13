#import "ResponseHandler.h"

@implementation ResponseHandler

- (instancetype)init {
    if (self = [super init]) {
        self.queue = dispatch_get_main_queue();
    }
    return self;
}

- (instancetype)initWithReceive:(void (^)(GPBMessage *))receive close:(void (^)(NSDictionary *, NSError *))close {
    if (self = [super init]) {
        self.receive = receive;
        self.close = close;
        self.queue = dispatch_get_main_queue();
    }
    return self;
}

- (dispatch_queue_t)dispatchQueue {
    return self.queue;
}

- (void)didReceiveProtoMessage:(GPBMessage *)message {
    if (self.receive) {
        self.receive(message);
    }
}

- (void)didCloseWithTrailingMetadata:(NSDictionary *)trailingMetadata error:(NSError *)error {
    if (self.close) {
        self.close(trailingMetadata, error);
    }
}

@end
