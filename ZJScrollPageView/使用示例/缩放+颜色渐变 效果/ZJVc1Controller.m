//
//  ZJVc2Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc1Controller.h"
#import "ZJScrollPageView.h"

@interface ZJVc1Controller ()<ZJScrollPageViewDelegate>
@property(weak, nonatomic)ZJScrollPageView *scrollPageView;
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;

@end

@implementation ZJVc1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = YES;
    style.segmentViewBounces = NO;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    // 显示附加的按钮
    style.showExtraButton = YES;
    // 设置附加按钮的背景图片
    style.extraBtnBackgroundImageName = @"extraBtnBackgroundImage";
    
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
    CGRect scrollPageViewFrame = CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0);
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:_titles parentViewController:self delegate:self];
    self.scrollPageView = scrollPageView;
    // 额外的按钮响应的block
    __weak typeof(self) weakSelf = self;
    
    
    self.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
        weakSelf.title = @"点击了extraBtn";
        NSLog(@"点击了extraBtn");
        
    };
    [self.view addSubview:self.scrollPageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}


- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index {
    UIViewController *childVc = reuseViewController;
    if (childVc == nil) {
        childVc = [UIViewController new];
        
        if (index%2 == 0) {
            childVc.view.backgroundColor = [UIColor redColor];
        } else {
            childVc.view.backgroundColor = [UIColor cyanColor];

        }
        
    }
    return childVc;
}


- (void)dealloc
{
//        NSLog(@"%@-----test", self.description);

}


@end
