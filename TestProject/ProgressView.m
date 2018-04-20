//
//  ProgressView.m
//  TestProject
//
//  Created by remain on 2018/3/27.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self makeUI];
}

- (void)makeUI {
    CAGradientLayer *bg = [CAGradientLayer layer];
    bg.frame = CGRectMake(0, 0, 100, 100);
    bg.colors = @[(id)[UIColor redColor].CGColor, (id)[UIColor yellowColor].CGColor];
    bg.locations = @[@0, @1];
    [self.layer addSublayer:bg];
    
    UIBezierPath *center = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(25, 25, 50, 50)];
    center = [center bezierPathByReversingPath];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [center appendPath:path];
    UIBezierPath *result = center;
    
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = result.CGPath;
    
    bg.mask = mask;
}

@end
