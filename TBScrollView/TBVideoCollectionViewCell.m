//
//  TBVideoCollectionViewCell.m
//  TestProject
//
//  Created by 金泉斌 on 2018/4/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "TBVideoCollectionViewCell.h"
#import "TBVideoControlView.h"

@interface TBVideoCollectionViewCell () <ZFPlayerDelegate>

@property (strong, nonatomic) UIView *maskView;

@end

@implementation TBVideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _player.delegate = self;
    _player.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
}

- (void)setVideoModel:(SCScrollVideoModel *)videoModel {
    if (_videoModel != videoModel) {
        _videoModel = videoModel;
        ZFPlayerModel *model = [[ZFPlayerModel alloc] init];
        model.videoURL = [NSURL URLWithString:videoModel.videoURL];
        model.fatherView = self.contentView;
        model.placeholderImageURLString = videoModel.shotImageURL;
        
        [_player playerControlView:[TBVideoControlView new] playerModel:model];
    }
}

- (void)setFullScreen:(BOOL)fullScreen {
    _fullScreen = fullScreen;
    if (fullScreen) {
        [self showControlViews];
        self.player.userInteractionEnabled = true;
    } else {
        [self hideControlViews];
        self.player.userInteractionEnabled = false;
    }
}

- (void)showControlViews {
    UIView *controlView = [_player valueForKey:@"controlView"];
//    controlView.hidden = false;
}

- (void)hideControlViews {
    UIView *controlView = [_player valueForKey:@"controlView"];
//    controlView.hidden = true;
}

@end
