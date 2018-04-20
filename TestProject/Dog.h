//
//  Dog.h
//  TestProject
//
//  Created by remain on 2018/3/20.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "Animal.h"

@interface Dog : Animal

@property (copy, nonatomic) NSString *overloadProperty;

- (void)bark;

@end
