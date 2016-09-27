//
//  ZJScrollSegmentView.h
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSegmentStyle.h"
#import "ZJScrollPageViewDelegate.h"
@class ZJSegmentStyle;
@class ZJTitleView;

typedef void(^TitleBtnOnClickBlock)(ZJTitleView *titleView, NSInteger index);
typedef void(^ExtraBtnOnClick)(UIButton *extraBtn);

@interface ZJScrollSegmentView : UIView

// 所有的标题
@property (strong, nonatomic) NSArray *titles;
// 所有标题的设置
@property (strong, nonatomic) ZJSegmentStyle *segmentStyle;
@property (copy, nonatomic) ExtraBtnOnClick extraBtnOnClick;
@property (weak, nonatomic) id<ZJScrollPageViewDelegate> delegate;
@property (strong, nonatomic) UIImage *backgroundImage;

// 所有的子控制器(需要遵守ZJScrollPageViewChildVcDelegate协议)
@property (weak, nonatomic) NSMutableDictionary<NSString *, UIViewController<ZJScrollPageViewChildVcDelegate> *> *childVcsDic;


- (instancetype)initWithFrame:(CGRect )frame segmentStyle:(ZJSegmentStyle *)segmentStyle delegate:(id<ZJScrollPageViewDelegate>)delegate titles:(NSArray *)titles titleDidClick:(TitleBtnOnClickBlock)titleDidClick;


/** 点击按钮的时候调整UI*/
- (void)adjustUIWhenBtnOnClickWithAnimate:(BOOL)animated;
/** 切换下标的时候根据progress同步设置UI*/
- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex;
/** 让选中的标题居中*/
- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex;
/** 设置选中的下标*/
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;
/** 重新刷新标题的内容*/
- (void)reloadTitlesWithNewTitles:(NSArray *)titles;

@end
