//
//  DispatchDelegate.m
//  TestProject
//
//  Created by remain on 2018/3/22.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "DispatchDelegate.h"

@implementation DispatchDelegate {
    NSPointerArray *_delegates;
}

- (instancetype)init {
    if (self = [super init]) {
        _delegates = [[NSPointerArray alloc] initWithOptions:NSPointerFunctionsWeakMemory];
    }
    return self;
}

- (void)registerDelegate:(id)delegate {
    if (delegate) {
        [_delegates addPointer:(__bridge void *)delegate];
    }
}

- (void)withdrawDelegate:(id)delegate {
    NSInteger index = -1;
    for (NSInteger i = 0; i < _delegates.count; i++) {
        if ([_delegates pointerAtIndex:i] == (__bridge void *)delegate) {
            index = i;
            break;
        }
    }
    
    if (index > 0 && index < (NSInteger)_delegates.count) {
        [_delegates removePointerAtIndex:index];
    }
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    for (int i = 0; i < _delegates.count; i++) {
        void *pointer = [_delegates pointerAtIndex:i];
        if (pointer == NULL) continue;
        id delegate = (__bridge id)pointer;
        if ([delegate respondsToSelector:anInvocation.selector]) {
            [anInvocation setTarget:delegate];
            [anInvocation invoke];
        }
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    for (int i = 0; i < _delegates.count; i++) {
        void *pointer = [_delegates pointerAtIndex:i];
        if (pointer == NULL) continue;
        id delegate = (__bridge id)pointer;
        if ([delegate respondsToSelector:aSelector]) {
            return [[delegate class] instanceMethodSignatureForSelector:aSelector];
        }
    }
    return [super methodSignatureForSelector:aSelector];
}

@end
