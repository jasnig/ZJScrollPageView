//
//  ZJPageTableViewController.m
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/8/31.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJPageTableViewController.h"
@interface ZJPageTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSArray *data;

@end

static NSString * const cellId = @"cellID";

@implementation ZJPageTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    self.data = [NSArray array];
    [self.view addSubview:self.tableView];
}

#pragma mark- ZJScrollPageViewChildVcDelegate
// 每次页面出现的时候会调用
- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear: (BOOL)isFirstTime {
    
    if(isFirstTime) {
        // 加载数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.data = @[@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa"];
            [self.tableView reloadData];
        });
        
    } else {
        //刷新...
    }
}

#pragma mark- UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"测试---- %ld", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
