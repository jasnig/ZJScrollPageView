//
//  ZJVc5Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc5Controller.h"
#import "ZJScrollPageView.h"
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
    // 同步调整遮盖或者滚动条的宽度
    style.adjustCoverOrLineWidth = YES;
    // 不滚动标题
    style.scrollTitle = NO;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
    self.titles = @[@"新闻头条",
                    @"国际要闻",
                    @"体育",
                    @"中国足球"
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    [self.view addSubview:scrollPageView];
}

- (NSArray *)setupChildVcAndTitle {
    
    UIViewController *vc1 = [self.storyboard instantiateViewControllerWithIdentifier:@"test"];
    vc1.view.backgroundColor = [UIColor redColor];
    vc1.title = @"新闻头条";
    
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    vc2.title = @"国际要闻";
    
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    vc3.title = @"体育";
    
    UIViewController *vc4 = [UIViewController new];
    vc4.view.backgroundColor = [UIColor brownColor];
    vc4.title = @"中国足球";
    
    UIViewController *vc5 = [UIViewController new];
    vc5.view.backgroundColor = [UIColor lightGrayColor];
    vc5.title = @"汽车";

    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2, vc3, vc4, vc5, nil];
    return childVcs;
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

@end
