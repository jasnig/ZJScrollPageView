//
//  ZJContentView.h
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJScrollSegmentView;

@protocol ZJScrollPageViewDelegate <NSObject>
/** 将要显示的子页面的总数 */
- (NSInteger)numberOfChildViewControllers;

/** 获取到将要显示的页面的控制器
 * -reuseViewController : 这个是返回给你的controller, 你应该首先判断这个是否为nil, 如果为nil 创建对应的控制器并返回, 如果不为nil直接使用并返回
 * -index : 对应的下标
 */
- (UIViewController *)childViewController:(UIViewController *)reuseViewController forIndex:(NSInteger)index;

@end

@interface ZJContentView : UIView

/** 必须设置代理和实现相关的方法*/
@property(weak, nonatomic)id<ZJScrollPageViewDelegate> delegate;

/**初始化方法
 *
 */
- (instancetype)initWithFrame:(CGRect)frame segmentView:(ZJScrollSegmentView *)segmentView parentViewController:(UIViewController *)parentViewController delegate:(id<ZJScrollPageViewDelegate>) delegate;

/** 给外界可以设置ContentOffSet的方法 */
- (void)setContentOffSet:(CGPoint)offset animated:(BOOL)animated;
/** 给外界刷新视图的方法 */
- (void)reload;
@end
