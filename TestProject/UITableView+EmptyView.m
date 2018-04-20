//
//  UITableView+EmptyView.m
//  TestProject
//
//  Created by remain on 2018/3/9.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "UITableView+EmptyView.h"
#import <objc/runtime.h>

static NSString * const kEmptyKey = @"tableviewEmptyKey";

@implementation UITableView (EmptyView)

@dynamic emptyView;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method origin_reload = class_getInstanceMethod([self class], @selector(reloadData));
        Method empty_reload = class_getInstanceMethod([self class], @selector(empty_reloadData));
        method_exchangeImplementations(origin_reload, empty_reload);
    });
}

- (void)setEmptyView:(UIView *)emptyView {
    objc_setAssociatedObject(self, &kEmptyKey, emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)emptyView {
    return objc_getAssociatedObject(self, &kEmptyKey);
}

- (void)empty_reloadData {
    [self empty_reloadData];
    
    if (!self.emptyView) return;
    
    int rows = 0;
    for (int section = 0; section < [self numberOfSections]; section++) {
        rows += [self numberOfRowsInSection:section];
    }
    
    if (rows == 0) {
        self.emptyView.frame = self.bounds;
        [self addSubview:self.emptyView];
    } else {
        [self.emptyView removeFromSuperview];
    }
}

@end
