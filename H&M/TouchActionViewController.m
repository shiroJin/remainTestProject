//
//  TouchActionViewController.m
//  TestProject
//
//  Created by quanbinjin on 2018/5/17.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "TouchActionViewController.h"

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
    [self foo];
}

- (IBAction)touchAction:(id)sender {
    ((UIButton *)sender).enabled = false;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 1000000; i++) {
            @autoreleasepool {
                __unused NSString *string = [NSString stringWithFormat:@"hello world !"];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            ((UIButton *)sender).enabled = true;
        });
        
        NSLog(@"hello world");
    });
}

- (void)foo {
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"beforeWaiting");
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopDefaultMode);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"======");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"events");
        NSLog(@"======");
    });
    
    NSLog(@"======");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 时间差.
        for (int i = 0; i < 1000; i++) {
            @autoreleasepool {
                __unused NSString *string = [NSString stringWithFormat:@"hello world !"];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"events2");
            NSLog(@"======");
        });
    });
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
