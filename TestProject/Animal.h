//
//  Animal.h
//  TestProject
//
//  Created by remain on 2018/3/20.
//  Copyright © 2018年 remain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject {
    @public
    NSString *name;
    @private
    NSString *world;
}

@property (copy, nonatomic) NSString *overloadProperty;

- (void)test;

- (void)foo;

@end
