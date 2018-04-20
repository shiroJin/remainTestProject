//
//  ViewController.m
//  TestProject
//
//  Created by remain on 2018/3/7.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+EmptyView.h"
#import "Dog.h"
#import "Animal.h"
#import "DispatchDelegate.h"
#import "ProgressView.h"
#import "Handler.h"
#import "Promise.h"
#import "Masonry.h"
#import <objc/runtime.h>

@interface SCLinkNode : NSObject

@property (nonatomic, strong) NSNumber *nodeValue;

@property (nonatomic, strong) SCLinkNode *nextNode;

@end

@implementation SCLinkNode

@end

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) void (^handler) (void);
@property (nonatomic, strong) Dog *dog;

@end

@implementation ViewController {
    @private
    UITableView *_tableView;
    int _numOfRow;
    DispatchDelegate *_dispatch;
    Dog *_dog1;
    Dog *_dog2;
    dispatch_queue_t _serial;
    Promise *_promise;
    
    @public
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    Dog *dog = [Dog new];
//    [dog foo];
    
    /*
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    NSLog(@"%d", __IPHONE_OS_VERSION_MIN_REQUIRED);
    NSLog(@"hello world");
#endif
    
    UIView *view = [UIView new];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor redColor];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.topMargin.equalTo(self.view).offset(100);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    unsigned int outCount = 0;
    Method *list = class_copyMethodList([MASConstraintMaker class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = list[i];
        NSLog(@"%@", NSStringFromSelector(method_getName(method)));
    }
    */
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) collectionViewLayout:flowLayout];
    [self.view addSubview:collection];
    collection.delegate = self;
    collection.dataSource = self;
    
    
//    [[[Promise resolveOnqueue:dispatch_get_main_queue() transaction:^(Next resolve, Next reject) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            resolve(@5);
//        });
//    }] then:^(Promise *promise) {
//        promise.rejectBlk(promise.value);
//    }] catch:^(Promise *promise) {
//        NSLog(@"%@", promise.value);
//    }];
    
//    NSObject *obj = [[NSObject alloc] init];
//    ProgressView *progressView = [[ProgressView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.view addSubview:progressView];
//    return;
    
//    SCLinkNode *one = [SCLinkNode new];
//    one.nodeValue = @1;
//    SCLinkNode *two = [SCLinkNode new];
//    two.nodeValue = @2;
//    SCLinkNode *three = [SCLinkNode new];
//    three.nodeValue = @3;
//
//    one.nextNode = two;
//    two.nextNode = three;
//
////    [self flipLinkList:one];
//    SCLinkNode *node = [self __flipLinkList:one];
//    NSLog(@"%@", node.nodeValue);
//
//    while (node != nil) {
//        NSLog(@"%@\n", node.nodeValue);
//        node = node.nextNode;
//    }
//
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 400)];
//    [self.view addSubview:_tableView];
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    _tableView.emptyView = ({
//        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        lbl.text = @"Hello world";
//        lbl.textAlignment = NSTextAlignmentCenter;
//        lbl.font = [UIFont boldSystemFontOfSize:20];
//        lbl;
//    });
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.frame = CGRectMake(200, 450, 60, 40);
//    [button setBackgroundColor:[UIColor grayColor]];
//    [button setTitle:@"reload" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//
//    Dog *dog = [Dog new];
//    [dog test];
//
//
//    NSLog(@"####### Dispatch Delegate");
//    _dispatch = [[DispatchDelegate alloc] init];
//    _dog1 = [Dog new];
//    _dog2 = [Dog new];
//    __weak Dog *dog3 = [Dog new];
//    [_dispatch registerDelegate:_dog1];
//    [_dispatch registerDelegate:_dog2];
//    [_dispatch registerDelegate:dog3];
//
//    [_dispatch performSelector:@selector(test)];

//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"sync");
//    });
//    NSLog(@"hello world");
//
//    _serial = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"foo foo");
//    });
//
//    [NSThread sleepForTimeInterval:10];
//    dispatch_sync(_serial, ^{
//        NSLog(@"foo");
//    });
//
//    dispatch_async(_serial, ^{
//        NSLog(@"foo");
//    });
//
//    dispatch_async(_serial, ^{
//        NSLog(@"foo");
//    });

//    [NSThread detachNewThreadWithBlock:^{
//        [self threadTest];
//    }];
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"foo");
//        });
//    });
//
//    for (int i = 0; i < 1000; i++) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
////            NSLog(@"foo");
//            NSString *foo = [NSString stringWithFormat:@"foo"];
//        });
//        dispatch_async(_serial, ^{
//            NSThread *thr = [NSThread currentThread];
//            NSLog(@"%@", thr);
//        });
//    }
}

- (void)threadTest {
    [[NSThread currentThread] setName:@"1"];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"foo");
    });
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"foo");
    });

    dispatch_sync(_serial, ^{
        NSLog(@"foo");
    });
    
    [NSThread detachNewThreadWithBlock:^{
        dispatch_sync(_serial, ^{
            NSLog(@"foo");
        });
    }];
    
    [NSThread sleepForTimeInterval:2];
}

- (void)reload {
    if (_numOfRow > 0) {
        _numOfRow = 0;
    } else {
        _numOfRow = 5;
    }
    
    [_tableView reloadData];
}

#pragma mark - Collection View

#pragma mark - Table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _numOfRow;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", indexPath];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (SCLinkNode *)__flipLinkList:(SCLinkNode *)header {
    if (header.nextNode == nil) {
        return header;
    }else {
        SCLinkNode *newNode = [self __flipLinkList:header.nextNode];
        header.nextNode = nil;
        newNode.nextNode = header;
        return newNode;
    }
}

- (SCLinkNode *)flipLinkList:(SCLinkNode *)header {
    SCLinkNode *preNode = nil;
    SCLinkNode *node = header;
    while (node != nil) {
        SCLinkNode *temp = preNode;
        preNode = node;
        node = node.nextNode;
        preNode.nextNode = temp;
    }
    return preNode;
}

@end
