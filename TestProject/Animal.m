//
//  Animal.m
//  TestProject
//
//  Created by remain on 2018/3/20.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (instancetype)init
{
    self = [super init];
    if (self) {
        _overloadProperty = @"Animal";
    }
    return self;
}

- (void)test {
    [self bark];
}

- (void)bark {
    NSLog(@"%@", self.class);
}

- (void)foo {
    NSLog(@"%@  %@", self.class, _overloadProperty);
}

@end
