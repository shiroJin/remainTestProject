//
//  Dog.m
//  TestProject
//
//  Created by remain on 2018/3/20.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "Dog.h"

@implementation Dog

@synthesize overloadProperty = _overloadProperty;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _overloadProperty = @"Dog";
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%@ Dealloc", self.class);
}

- (void)bark {
    NSLog(@"%@", self.class);
}

- (void)foo {
    NSLog(@"%@  %@", self.class, _overloadProperty);
    [super foo];
}

@end
