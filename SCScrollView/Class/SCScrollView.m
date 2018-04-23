//
//  SCScrollView.m
//  TestProject
//
//  Created by remain on 2018/4/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "SCScrollView.h"
#import "SDCycleScrollView.h"
#import "ZFPlayer.h"

@interface SCScrollView () <SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
@property (strong, nonatomic) ZFPlayerView *player;
@property (strong, nonatomic) SCScrollModel *dataModel;

@end

@implementation SCScrollView

- (instancetype)initWithFrame:(CGRect)frame dataModel:(SCScrollModel *)model {
    if (self = [self initWithFrame:frame]) {
        _dataModel = model;
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds imageURLStringsGroup:model.flatMap];
        _cycleScrollView.autoScroll = false;
        _cycleScrollView.delegate = self;
        _cycleScrollView.showBottomBg = false;
        [self addSubview:_cycleScrollView];
    }
    return self;
}

#pragma mark - Accessor
- (ZFPlayerView *)player {
    if (!_player) {
        _player = [[ZFPlayerView alloc] init];
        _player.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    }
    return _player;
}

#pragma mark - SDCycleScrollView Delegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    if (index < self.dataModel.videoList.count) {
        [self videoAction:index];
    } else {
        // 放大图片
    }
}

#pragma mark - Event
- (void)videoAction:(NSInteger)index {
    if (self.player.state != ZFPlayerStatePlaying) {
        ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
        playerModel.videoURL = [NSURL URLWithString:[_dataModel.videoList[index] videoURLString]];
        playerModel.scrollView = [_cycleScrollView valueForKey:@"mainView"];
        playerModel.indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        playerModel.fatherViewTag = 100;
        [self.player resetToPlayNewVideo:playerModel];

        [self.player play];
    } else {
        [self.player pause];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
