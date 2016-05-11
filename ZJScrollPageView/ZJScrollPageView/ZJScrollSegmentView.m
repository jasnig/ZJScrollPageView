//
//  ZJScrollSegmentView.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJScrollSegmentView.h"
#import "ZJCustomLabel.h"
#import "UIView+ZJFrame.h"

@interface ZJScrollSegmentView () {
    CGFloat _currentWidth;
    NSUInteger _currentIndex;
    NSUInteger _oldIndex;
}
// 滚动条
@property (weak, nonatomic) UIView *scrollLine;
// 遮盖
@property (weak, nonatomic) UIView *coverLayer;
// 滚动scrollView
@property (weak, nonatomic) UIScrollView *scrollView;
// 背景ImageView
@property (weak, nonatomic) UIImageView *backgroundImageView;
// 附加的按钮
@property (weak, nonatomic) UIButton *extraBtn;
// 所有标题的设置
@property (strong, nonatomic) ZJSegmentStyle *segmentStyle;
// 所有的标题
@property (strong, nonatomic) NSArray *titles;
// 用于懒加载计算文字的rgb差值, 用于颜色渐变的时候设置
@property (strong, nonatomic) NSArray *deltaRGB;
@property (strong, nonatomic) NSArray *selectedColorRgb;
@property (strong, nonatomic) NSArray *normalColorRgb;
/** 缓存所有标题label */
@property (nonatomic, strong) NSMutableArray *titleLabels;
// 缓存计算出来的每个标题的宽度
@property (nonatomic, strong) NSMutableArray *titleWidths;
// 响应标题点击
@property (copy, nonatomic) TitleBtnOnClickBlock titleBtnOnClick;

@end

@implementation ZJScrollSegmentView
#define xGap 5.0
#define wGap 2*xGap

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect )frame segmentStyle:(ZJSegmentStyle *)segmentStyle titles:(NSArray *)titles titleDidClick:(TitleBtnOnClickBlock)titleDidClick {
    if (self = [super initWithFrame:frame]) {
        self.segmentStyle = segmentStyle;
        self.titles = titles;
        self.titleBtnOnClick = titleDidClick;
        _currentIndex = 0;
        _oldIndex = 0;
        _currentWidth = frame.size.width;
        
        if (!self.segmentStyle.isScrollTitle) { // 不能滚动的时候就不要把缩放和遮盖或者滚动条同时使用, 否则显示效果不好
            
            self.segmentStyle.scaleTitle = !(self.segmentStyle.isShowCover || self.segmentStyle.isShowLine);
        }
        
        // 设置了frame之后可以直接设置其他的控件的frame了, 不需要在layoutsubView()里面设置
        [self setupTitles];
        [self setupUI];

    }
    
    return self;
}

- (void)dealloc
{
    NSLog(@"ZJScrollSegmentView ---- 销毁");
}


#pragma mark - button action

- (void)titleLabelOnClick:(UITapGestureRecognizer *)tapGes {
    
    ZJCustomLabel *currentLabel = (ZJCustomLabel *)tapGes.view;
    
    if (!currentLabel) {
        return;
    }
    
    _currentIndex = currentLabel.tag;
    
    [self adjustUIWhenBtnOnClickWithAnimate:true];
}

- (void)extraBtnOnClick:(UIButton *)extraBtn {
    
    if (self.extraBtnOnClick) {
        self.extraBtnOnClick(extraBtn);
    }
}


#pragma mark - private helper

- (void)setupTitles {
    
    
    NSInteger index = 0;
    for (NSString *title in self.titles) {
        
        ZJCustomLabel *label = [[ZJCustomLabel alloc] initWithFrame:CGRectZero];
        label.tag = index;
        label.text = title;
        label.textColor = self.segmentStyle.normalTitleColor;
        label.font = self.segmentStyle.titleFont;
        label.textAlignment = NSTextAlignmentCenter;
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelOnClick:)];
        [label addGestureRecognizer:tapGes];
        CGRect bounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: label.font} context:nil];
        [self.titleWidths addObject:@(bounds.size.width)];
        [self.titleLabels addObject:label];
        [self.scrollView addSubview:label];
        
        index++;
        
    }
    
    
//    __weak typeof(self) weakSelf = self;
    //    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger index, BOOL * _Nonnull stop) {
    //        UILabel *label = [UILabel new];
    //        label.tag = index;
    //        label.text = title;
    //        label.textColor = weakSelf.segmentStyle.normalTitleColor;
    //        label.font = weakSelf.segmentStyle.titleFont;
    //        label.textAlignment = NSTextAlignmentCenter;
    //        label.userInteractionEnabled = YES;
    //        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:weakSelf action:@selector(titleLabelOnClick:)];
    //        [label addGestureRecognizer:tapGes];
    //        CGRect bounds = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: label.font} context:nil];
    //        [weakSelf.titleWidths addObject:@(bounds.size.width)];
    //        [weakSelf.titleLabels addObject:label];
    //        [weakSelf.scrollView addSubview:label];
    //    }];
}

