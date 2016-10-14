//
//  TextViewController.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTestViewController.h"
#import "UIViewController+ZJScrollPageController.h"

@interface ZJTestViewController ()

@end

@implementation ZJTestViewController
- (IBAction)testBtnOnClick:(UIButton *)sender {
    [self showViewController:[ZJTestViewController new] sender:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    testBtn.backgroundColor = [UIColor whiteColor];
    [testBtn setTitle:@"点击" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(testBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:testBtn];
    NSLog(@"%@", self.zj_scrollViewController);
    NSLog(@"%@",self.view);
    self.zj_scrollViewController.title  = @"测试过";
}

- (void)zj_viewDidLoadForIndex:(NSInteger)index {
    NSLog(@"%@",self.view);
    NSLog(@"%@", self.zj_scrollViewController);

}
- (void)zj_viewWillAppearForIndex:(NSInteger)index {
    NSLog(@"viewWillAppear------");
    
}


- (void)zj_viewDidAppearForIndex:(NSInteger)index {
    NSLog(@"viewDidAppear-----");
    
}


- (void)zj_viewWillDisappearForIndex:(NSInteger)index {
    NSLog(@"viewWillDisappear-----");

}

- (void)zj_viewDidDisappearForIndex:(NSInteger)index {
    NSLog(@"viewDidDisappear--------");

}


- (void)dealloc
{
    NSLog(@"%@-----test---销毁", self.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
