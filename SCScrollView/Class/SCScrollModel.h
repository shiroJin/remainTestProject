//
//  SCScrollModel.h
//  TestProject
//
//  Created by remain on 2018/4/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCScrollVideoModel : NSObject

@property (copy, nonatomic) NSString *shotImageURL;
@property (copy, nonatomic) NSString *videoURL;

@end

@interface SCScrollModel : NSObject

@property (copy, nonatomic) NSArray <SCScrollVideoModel *> *videoList;

@property (copy, nonatomic) NSArray <NSString *> *imageList;

- (instancetype)initWithVideoList:(NSArray<SCScrollVideoModel *> *)videos images:(NSArray<NSString *> *)imgs;
    
- (NSArray *)flatMap;

@end
