//
//  FDTableViewCell.m
//  TestProject
//
//  Created by quanbinjin on 2018/6/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "FDTableViewCell.h"

@interface FDTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentTop;

@end

@implementation FDTableViewCell

- (void)configTitle:(NSString *)title
            content:(NSString *)content
                pic:(BOOL)show
{
    _title.text = title;
    _content.text = content;
    _contentTop.constant = show? 100 : 0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
