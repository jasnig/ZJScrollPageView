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
@property(strong, nonatomic)NSArray *data;

@end

@implementation ZJTableViewController
static NSString *cellId = @"cellId";

#pragma ZJScrollPageViewChildVcDelegate
// 每次页面出现的时候会调用
- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear: (BOOL)isFirstTime {
    [self.delegate setupScrollViewOffSetYWhenViewWillAppear:self.tableView];
    
    if(isFirstTime) {
        // 加载数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.data = @[@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa",@"sfa"];
            [self.tableView reloadData];
            // 加载完成后重新设置contentSize
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate setupScrollViewOffSetYWhenViewWillAppear:self.tableView];
                
            });
        });
        
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
    return self.data.count;
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
