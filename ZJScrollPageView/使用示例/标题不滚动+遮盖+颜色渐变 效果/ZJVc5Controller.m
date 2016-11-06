//
//  ZJVc5Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc5Controller.h"
#import "ZJScrollPageView.h"
#import "ZJTestViewController.h"

@interface ZJVc5Controller ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation ZJVc5Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = YES;

    // 根据title总宽度自动调整位置 -- 达到个数少的时候会'平分'的效果, 个数多的时候就是可以滚动的效果 只有当scrollTitle == YES的时候才有效
//    style.autoAdjustTitlesWidth = YES;
    // 不滚动标题
    style.scrollTitle = NO;
    // 同步调整遮盖或者滚动条的宽度 -- 只有当scrollTitle == NO的时候有效
    //    style.adjustCoverOrLineWidth = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
//    style.showExtraButton = YES;
    self.titles = @[@"新闻头条",
                    @"国际要闻",
                    @"体育",
                    @"中国足球"
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    NSLog(@"%@", self.view);
    
//    scrollPageView.extraBtnOnClick = ^(UIButton *btn){
//        NSLog(@"ffff");
//    };
    [self.view addSubview:scrollPageView];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}


- (void)setUpTitleView:(ZJTitleView *)titleView forIndex:(NSInteger)index {
//    titleView.label.backgroundColor = [UIColor redColor];
    titleView.label.layer.cornerRadius = 15;
    titleView.label.layer.masksToBounds = YES;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        childVc = [[ZJTestViewController alloc] init];
    }
    
    return childVc;
}

@end
