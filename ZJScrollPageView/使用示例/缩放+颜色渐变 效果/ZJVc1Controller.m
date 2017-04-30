//
//  ZJVc2Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc1Controller.h"
#import "ZJScrollPageView.h"
#import "ZJTestViewController.h"
#import "ZJTest1Controller.h"
@interface ZJVc1Controller ()<ZJScrollPageViewDelegate>
@property(weak, nonatomic)ZJScrollPageView *scrollPageView;
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcs;

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
    style.segmentHeight = 60;
    
    style.autoAdjustTitlesWidth = NO;
    
//    style.segmentViewComponent = SegmentViewComponentShowCover |  SegmentViewComponentShowExtraButton | SegmentViewComponentGraduallyChangeTitleColor;
    // 当标题宽度总和小于ZJScrollPageView的宽度的时候, 标题会自适应宽度
    
    __weak typeof(self) weakSelf = self;

    // 初始化
    CGRect scrollPageViewFrame = CGRectMake(0, 64.0, self.view.bounds.size.width, self.view.bounds.size.height - 64.0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        
        strongSelf.titles = @[@"新闻头条",
                              @"国际要闻",
                              @"中国足球"
                              ];
        
        ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:scrollPageViewFrame segmentStyle:style titles:_titles parentViewController:strongSelf delegate:strongSelf];
        strongSelf.scrollPageView = scrollPageView;
        // 额外的按钮响应的block
        
//        [strongSelf.scrollPageView setSelectedIndex:1 animated:true];
        
        strongSelf.scrollPageView.extraBtnOnClick = ^(UIButton *extraBtn){
            weakSelf.title = @"点击了extraBtn";
            NSLog(@"点击了extraBtn");
            
        };
        [strongSelf.view addSubview:strongSelf.scrollPageView];
        
    });

    

}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma <#arguments#>
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    // 根据不同的下标或者title返回相应的控制器, 但是控制器必须要遵守ZJScrollPageViewChildVcDelegate
    // 并且可以通过实现协议中的方法来加载不同的数据
    /**
     * 请注意: 如果你希望所有的子控制器的view的系统生命周期方法被正确的调用
     * 请重写父控制器的'shouldAutomaticallyForwardAppearanceMethods'方法 并且返回NO
     * 当然如果你不做这个操作, 子控制器的生命周期方法将不会被正确的调用
     * 如果你仍然想利用子控制器的生命周期方法, 请使用'ZJScrollPageViewChildVcDelegate'提供的代理方法
     * 或者'ZJScrollPageViewDelegate'提供的代理方法
     */
    NSLog(@"%ld---------", index);
    if (index == 0) {
        // 注意这个效果和tableView的deque...方法一样, 会返回一个可重用的childVc
        // 请首先判断返回给你的是否是可重用的
        // 如果为nil就重新创建并返回
        // 如果不为nil 直接使用返回给你的reuseViewController并进行需要的设置 然后返回即可
        ZJTestViewController *childVc = (ZJTestViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ZJTestViewController alloc] init];
            childVc.view.backgroundColor = [UIColor yellowColor];
        }
        return childVc;
        
    } else if (index == 1) {
        ZJTestViewController *childVc = (ZJTestViewController *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ZJTestViewController alloc] init];
            childVc.view.backgroundColor = [UIColor redColor];
        }

        return childVc;
    } else {
        ZJTest1Controller *childVc = (ZJTest1Controller *)reuseViewController;
        if (childVc == nil) {
            childVc = [[ZJTest1Controller alloc] init];
            childVc.view.backgroundColor = [UIColor greenColor];
        }
        
        if (index%2==0) {
            childVc.view.backgroundColor = [UIColor orangeColor];
        }

        return childVc;
    }
}



- (void)dealloc
{
//        NSLog(@"%@-----test", self.description);

}


@end
