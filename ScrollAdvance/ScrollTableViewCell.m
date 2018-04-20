//
//  ScrollTableViewCell.m
//  TestProject
//
//  Created by remain on 2018/4/18.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "ScrollTableViewCell.h"

@interface ScrollTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;
@property (weak, nonatomic) IBOutlet UIImageView *image4;
@property (weak, nonatomic) IBOutlet UIImageView *image5;

@end

@implementation ScrollTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _image1.layer.cornerRadius = 10.0f;
    _image2.layer.cornerRadius = 10.0f;
    _image3.layer.cornerRadius = 10.0f;
    _image4.layer.cornerRadius = 10.0f;
    _image5.layer.cornerRadius = 10.0f;
    
    _image1.layer.masksToBounds = true;
    _image2.layer.masksToBounds = true;
    _image3.layer.masksToBounds = true;
    _image4.layer.masksToBounds = true;
    _image5.layer.masksToBounds = true;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImage:(UIImage *)image {
    _image1.image = image;
    _image2.image = image;
    _image3.image = image;
    _image4.image = image;
    _image5.image = image;
    
//    for (int i = 0; i < 1000; i++) {
//        @autoreleasepool {
//            NSString *string = [NSString stringWithFormat:@"hello world"];
//        }
//    }
}

@end
