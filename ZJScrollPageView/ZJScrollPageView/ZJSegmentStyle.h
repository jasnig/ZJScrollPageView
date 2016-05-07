//
//  ZJSegmentStyle.h
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZJSegmentStyle : NSObject

@property (assign, nonatomic, getter=isShowCover) BOOL showCover;
@property (assign, nonatomic, getter=isShowLine) BOOL showLine;
@property (assign, nonatomic, getter=isScaleTitle) BOOL scaleTitle;
@property (assign, nonatomic, getter=isScrollTitle) BOOL scrollTitle;
@property (assign, nonatomic, getter=isGradualChangeTitleColor) BOOL gradualChangeTitleColor;
@property (assign, nonatomic, getter=isShowExtraButton) BOOL showExtraButton;

@property (strong, nonatomic) NSString *extraBtnBackgroundImageName;

@property (assign, nonatomic) CGFloat scrollLineHeight;
@property (strong, nonatomic) UIColor *scrollLineColor;

@property (strong, nonatomic) UIColor *coverBackgroundColor;
@property (assign, nonatomic) CGFloat coverCornerRadius;
@property (assign, nonatomic) CGFloat coverHeight;

@property (assign, nonatomic) CGFloat titleMargin;
@property (strong, nonatomic) UIFont *titleFont;
@property (assign, nonatomic) CGFloat titleBigScale;

@property (strong, nonatomic) UIColor *normalTitleColor;
@property (strong, nonatomic) UIColor *selectedTitleColor;

@property (assign, nonatomic) CGFloat segmentHeight;



@end
