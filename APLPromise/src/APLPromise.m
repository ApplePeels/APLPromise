//
//  APLPromise.m
//  APLPromise
//
//  Created by wangxingming on 2019/4/16.
//  Copyright © 2019 wangxingming. All rights reserved.
//

#import "APLPromise.h"

static dispatch_queue_t s_queue;

@interface APLPromise ()
@property (nonatomic, strong) dispatch_semaphore_t sem;
@end

@implementation APLPromise
- (instancetype)init {
    self = [super init];
    self.sem = dispatch_semaphore_create(0);
    return self;
}

+ (void)initialize {
    s_queue = dispatch_queue_create("com.applepeel.queue.promise", DISPATCH_QUEUE_CONCURRENT);
}

- (void)dealloc {
}

+ (void)async:(void(^)(APLPromise* promise))block {
    dispatch_async(s_queue, ^{
        APLPromise* promise = [[APLPromise alloc] init];
        block(promise);
    });
}

- (id)await:(void(^)(APLPromiseResult result))block {
    __block id ret = 0;
    block(^(id value) {
        ret = value;
        dispatch_semaphore_signal(self.sem);
    });
    dispatch_semaphore_wait(self.sem, DISPATCH_TIME_FOREVER);
    return ret;
}

@end
