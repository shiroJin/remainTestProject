//
//  TBScrollView.h
//  TestProject
//
//  Created by remain on 2018/4/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCScrollModel.h"

@interface TBScrollView : UIView

@property (nonatomic, strong) SCScrollModel *model;

- (instancetype)initWithFrame:(CGRect)frame dataModel:(SCScrollModel *)model;

@end
