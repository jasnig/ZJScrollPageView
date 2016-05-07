//
//  ZJScrollPageView.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJScrollPageView.h"

@interface ZJScrollPageView ()
@property (strong, nonatomic) ZJSegmentStyle *segmentStyle;
@property (weak, nonatomic) ZJScrollSegmentView *segmentView;
@property (weak, nonatomic) ZJContentView *contentView;

@property (weak, nonatomic) UIViewController *parentViewController;
@property (strong, nonatomic) NSArray *childVcs;
@property (strong, nonatomic) NSArray *titlesArray;

@end
@implementation ZJScrollPageView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame segmentStyle:(ZJSegmentStyle *)segmentStyle childVcs:(NSArray *)childVcs parentViewController:(UIViewController *)parentViewController {
    
    if (self = [super initWithFrame:frame]) {
        self.childVcs = childVcs;
        self.segmentStyle = segmentStyle;
        self.parentViewController = parentViewController;
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
 
    NSMutableArray *tempTitles = [NSMutableArray array];
    for (UIViewController *childVc in self.childVcs) {
        NSAssert(childVc.title, @"子控制器的title没有正确设置!!");
        if (childVc.title) {
            [tempTitles addObject:childVc.title];
        }
    }
    
    self.titlesArray = [NSArray arrayWithArray:tempTitles];
    
    // 触发懒加载
    self.segmentView.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    NSLog(@"ZJScrollPageView--销毁");
}

#pragma mark - public helper

/** 给外界设置选中的下标的方法 */
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    [self.segmentView setSelectedIndex:selectedIndex animated:animated];
}

/**  给外界重新设置视图内容的标题的方法 */
- (void)reloadChildVcsWithNewChildVcs:(NSArray *)newChildVcs {
    
    self.childVcs = nil;
    self.titlesArray = nil;
    self.childVcs = newChildVcs;
    
    NSMutableArray *tempTitles = [NSMutableArray array];
    for (UIViewController *childVc in self.childVcs) {
        NSAssert(childVc.title, @"子控制器的title没有正确设置!!");
        if (childVc.title) {
            [tempTitles addObject:childVc.title];
        }
    }
    self.titlesArray = [NSArray arrayWithArray:tempTitles];
    
    [self.segmentView reloadTitlesWithNewTitles:self.titlesArray];
    [self.contentView reloadAllViewsWithNewChildVcs:self.childVcs];
}


#pragma mark - getter ---- setter

- (ZJContentView *)contentView {
    if (!_contentView) {
        ZJContentView *content = [[ZJContentView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.segmentView.frame), self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(self.segmentView.frame)) childVcs:self.childVcs segmentView:self.segmentView parentViewController:self.parentViewController];
        [self addSubview:content];
        _contentView = content;
    }
    
    return  _contentView;
}


- (ZJScrollSegmentView *)segmentView {
    if (!_segmentView) {
        __weak typeof(self) weakSelf = self;
        ZJScrollSegmentView *segment = [[ZJScrollSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.segmentStyle.segmentHeight) segmentStyle:self.segmentStyle titles:self.titlesArray titleDidClick:^(UILabel *label, NSInteger index) {
            
            [weakSelf.contentView setContentOffSet:CGPointMake(weakSelf.contentView.bounds.size.width * index, 0.0) animated:NO];
            
        }];
        [self addSubview:segment];
        _segmentView = segment;
    }
    return _segmentView;
}


- (NSArray *)childVcs {
    if (!_childVcs) {
        _childVcs = [NSArray array];
    }
    return _childVcs;
}

- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = [NSArray array];
    }
    return _titlesArray;
}

- (void)setExtraBtnOnClick:(ExtraBtnOnClick)extraBtnOnClick {
    _extraBtnOnClick = extraBtnOnClick;
    self.segmentView.extraBtnOnClick = extraBtnOnClick;
}

@end
