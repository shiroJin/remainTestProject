//
//  DispatchDelegate.h
//  TestProject
//
//  Created by remain on 2018/3/22.
//  Copyright © 2018年 remain. All rights reserved.
//

#import <Foundation/Foundation.h>

/// runtime dispatch delegate method to delegates;
/// for example, foo has a delegate (1 to 1), set dispatchDelegate as foo's delegate, then register sub delegates into dispatch pool. method will be forward to sub delegats. sub delegates weak reference.
@interface DispatchDelegate : NSObject

- (void)registerDelegate:(id)delegate;

- (void)withdrawDelegate:(id)delegate;

@end