- (void)setupUI {
    [self setupScrollViewAndExtraBtn];
    [self setUpLabelsPosition];
    [self setupScrollLineAndCover];
    
    if (self.segmentStyle.isScrollTitle) { // 设置滚动区域
        ZJCustomLabel *lastLabel = (ZJCustomLabel *)self.titleLabels.lastObject;
        
        if (lastLabel) {
            self.scrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame)+self.segmentStyle.titleMargin, 0.0);
        }
    }
    
}

- (void)setupScrollViewAndExtraBtn {
    CGFloat extraBtnW = 44.0;
    CGFloat extraBtnY = 5.0;
    CGFloat scrollW = self.extraBtn ? _currentWidth - extraBtnW : _currentWidth;
    self.scrollView.frame = CGRectMake(0.0, 0.0, scrollW, self.zj_height);
    if (self.extraBtn) {
        self.extraBtn.frame = CGRectMake(scrollW, extraBtnY, extraBtnW, self.zj_height - 2*extraBtnY);
    }
}


- (void)setUpLabelsPosition {
    CGFloat titleX = 0.0;
    CGFloat titleY = 0.0;
    CGFloat titleW = 0.0;
    CGFloat titleH = self.zj_height - self.segmentStyle.scrollLineHeight;
    
    if (!self.segmentStyle.isScrollTitle) {// 标题不能滚动, 平分宽度
        titleW = _currentWidth / self.titles.count;
        
        NSInteger index = 0;
        for (ZJCustomLabel *label in self.titleLabels) {
            
            titleX = index * titleW;
            
            label.frame = CGRectMake(titleX, titleY, titleW, titleH);
            index++;
            
        }
        
    } else {
        NSInteger index = 0;
        for (ZJCustomLabel *label in self.titleLabels) {
            
            titleW = [self.titleWidths[index] floatValue];
            titleX = self.segmentStyle.titleMargin;
            
            if (index != 0) {
                ZJCustomLabel *lastLabel = (ZJCustomLabel *)self.titleLabels[index - 1];
                titleX = CGRectGetMaxX(lastLabel.frame) + self.segmentStyle.titleMargin;
            }
            label.frame = CGRectMake(titleX, titleY, titleW, titleH);
            index++;
            
        }
        
    }
    
    ZJCustomLabel *firstLabel = (ZJCustomLabel *)self.titleLabels[0];
    
    if (firstLabel) {
        
        // 缩放, 设置初始的label的transform
        if (self.segmentStyle.isScaleTitle) {
            firstLabel.currentTransformSx = self.segmentStyle.titleBigScale;
        }
        // 设置初始状态文字的颜色
        firstLabel.textColor = self.segmentStyle.selectedTitleColor;
    }
    
}

- (void)setupScrollLineAndCover {
    
    ZJCustomLabel *firstLabel = (ZJCustomLabel *)self.titleLabels[0];
    CGFloat coverX = firstLabel.zj_x;
    CGFloat coverW = firstLabel.zj_width;
    CGFloat coverH = self.segmentStyle.coverHeight;
    CGFloat coverY = (self.bounds.size.height - coverH) * 0.5;
    
    if (self.scrollLine) {
        self.scrollLine.frame = CGRectMake(coverX , self.zj_height - self.segmentStyle.scrollLineHeight, coverW , self.segmentStyle.scrollLineHeight);
        
    }
    
    if (self.coverLayer) {
        
        if (self.segmentStyle.isScrollTitle) {
            self.coverLayer.frame = CGRectMake(coverX - xGap, coverY, coverW + wGap, coverH);
            
        } else {
            self.coverLayer.frame = CGRectMake(coverX, coverY, coverW, coverH);
            
        }
        
        
    }
        
}

#pragma mark - public helper

