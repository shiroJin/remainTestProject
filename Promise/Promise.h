//
//  Promise.h
//  TestProject
//
//  Created by jinqnuanbin on 2018/4/4.
//  Copyright © 2018年 remain. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Promise;

typedef NS_ENUM(NSInteger, PromiseState) {
    PromiseStatePending       = 0,
    PromiseStateFulfilled     = 1,
    PromiseStateRejected      = 2
};

typedef void (^Next) (id value);
typedef void (^ActionBlock) (Promise *promise);
typedef void (^PromiseBlock) (Next, Next);

/**
 *  Promise transaction, defined action and dispatch queue
 **/
@interface PromiseTransaction : NSObject

@property (copy, nonatomic) ActionBlock action;

@property (strong, nonatomic) dispatch_queue_t queue;

@end

/**
 *  Promise Object
 **/
@interface Promise : NSObject

@property (assign, nonatomic) PromiseState state;

@property (assign, nonatomic) id value;

@property (copy, nonatomic) void (^resolveBlk) (id value);

@property (copy, nonatomic) void (^rejectBlk) (id value);;

@property (strong, nonatomic) PromiseTransaction *resolve;

@property (strong, nonatomic) PromiseTransaction *reject;

@property (copy, nonatomic) NSArray<Promise *> *items;

+ (Promise *)resolveOnqueue:(dispatch_queue_t)queue transaction:(PromiseBlock)transaction;

- (Promise *)then:(ActionBlock)resolve;

- (Promise *)catch:(ActionBlock)reject;

- (Promise *)thenResolveOnQueue:(dispatch_queue_t)queue resolve:(ActionBlock)resolve;

- (Promise *)catchOnQueue:(dispatch_queue_t)queue reject:(ActionBlock)reject;

- (Promise *)thenResolveOnQueue:(dispatch_queue_t)queue
                        resolve:(ActionBlock)resolve
                  rejectOnQueue:(dispatch_queue_t)queue2
                         reject:(ActionBlock)reject;

@end
