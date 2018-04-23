//
//  TBScrollView.m
//  TestProject
//
//  Created by remain on 2018/4/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "TBScrollView.h"
#import "TBImageCollectionViewCell.h"
#import "TBVideoCollectionViewCell.h"

@interface TBScrollView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectonView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, assign) UIView *originSuperview;
@property (nonatomic, assign) CGRect originFrame;
@property (nonatomic, weak) ZFPlayerView *player;
@property (nonatomic, assign, getter=isScrollPause) BOOL scrollPaused;

@end

@implementation TBScrollView

- (instancetype)initWithFrame:(CGRect)frame dataModel:(SCScrollModel *)model {
    if (self = [self initWithFrame:frame]) {
        _model = model;
        _fullScreen = false;
        
        [self.collectonView reloadData];
    }
    return self;
}

#pragma mark - Collection View

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    int index = offset / scrollView.frame.size.width;
    
    if (index >= 1 && _player.state == ZFPlayerStatePlaying) {
        [_player pause];
        _scrollPaused = true;
    }
    
    if (index == 0 && _scrollPaused) {
//        [_player play];
        _scrollPaused = false;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.flatMap.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _model.videoList.count) {
        TBVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"video" forIndexPath:indexPath];
        [cell setVideoModel:_model.videoList[indexPath.row]];
        cell.fullScreen = self.isFullScreen;
        // 设置播放器，划出可视区域后自动暂停。
        self.player = cell.player;
        return cell;
    } else {
        TBImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
        [cell setImage:_model.flatMap[indexPath.row]];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _model.videoList.count) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        if (cell && [cell isKindOfClass:[TBVideoCollectionViewCell class]]) {
            TBVideoCollectionViewCell *videoCell = (TBVideoCollectionViewCell *)cell;
            ZFPlayerView *player = videoCell.player;
            ZFPlayerState state = player.state;
            if (state == ZFPlayerStatePause) {
                [player play];
            } else if (state == ZFPlayerStateFailed) {
                [player autoPlayTheVideo];
            } else if (state == ZFPlayerStatePlaying) {
                if (!self.isFullScreen) {
                    [self enterFullScreenMode];
                } else {
                    [self exitFullScreenMode];
                }
            }
        }
    } else {
        if (!self.isFullScreen) {
            [self enterFullScreenMode];
        } else {
            [self exitFullScreenMode];
        }
    }
    
    [collectionView deselectItemAtIndexPath:indexPath animated:false];
}

- (void)enterFullScreenMode {
    _fullScreen = true;
    _originFrame = self.frame;

    _originSuperview = self.superview;
    [self removeFromSuperview];
    
    CGRect fullScreenRect = [UIApplication sharedApplication].keyWindow.bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setFrame:fullScreenRect];
    
    NSArray *visibleCells = [_collectonView visibleCells];
    for (UITableViewCell *cell in visibleCells) {
        if ([cell isKindOfClass:[TBVideoCollectionViewCell class]]) {
            ((TBVideoCollectionViewCell *)cell).fullScreen = true;
        }
    }
    
    self.backgroundColor = [UIColor blackColor];
    self.cancelBtn.hidden = false;
}

- (void)exitFullScreenMode {
    _fullScreen = false;
    self.backgroundColor = [UIColor whiteColor];
    
    [self removeFromSuperview];
    [_originSuperview addSubview:self];
    [self setFrame:self.originFrame];
    
    NSArray *visibleCells = [_collectonView visibleCells];
    for (UITableViewCell *cell in visibleCells) {
        if ([cell isKindOfClass:[TBVideoCollectionViewCell class]]) {
            ((TBVideoCollectionViewCell *)cell).fullScreen = false;
        }
    }
    
    self.cancelBtn.hidden = true;
}

#pragma mark - Access

- (void)setModel:(SCScrollModel *)model {
    _model = model;
    [_collectonView reloadData];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.flowLayout.itemSize = frame.size;
    self.collectonView.frame = (CGRect){CGPointZero, frame.size};
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        [_cancelBtn setTitle:@"X" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(exitFullScreenMode) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.top.equalTo(self).offset(20);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        _cancelBtn.hidden = true;
    }
    return _cancelBtn;
}

- (UICollectionView *)collectonView {
    if (!_collectonView) {
        _collectonView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectonView.delegate = self;
        _collectonView.dataSource = self;
        _collectonView.pagingEnabled = true;
        _collectonView.showsHorizontalScrollIndicator = false;
        if (@available(iOS 11, *)) {
            _collectonView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self addSubview:_collectonView];
        
        [_collectonView registerNib:[UINib nibWithNibName:@"TBImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"image"];
        [_collectonView registerNib:[UINib nibWithNibName:@"TBVideoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"video"];
    }
    return _collectonView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing = 0.0f;
        _flowLayout.minimumLineSpacing = 0.0f;
    }
    return _flowLayout;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
