//
//  ScrollViewController.m
//  TestProject
//
//  Created by remain on 2018/4/18.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "ScrollViewController.h"
#import "FPSLabel.h"
#import "ScrollTableViewCell.h"

@interface ScrollViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
}

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"ScrollTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 100.f;
    [self.view addSubview:_tableView];
    _tableView.panGestureRecognizer.cancelsTouchesInView = false;
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view);
    }];
    
//    FPSLabel *fpsLbl = [[FPSLabel alloc] init];
//    [self.view addSubview:fpsLbl];
//    [fpsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.equalTo(self.view);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(60);
//        make.top.equalTo(self.view).offset(20);
//    }];
    
    /**
      *  Add Runloop Observer
     **/
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopAllActivities, true, -0x7FFFFFFFF, runLoopObserverCallBack, NULL);
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    CFRelease(observer);

    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"hello world");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"async main");
        });
    });
     */
}

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    if (activity == kCFRunLoopEntry) {
        NSLog(@"runloop: Entry");
        
    } else if (activity == kCFRunLoopBeforeWaiting) {
        NSLog(@"runloop: BeforeWaiting");
        
    } else if (activity == kCFRunLoopAfterWaiting) {
        NSLog(@"runloop: AfterWaiting");
        
    } else if (activity == kCFRunLoopExit) {
        NSLog(@"runloop: Exit");
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"touches began");

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScrollTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setImage:[UIImage imageNamed:@"image1"]];
    return cell;
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