- (void)adjustUIWhenBtnOnClickWithAnimate:(BOOL)animated {
    if (_currentIndex == _oldIndex) { return; }
    
    ZJCustomLabel *oldLabel = (ZJCustomLabel *)self.titleLabels[_oldIndex];
    ZJCustomLabel *currentLabel = (ZJCustomLabel *)self.titleLabels[_currentIndex];

    [self adjustTitleOffSetToCurrentIndex:_currentIndex];
    
    CGFloat animatedTime = animated ? 0.3 : 0.0;
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animatedTime animations:^{
        oldLabel.textColor = weakSelf.segmentStyle.normalTitleColor;
        currentLabel.textColor = weakSelf.segmentStyle.selectedTitleColor;
        
        if (weakSelf.segmentStyle.isScaleTitle) {
            oldLabel.currentTransformSx = 1.0;
            currentLabel.currentTransformSx = weakSelf.segmentStyle.titleBigScale;
        }
        
        if (weakSelf.scrollLine) {
            weakSelf.scrollLine.zj_x = currentLabel.zj_x;
            weakSelf.scrollLine.zj_width = currentLabel.zj_width;
        }
        
        if (weakSelf.coverLayer) {
            if (weakSelf.segmentStyle.isScrollTitle) {
                
                weakSelf.coverLayer.zj_x = currentLabel.zj_x - xGap;
                weakSelf.coverLayer.zj_width = currentLabel.zj_width + wGap;
            } else {
                weakSelf.coverLayer.zj_x = currentLabel.zj_x;
                weakSelf.coverLayer.zj_width = currentLabel.zj_width;
            }
            
        }
        
    }];
    
    _oldIndex = _currentIndex;
    if (self.titleBtnOnClick) {
        self.titleBtnOnClick(currentLabel, _currentIndex);
    }
    
    
}

- (void)adjustUIWithProgress:(CGFloat)progress oldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex {
    _oldIndex = currentIndex;
    ZJCustomLabel *oldLabel = (ZJCustomLabel *)self.titleLabels[oldIndex];
    ZJCustomLabel *currentLabel = (ZJCustomLabel *)self.titleLabels[currentIndex];
    
    CGFloat xDistance = currentLabel.zj_x - oldLabel.zj_x;
    CGFloat wDistance = currentLabel.zj_width - oldLabel.zj_width;
    
    if (self.scrollLine) {
        self.scrollLine.zj_x = oldLabel.zj_x + xDistance * progress;
        self.scrollLine.zj_width = oldLabel.zj_width + wDistance * progress;
    }
    
    if (self.coverLayer) {
        if (self.segmentStyle.isScrollTitle) {
            self.coverLayer.zj_x = oldLabel.zj_x + xDistance * progress - xGap;
            self.coverLayer.zj_width = oldLabel.zj_width + wDistance * progress + wGap;
        } else {
            self.coverLayer.zj_x = oldLabel.zj_x + xDistance * progress;
            self.coverLayer.zj_width = oldLabel.zj_width + wDistance * progress;
        }
    }
    
    // 渐变
    if (self.segmentStyle.isGradualChangeTitleColor) {

        oldLabel.textColor = [UIColor colorWithRed:[self.selectedColorRgb[0] floatValue] + [self.deltaRGB[0] floatValue] * progress green:[self.selectedColorRgb[1] floatValue] + [self.deltaRGB[1] floatValue] * progress blue:[self.selectedColorRgb[2] floatValue] + [self.deltaRGB[2] floatValue] * progress alpha:1.0];
        currentLabel.textColor = [UIColor colorWithRed:[self.normalColorRgb[0] floatValue] - [self.deltaRGB[0] floatValue] * progress green:[self.normalColorRgb[1] floatValue] - [self.deltaRGB[1] floatValue] * progress blue:[self.normalColorRgb[2] floatValue] - [self.deltaRGB[2] floatValue] * progress alpha:1.0];
        
    }
    
    if (!self.segmentStyle.isScaleTitle) {
        return;
    }
    
    CGFloat deltaScale = self.segmentStyle.titleBigScale - 1.0;
    oldLabel.currentTransformSx = self.segmentStyle.titleBigScale - deltaScale * progress;
    currentLabel.currentTransformSx = 1.0 + deltaScale * progress;
    
    
}

- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex {
    ZJCustomLabel *currentLabel = (ZJCustomLabel *)self.titleLabels[currentIndex];
    
    CGFloat offSetx = currentLabel.center.x - _currentWidth * 0.5;
    if (offSetx < 0) {
        offSetx = 0;
    }
    CGFloat extraBtnW = self.extraBtn ? self.extraBtn.zj_width : 0.0;
    CGFloat maxOffSetX = self.scrollView.contentSize.width - (_currentWidth - extraBtnW);
    
    if (maxOffSetX < 0) {
        maxOffSetX = 0;
    }
    
    if (offSetx > maxOffSetX) {
        offSetx = maxOffSetX;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offSetx, 0.0) animated:YES];
    
    if (!self.segmentStyle.isGradualChangeTitleColor) {
        NSInteger index = 0;
        for (ZJCustomLabel *label in self.titleLabels) {
            if (index == currentIndex) {
                label.textColor = self.segmentStyle.selectedTitleColor;
            } else {
                label.textColor = self.segmentStyle.normalTitleColor;
            }
            index++;
        }
    }
    
}

- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated {
    NSAssert(index >= 0 && index < self.titles.count, @"设置的下标不合法!!");

    if (index < 0 || index >= self.titles.count) {
        return;
    }
    
    _currentIndex = index;
    [self adjustUIWhenBtnOnClickWithAnimate:animated];
}

- (void)reloadTitlesWithNewTitles:(NSArray *)titles {
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 将子控件置为nil 否则懒加载会不正常
    _scrollLine = nil;
    _coverLayer = nil;
    
    self.titleWidths = nil;
    self.titleLabels = nil;
    self.titles = nil;
    self.titles = titles;
    
    [self setupTitles];
    [self setupUI];
    [self setSelectedIndex:0 animated:YES];
    
}


#pragma mark - getter --- setter

- (UIView *)scrollLine {
    
    if (!self.segmentStyle.isShowLine) {
        return nil;
    }
    
    if (!_scrollLine) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = self.segmentStyle.scrollLineColor;

        [self.scrollView addSubview:lineView];
        _scrollLine = lineView;
        
    }
    
    return _scrollLine;
}

- (UIView *)coverLayer {
    if (!self.segmentStyle.isShowCover) {
        return nil;
    }
    
    if (_coverLayer == nil) {
        UIView *coverView = [[UIView alloc] init];
        coverView.backgroundColor = self.segmentStyle.coverBackgroundColor;
        coverView.layer.cornerRadius = self.segmentStyle.coverCornerRadius;
        coverView.layer.masksToBounds = YES;
        [self.scrollView insertSubview:coverView atIndex:0];

        _coverLayer = coverView;
        
    }
    
    return _coverLayer;
}

- (UIButton *)extraBtn {
    
    if (!self.segmentStyle.showExtraButton) {
        return nil;
    }
    if (!_extraBtn) {
        UIButton *btn = [UIButton new];
        [btn addTarget:self action:@selector(extraBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString *imageName = self.segmentStyle.extraBtnBackgroundImageName ? self.segmentStyle.extraBtnBackgroundImageName : @"";
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        // 设置边缘的阴影效果
        btn.layer.shadowColor = [UIColor whiteColor].CGColor;
        btn.layer.shadowOffset = CGSizeMake(-5, 0);
        btn.layer.shadowOpacity = 1;
        
        [self addSubview:btn];
        _extraBtn = btn;
    }
    return _extraBtn;
}


- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = YES;
        scrollView.pagingEnabled = NO;
        // weak 需要强引用
        [self addSubview:scrollView];
        
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIImageView *)backgroundImageView {
    
    if (!_backgroundImageView) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self insertSubview:imageView atIndex:0];

        _backgroundImageView = imageView;
    }
    return _backgroundImageView;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    if (backgroundImage) {
        self.backgroundImageView.image = backgroundImage;
    }
}

- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (NSMutableArray *)titleWidths
{
    if (_titleWidths == nil) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}

- (NSArray *)deltaRGB {
    if (_deltaRGB == nil) {
        NSArray *normalColorRgb = self.normalColorRgb;
        NSArray *selectedColorRgb = self.selectedColorRgb;
        
        NSArray *delta;
        if (normalColorRgb && selectedColorRgb) {
            CGFloat deltaR = [normalColorRgb[0] floatValue] - [selectedColorRgb[0] floatValue];
            CGFloat deltaG = [normalColorRgb[1] floatValue] - [selectedColorRgb[1] floatValue];
            CGFloat deltaB = [normalColorRgb[2] floatValue] - [selectedColorRgb[2] floatValue];
            delta = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), nil];
            _deltaRGB = delta;

        }
    }
    return _deltaRGB;
}


- (NSArray *)normalColorRgb {
    if (!_normalColorRgb) {
        NSArray *normalColorRgb = [self getColorRgb:self.segmentStyle.normalTitleColor];
        NSAssert(normalColorRgb, @"设置普通状态的文字颜色时 请使用RGB空间的颜色值");
        _normalColorRgb = normalColorRgb;
        
    }
    return  _normalColorRgb;
}

- (NSArray *)selectedColorRgb {
    if (!_selectedColorRgb) {
        NSArray *selectedColorRgb = [self getColorRgb:self.segmentStyle.selectedTitleColor];
        NSAssert(selectedColorRgb, @"设置选中状态的文字颜色时 请使用RGB空间的颜色值");
        _selectedColorRgb = selectedColorRgb;
        
    }
    return  _selectedColorRgb;
}

- (NSArray *)getColorRgb:(UIColor *)color {
    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbComponents;
    if (numOfcomponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), nil];
    }
    return rgbComponents;
    
}


@end


