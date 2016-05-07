//
//  ZJScrollSegmentView.h
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSegmentStyle.h"

@class ZJSegmentStyle;

typedef void(^TitleBtnOnClickBlock)(UILabel *label, NSInteger index);
typedef void(^ExtraBtnOnClick)(UIButton *extraBtn);

@interface ZJScrollSegmentView : UIView

@property (copy, nonatomic) ExtraBtnOnClick extraBtnOnClick;

@property (strong, nonatomic) UIImage *backgroundImage;

- (instancetype)initWithFrame:(CGRect )frame segmentStyle:(ZJSegmentStyle *)segmentStyle titles:(NSArray *)titles titleDidClick:(TitleBtnOnClickBlock)titleDidClick;
- (void)adjustUIWhenBtnOnClickWithAnimate:(BOOL)animated;
- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex;
- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex;
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;
- (void)reloadTitlesWithNewTitles:(NSArray *)titles;

@end
