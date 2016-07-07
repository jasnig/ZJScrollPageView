//
//  ZJTableViewController.m
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/7/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTableViewController.h"

@interface ZJTableViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic)UITableView *tableView;

@end

@implementation ZJTableViewController
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
    // 这个设置上面的内容偏移量为ZJVc9Controller里面定义的常量defaultOffSetY
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


- (UIScrollView *)scrollView {
    return self.tableView;
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
