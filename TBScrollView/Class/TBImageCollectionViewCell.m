//
//  TBImageCollectionViewCell.m
//  TestProject
//
//  Created by remain on 2018/4/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "TBImageCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TBImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TBImageCollectionViewCell

- (void)setImage:(NSString *)urlString {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:urlString]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
