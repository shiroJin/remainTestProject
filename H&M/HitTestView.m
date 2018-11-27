//
//  HitTestView.m
//  TestProject
//
//  Created by quanbinjin on 2018/5/30.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "HitTestView.h"

@implementation HitTestView

- (void)awakeFromNib  {
    [super awakeFromNib];
    self.userInteractionEnabled = false;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    NSLog(@"%s\n%@", __func__, view);
    return [super hitTest:point withEvent:event];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
    return [super pointInside:point withEvent:event];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
