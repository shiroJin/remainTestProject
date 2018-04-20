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
@property (nonatomic, assign) CGRect originRect;
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation TBScrollView

- (instancetype)initWithFrame:(CGRect)frame dataModel:(SCScrollModel *)model {
    if (self = [self initWithFrame:frame]) {
        _model = model;
        _originRect = frame;
        _fullScreen = false;
        
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = frame.size;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing = 0.0f;
        _flowLayout.minimumLineSpacing = 0.0f;
        
        _collectonView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectonView.delegate = self;
        _collectonView.dataSource = self;
        _collectonView.pagingEnabled = true;
        [self addSubview:_collectonView];
        
        [_collectonView registerNib:[UINib nibWithNibName:@"TBImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"image"];
        [_collectonView registerNib:[UINib nibWithNibName:@"TBVideoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"video"];
    }
    return self;
}

#pragma mark - Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.flatMap.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _model.videoList.count) {
        TBVideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"video" forIndexPath:indexPath];
        [cell setVideoModel:_model.videoList[indexPath.row]];
        cell.fullScreen = self.isFullScreen;
        return cell;
    } else {
        TBImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image" forIndexPath:indexPath];
        [cell setImage:_model.flatMap[indexPath.row]];
        return cell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
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
    self.backgroundColor = [UIColor blackColor];

    CGRect fullScreenRect = [UIApplication sharedApplication].keyWindow.bounds;
    CGSize itemSize = fullScreenRect.size;
    [self setFrame:fullScreenRect];
    [self.flowLayout setItemSize:itemSize];
    [self.collectonView setFrame:fullScreenRect];
    
    NSArray *visibleCells = [_collectonView visibleCells];
    for (UITableViewCell *cell in visibleCells) {
        if ([cell isKindOfClass:[TBVideoCollectionViewCell class]]) {
            ((TBVideoCollectionViewCell *)cell).fullScreen = true;
        }
    }
    
    self.cancelBtn.hidden = false;
}

- (void)exitFullScreenMode {
    _fullScreen = false;
    self.backgroundColor = [UIColor whiteColor];
    
    CGRect originBounds = (CGRect){CGPointZero, _originRect.size};
    [self setFrame:_originRect];
    _flowLayout.itemSize = originBounds.size;
    [_collectonView setFrame:originBounds];
    
    NSArray *visibleCells = [_collectonView visibleCells];
    for (UITableViewCell *cell in visibleCells) {
        if ([cell isKindOfClass:[TBVideoCollectionViewCell class]]) {
            ((TBVideoCollectionViewCell *)cell).fullScreen = false;
        }
    }
    
    self.cancelBtn.hidden = true;
}

#pragma mark - Access

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
