//
//  ZJVc7Controller.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJVc7Controller.h"
#import "ZJScrollPageView.h"
@interface ZJVc7Controller ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@property (weak, nonatomic) ZJScrollPageView *scrollPageView;

@end

@implementation ZJVc7Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"效果示例";

    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示遮盖
    style.showCover = YES;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
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
    
    self.scrollPageView = scrollPageView;
    
    [self.view addSubview:self.scrollPageView];
}




- (IBAction)changeBtnOnClick:(UIBarButtonItem *)sender {
    // 只需要传入新的子控制器即可, 移除原来的等其他的内部已经处理好
    self.titles = [self setupNewTitles];
    
    [self.scrollPageView reloadWithNewTitles:self.titles];
    
}

- (NSArray *)setupNewTitles {
    
    NSMutableArray *tempt = [NSMutableArray array];
    for (int  i =0; i < 20; i++) {
        [tempt addObject:[NSString stringWithFormat:@"新标题%d",i]];
    }
    
    return tempt;
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
    // 设置自控制器的title属性, 以便于在自控制器中通过title来判断应该加载什么数据
    childVc.title = self.titles[index];
    return childVc;
}
@end
