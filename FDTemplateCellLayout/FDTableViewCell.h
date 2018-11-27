//
//  FDTableViewCell.h
//  TestProject
//
//  Created by quanbinjin on 2018/6/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDTableViewCell : UITableViewCell

- (void)configTitle:(NSString *)title
            content:(NSString *)content
                pic:(BOOL)show;

@end
