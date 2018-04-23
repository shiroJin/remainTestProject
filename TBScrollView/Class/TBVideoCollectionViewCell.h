//
//  TBVideoCollectionViewCell.h
//  TestProject
//
//  Created by 金泉斌 on 2018/4/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCScrollModel.h"
#import "ZFPlayer.h"

@interface TBVideoCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) SCScrollVideoModel *videoModel;

@property (weak, nonatomic) IBOutlet ZFPlayerView *player;

@property (assign, nonatomic) BOOL fullScreen;

@end
