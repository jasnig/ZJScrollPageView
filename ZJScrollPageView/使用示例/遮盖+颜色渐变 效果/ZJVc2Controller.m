//
//  ViewController.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc2Controller.h"
#import "ZJScrollPageView.h"

@interface ZJVc2Controller ()<ZJScrollPageViewDelegate>

@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@end

@implementation ZJVc2Controller


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    // 缩放标题
    style.scaleTitle = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    // 设置附加按钮的背景图片
    self.childVcs = [NSArray arrayWithArray:[self setupChildVcAndTitle]];
    
    self.titles = @[@"新闻头条",
                    @"国际要闻",
                    @"体育",
                    @"中国足球",
                    @"汽车",
                    @"囧途旅游",
                    @"幽默搞笑",
                    @"视频",
                    @"无厘头",
                    @"美女图片",
                    @"今日房价",
                    @"头像",
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    [self.view addSubview:scrollPageView];
}


#pragma ZJScrollPageViewDelegate 代理方法
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    UIViewController *childVc = reuseViewController;
    // 首先要判断是否返回的为nil, 如果为nil才重新创建
    if (childVc == nil) {
        childVc = self.childVcs[index];
    }
    
    return childVc;
}


- (NSArray *)setupChildVcAndTitle {
    
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *vc4 = [UIViewController new];
    vc4.view.backgroundColor = [UIColor brownColor];
    
    UIViewController *vc5 = [UIViewController new];
    vc5.view.backgroundColor = [UIColor lightGrayColor];
    
    UIViewController *vc6 = [UIViewController new];
    vc6.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController *vc7 = [UIViewController new];
    vc7.view.backgroundColor = [UIColor cyanColor];
    
    UIViewController *vc8 = [UIViewController new];
    vc8.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *vc9 = [UIViewController new];
    vc9.view.backgroundColor = [UIColor purpleColor];
    
    UIViewController *vc10 = [UIViewController new];
    vc10.view.backgroundColor = [UIColor magentaColor];
    
    UIViewController *vc11 = [UIViewController new];
    vc11.view.backgroundColor = [UIColor whiteColor];
    
    UIViewController *vc12 = [UIViewController new];
    vc12.view.backgroundColor = [UIColor redColor];
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8, vc9 , vc10, vc11, vc12, nil];
    return childVcs;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
