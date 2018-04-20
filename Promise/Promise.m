//
//  Promise.m
//  TestProject
//
//  Created by remain on 2018/4/4.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "Promise.h"

@implementation Promise

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.resolveBlk = [self __resolve];
        self.rejectBlk = [self __reject];
    }
    return self;
}

- (void (^) (id))__resolve {
    __weak typeof(self) wself = self;
    return ^(id value) {
        typeof(self) sself = wself;
        for (Promise *item in sself.items) {
            if (item.resolve) {
                item.value = value;
                item.state = PromiseStateFulfilled;
            }
        }
    };
}

- (void (^) (id))__reject {
    __weak typeof(self) wself = self;
    return ^(id value) {
        typeof(self) sself = wself;
        for (Promise *item in sself.items) {
            if (item.reject) {
                item.value = value;
                item.state = PromiseStateRejected;
            }
        }
    };
}

#pragma mark - Static Method

+ (Promise *)resolveOnqueue:(dispatch_queue_t)queue transaction:(PromiseBlock)transaction {
    Promise *promise = [[Promise alloc] init];
    dispatch_async(queue, ^{
        transaction(promise.resolveBlk, promise.rejectBlk);
    });
    return promise;
}

#pragma mark - Public Method

- (Promise *)then:(ActionBlock)resolve {
    return [self thenResolveOnQueue:dispatch_get_main_queue() resolve:resolve];
}

- (Promise *)catch:(ActionBlock)reject {
    return [self catchOnQueue:dispatch_get_main_queue() reject:reject];
}

- (Promise *)thenResolveOnQueue:(dispatch_queue_t)queue resolve:(ActionBlock)resolve {
    return [self thenResolveOnQueue:queue resolve:resolve rejectOnQueue:nil reject:nil];
}

- (Promise *)catchOnQueue:(dispatch_queue_t)queue reject:(ActionBlock)reject {
    return [self thenResolveOnQueue:nil resolve:nil rejectOnQueue:queue reject:reject];
}

- (Promise *)thenResolveOnQueue:(dispatch_queue_t)queue
                        resolve:(ActionBlock)resolve
                  rejectOnQueue:(dispatch_queue_t)queue2
                         reject:(ActionBlock)reject
{
    Promise *promise = [[Promise alloc] init];
    promise.resolve = ({
        PromiseTransaction *r = [[PromiseTransaction alloc] init];
        r.action = resolve;
        r.queue = queue;
        r;
    });
    promise.reject = ({
        PromiseTransaction *r = [[PromiseTransaction alloc] init];
        r.action = reject;
        r.queue = queue2;
        r;
    });
    
    NSMutableArray *items = [self.items mutableCopy] ?: [NSMutableArray array];
    [items addObject:promise];
    self.items = [items copy];
    
    return promise;
}

- (void)setState:(PromiseState)state {
    if (_state != PromiseStatePending) return;
    _state = state;
    
    if (state == PromiseStateFulfilled) {
        dispatch_async(self.resolve.queue, ^{
            self->_resolve.action(self);
        });
    }
    else if (state == PromiseStateRejected) {
        dispatch_async(self.reject.queue, ^{
            self->_reject.action(self);
        });
    }
}

@end

@implementation PromiseTransaction

@end
