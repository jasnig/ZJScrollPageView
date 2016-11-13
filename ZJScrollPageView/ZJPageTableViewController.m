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
@property(assign, nonatomic)NSInteger index;

@end

static NSString * const cellId = @"cellID";

@implementation ZJPageTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)zj_viewDidLoadForIndex:(NSInteger)index {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    self.data = [NSArray array];
    [self.view addSubview:self.tableView];
}

- (void)zj_viewDidAppearForIndex:(NSInteger)index {
    self.index = index;
    NSLog(@"已经出现   标题: --- %@  index: -- %ld", self.title, index);
    
    if (index%2==0) {
        self.view.backgroundColor = [UIColor blueColor];
    } else {
        self.view.backgroundColor = [UIColor greenColor];
        
    }
    // 加载数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.data = @[@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa"];
        [self.tableView reloadData];
//    });
}

//- (void)zj_viewDidDisappearForIndex:(NSInteger)index {
//    NSLog(@"已经消失   标题: --- %@  index: -- %ld", self.title, index);
//    
//}

#pragma mark- ZJScrollPageViewChildVcDelegate

#pragma mark- UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"测试---- %@-----%ld", self.data[indexPath.row],self.index];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"点击了%ld行----", indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
