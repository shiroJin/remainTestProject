//
//  FDViewController.m
//  TestProject
//
//  Created by quanbinjin on 2018/6/19.
//  Copyright © 2018年 remain. All rights reserved.
//

#import "FDViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "FDTableViewCell.h"

@interface FDViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSArray *entity;

@end

@implementation FDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FDTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark - tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entity.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(FDTableViewCell *cell) {
        NSDictionary *dict = self.entity[indexPath.row];
        [cell configTitle:dict[@"title"] content:dict[@"content"] pic:[dict[@"show"] boolValue]];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dict = self.entity[indexPath.row];
    [cell configTitle:dict[@"title"] content:dict[@"content"] pic:[dict[@"show"] boolValue]];
    return cell;
}

- (NSArray *)entity {
    return @[
             @{@"title" : @"这是个标题",
               @"content" : @"Generally,\nno need to care about modes,\nit will automatically choose a proper mode \nby whether you have set auto \n\nlayout constrants on cell's content view.\nIf you want to enforce frame layout mode,\nenable this property in your cell's \nconfiguration block:",
               @"show" : @(NO)
               },
             @{@"title" : @"这是个标题",
               @"content" : @"Generally, no need to care about modes, it will automatically choose a proper mode by whether you have set auto layout constrants on cell's content view. If you want to enforce frame layout mode, enable this property in your cell's configuration block:",
               @"show" : @(YES)
               },
             @{@"title" : @"这是个标题,这是个标题,这是个标题,这是个标题,这是个标题,这是个标题,这是个标题,这是个标题,",
               @"content" : @"Generally, no need to care about modes",
               @"show" : @(NO)
               },
             @{@"title" : @"这是个标题,这是个标题,这是个标题,这是个标题,这是个标题,这是个标题,这是个标题,这是个标题,",
               @"content" : @"Generally, no need to care about modes",
               @"show" : @(YES)
               },
             ];
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
