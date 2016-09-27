//
//  ZJContentView.h
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"
@class ZJScrollSegmentView;
@class ZJContentView;

@interface ZJContentView : UIView

/** 必须设置代理和实现相关的方法*/
@property(weak, nonatomic)id<ZJScrollPageViewDelegate> delegate;

// 所有的子控制器(需要遵守ZJScrollPageViewChildVcDelegate协议)
@property (strong, nonatomic, readonly) NSMutableDictionary<NSString *, UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcsDic;


/**初始化方法
 *
 */
- (instancetype)initWithFrame:(CGRect)frame segmentView:(ZJScrollSegmentView *)segmentView parentViewController:(UIViewController *)parentViewController delegate:(id<ZJScrollPageViewDelegate>) delegate;

/** 给外界可以设置ContentOffSet的方法 */
- (void)setContentOffSet:(CGPoint)offset animated:(BOOL)animated;
/** 给外界 重新加载内容的方法 */
- (void)reload;
@end
