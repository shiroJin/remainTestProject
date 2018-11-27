//
//  TouchActionViewController.m
//  TestProject
//
//  Created by quanbinjin on 2018/5/17.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "TouchActionViewController.h"
#import "NotificationViewController.h"
#import "HitTestView.h"


//#define onExit(btn) \
//UIButton *button = btn; \
//button.enabled = false; \
//void (^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^{ \
//NSLog(@"cleanup"); \
//button.enabled = true; \
//}; \
//
//static void blockCleanUp(__strong void (^*block)(void)) {
//    (*block)();
//}

@interface TouchActionViewController ()

@end

@implementation TouchActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self runloopObserve];
}

- (void)onNotification {
    NSLog(@"receieve notification");
}

- (IBAction)touchAction:(UIButton *)sender {
    [self exampleOfSubmitConfig];
}

- (IBAction)present:(UIButton *)sender {
}

//    ((UIButton *)sender).enabled = false;
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (int i = 0; i < 1000000; i++) {
//            @autoreleasepool {
//                __unused NSString *string = [NSString stringWithFormat:@"hello world !"];
//            }
//        }
//        dispatch_async(dispatch_get_main_queue(), ^{
//            ((UIButton *)sender).enabled = true;
//        });
//
//        NSLog(@"hello world");
//    });

- (void)foo {
    NSLog(@"%ld", sizeof(NSInteger));
}

- (void)runloopObserve {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAfterWaiting | kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        if (activity & kCFRunLoopBeforeWaiting) {
            NSLog(@"runloop before waiting");
        } else {
            NSLog(@"runloop after waiting");
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
}

- (void)exampleOfSubmitConfig {
    NSLog(@"ui");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"events");
    });
}

/**
 *  int类型转化二进制数据
 **/
- (void)exampleOfIntToData {
    int number = -4;
    Byte bytes[4];
    for (int i = 0; i < 4; i++) {
        bytes[i] = (number >> 8 * (3 - i)) & 0xFF;
    }
    NSData *data = [NSData dataWithBytes:bytes length:4];
    NSLog(@"%@", data);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
