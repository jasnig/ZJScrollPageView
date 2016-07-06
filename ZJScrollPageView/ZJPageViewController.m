//
//  ZJPageViewController.m
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/7/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJPageViewController.h"

@interface ZJPageViewController ()

@end

@implementation ZJPageViewController

static NSString *cellId = @"cellId";

#pragma ZJScrollPageViewChildVcDelegate
// 每次页面出现的时候会调用
- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear: (BOOL)isFirstTime {
    [self.delegate setupScrollViewOffSetYWhenViewWillAppear:self.tableView];
    
    if(isFirstTime) {
        // 加载数据
    } else {
        //刷新...
    }
}
#pragma UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.delegate scrollViewIsScrolling:scrollView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    [self.tableView setContentInset:UIEdgeInsetsMake(200+64+44, 0, 0, 0)];
    [self.view addSubview:self.tableView];
}


#pragma UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"测试---- %ld", (long)indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
