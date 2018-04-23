//
//  SCScrollModel.m
//  TestProject
//
//  Created by remain on 2018/4/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "SCScrollModel.h"

@implementation SCScrollVideoModel @end

@implementation SCScrollModel

- (instancetype)initWithVideoList:(NSArray<SCScrollVideoModel *> *)videos images:(NSArray<NSString *> *)imgs {
    if (self = [self init]) {
        _videoList = videos;
        _imageList = imgs;
    }
    return self;
}

    
- (NSArray *)flatMap {
    NSMutableArray *list = [NSMutableArray array];
    for (SCScrollVideoModel *video in self.videoList) {
        [list addObject:video.coverURLString];
    }
    
    [list addObjectsFromArray:self.imageList];
    
    return list.copy;
}

@end
