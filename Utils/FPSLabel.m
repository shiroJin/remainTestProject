//
//  FPSLabel.m
//  TestProject
//
//  Created by remain on 2018/4/18.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "FPSLabel.h"

@implementation FPSLabel {
    CADisplayLink *_displayLink;
    UILabel *_fpsLbl;
    double time;
    int count;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateFPS)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        
        _fpsLbl = [UILabel new];
        _fpsLbl.textAlignment = NSTextAlignmentCenter;
        _fpsLbl.font = [UIFont systemFontOfSize:15];
        _fpsLbl.textColor = [UIColor redColor];
        [self addSubview:_fpsLbl];
    }
    return self;
}

- (void)updateFPS {
    double current = (double)[NSDate date].timeIntervalSince1970;
    double interval = current - time;
    count++;
    if (interval - 1.0f > __FLT_EPSILON__) {
        time = current;
        _fpsLbl.text = [NSString stringWithFormat:@"FPS: %d", count];
        count = 0;
    }
}

- (void)drawRect:(CGRect)rect {
    _fpsLbl.frame = (CGRect){CGPointZero, rect.size};
}

@end
