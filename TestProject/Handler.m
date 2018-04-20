//
//  Handler.m
//  TestProject
//
//  Created by remain on 2018/3/28.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "Handler.h"
#import "Promise.h"

@implementation Handler {
    void (^_blk) (void);
}

- (void)foo {
//    [[Promise alloc] init].then(^() {
//        NSLog(@"1");
//    }).then(^() {
//        NSLog(@"2");
//    });
    
    __block int flag = 0;
    _blk = ^{
        flag = flag + 1;
        NSLog(@"%d", flag);
    };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _blk();
        _blk();
        _blk();
    });
}

@end
