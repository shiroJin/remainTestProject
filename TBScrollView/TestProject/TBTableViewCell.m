//
//  TBTableViewCell.m
//  TestProject
//
//  Created by remain on 2018/4/20.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "TBTableViewCell.h"

@interface TBTableViewCell ()

@end

@implementation TBTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected anuimated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    self.scrollView.frame = (CGRect){CGPointZero, rect.size};
}

- (TBScrollView *)scrollView {
    if (!_scrollView) {
        TBScrollView *scrollView = [[TBScrollView alloc] init];
        _scrollView = scrollView;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

@end
