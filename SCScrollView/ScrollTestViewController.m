//
//  ScrollTestViewController.m
//  TestProject
//
//  Created by 金泉斌 on 2018/4/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "ScrollTestViewController.h"
#import "SCScrollView.h"
#import "TBScrollView.h"

#define videoPackage(video, shot) \
({SCScrollVideoModel *model = [[SCScrollVideoModel alloc] init]; \
model.shotImageURL = shot; \
model.videoURL = video; \
model; \
})

@interface ScrollTestViewController ()

@end

@implementation ScrollTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSArray *pics = @[@"http://cc.cocimg.com/api/uploads/180417/8821e2c1bfedd7367d4e79ec261f833a.png",
                      @"http://cc.cocimg.com/api/uploads/180417/abb4e0df2034b8d26d5e1b9bf57b7eb3.png",
                      @"http://cc.cocimg.com/api/uploads/180418/00ade475e9bfc14239ab989bc80dbf41.png",
                      @"http://cc.cocimg.com/api/uploads/180419/ec713d121c36b934de1aaffa2c4ff025.png"];
    NSArray *videos = @[videoPackage(@"http://svideo.spriteapp.com/video/2018/0417/9ffc405e41fd11e8a871842b2b4c75ab_wpd.mp4", @"http://cc.cocimg.com/api/uploads/180417/8821e2c1bfedd7367d4e79ec261f833a.png")];
    SCScrollModel *model = [[SCScrollModel alloc] initWithVideoList:videos images:pics];
    
    TBScrollView *scrollView = [[TBScrollView alloc] initWithFrame:CGRectMake(0, 20, width, 200) dataModel:model];
    [self.view addSubview:scrollView];
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
