//
//  ZJContentView.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJContentView.h"
#import "ZJScrollSegmentView.h"
@interface ZJContentView ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate> {
    NSInteger _oldIndex;
    NSInteger _currentIndex;
    CGFloat   _oldOffSetX;
}
// 用于处理重用和内容的显示
@property (weak, nonatomic) UICollectionView *collectionView;
// collectionView的布局
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewLayout;
/** 避免循环引用*/
@property (weak, nonatomic) ZJScrollSegmentView *segmentView;

@property (weak, nonatomic) UIButton *extraBtn;
// 父类 用于处理添加子控制器  使用weak避免循环引用
@property (weak, nonatomic) UIViewController *parentViewController;
// 当这个属性设置为YES的时候 就不用处理 scrollView滚动的计算
@property (assign, nonatomic) BOOL forbidTouchToAdjustPosition;
// 所有的子控制器
@property (strong, nonatomic) NSArray *childVcs;
@end

@implementation ZJContentView
#define cellID @"cellID"

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.parentViewController.parentViewController && [self.parentViewController.parentViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)self.parentViewController.parentViewController;

        if (navi.visibleViewController == self.parentViewController) {// 当显示的是ScrollPageView的时候 只在第一个tag处执行pop手势

            return self.collectionView.contentOffset.x == 0;
        }
    }
    return YES;
}

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs segmentView:(ZJScrollSegmentView *)segmentView parentViewController:(UIViewController *)parentViewController {
    
    if (self = [super initWithFrame:frame]) {
        self.childVcs = childVcs;
        self.parentViewController = parentViewController;
        self.segmentView = segmentView;
        _oldIndex = 0;
        _currentIndex = 1;
        _oldOffSetX = 0.0;
        self.forbidTouchToAdjustPosition = NO;
        // 触发懒加载
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    for (UIViewController *childVc in self.childVcs) {
        if ([childVc isKindOfClass:[UINavigationController class]]) {
            NSAssert(NO, @"不要添加UINavigationController包装后的子控制器");
            
        }
        
        if (self.parentViewController) {
            [self.parentViewController addChildViewController:childVc];
        }
    }
    
    if (self.parentViewController.parentViewController && [self.parentViewController.parentViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)self.parentViewController.parentViewController;
        
        if (navi.interactivePopGestureRecognizer) {
            navi.interactivePopGestureRecognizer.delegate = self;
            [self.collectionView.panGestureRecognizer requireGestureRecognizerToFail:navi.interactivePopGestureRecognizer];
        }
    }
    // 发布通知 默认为0
    [self addCurrentShowIndexNotificationWithIndex:0];
    
}


- (void)dealloc {
    self.parentViewController = nil;
    NSLog(@"ZJContentView---销毁");
}

#pragma mark - public helper

/** 给外界可以设置ContentOffSet的方法 */
- (void)setContentOffSet:(CGPoint)offset animated:(BOOL)animated {
    self.forbidTouchToAdjustPosition = YES;
    [self.collectionView setContentOffset:offset animated:animated];
}

/** 给外界刷新视图的方法 */
- (void)reloadAllViewsWithNewChildVcs:(NSArray *)newChileVcs {
    // 这种处理是结束子控制器和父控制器的关系
    for (UIViewController *childVc in self.childVcs) {
        [childVc willMoveToParentViewController:nil];
        [childVc.view removeFromSuperview];
        [childVc removeFromParentViewController];
    }
    
    self.childVcs = nil;
    self.childVcs = newChileVcs;
    [self commonInit];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate --- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childVcs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    // 移除subviews 避免重用内容显示错误
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 这里建立子控制器和父控制器的关系  -> 当然在这之前已经将对应的子控制器添加到了父控制器了, 只不过还没有建立完成
    UIViewController *vc = (UIViewController *)self.childVcs[indexPath.row];
    vc.view.frame = self.bounds;
    [cell.contentView addSubview:vc.view];
    [vc didMoveToParentViewController:self.parentViewController];
    return cell;
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.forbidTouchToAdjustPosition) {
        return;
    }
    CGFloat offSetX = scrollView.contentOffset.x;
    CGFloat temp = offSetX / self.bounds.size.width;
    CGFloat progress = temp - floor(temp);
    if (offSetX - _oldOffSetX >= 0) {
        if (progress == 0.0) {
            return;
        }
        _oldIndex = (offSetX/self.bounds.size.width);
        _currentIndex = _oldIndex + 1;
        if (_currentIndex >= self.childVcs.count) {
            _currentIndex = self.childVcs.count -1;
            return;
        }
    } else {
        _currentIndex = (offSetX / self.bounds.size.width);
        _oldIndex = _currentIndex + 1;
        if (_oldIndex >= self.childVcs.count) {
            _oldIndex = self.childVcs.count - 1;
            return;
        }
        progress = 1.0 - progress;

    }
    

    
    [self contentViewDidMoveFromIndex:_oldIndex toIndex:_currentIndex progress:progress];
    
}

/**为了解决在滚动或接着点击title更换的时候因为index不同步而增加了下边的两个代理方法的判断
*/

/** 滚动减速完成时再更新title的位置 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentIndex = (scrollView.contentOffset.x / self.bounds.size.width);
    [self contentViewEndMoveToIndex:currentIndex];
    // 发布通知
    [self addCurrentShowIndexNotificationWithIndex:currentIndex];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _oldOffSetX = scrollView.contentOffset.x;
    self.forbidTouchToAdjustPosition = NO;
    
}

#pragma mark - private helper
- (void)contentViewDidMoveFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress {
    if(self.segmentView) {
        [self.segmentView adjustUIWithProgress:progress oldIndex:fromIndex currentIndex:toIndex];
    }
}

- (void)contentViewEndMoveToIndex:(NSInteger)currentIndex {
    if(self.segmentView) {
        [self.segmentView adjustTitleOffSetToCurrentIndex:currentIndex];
        [self.segmentView adjustUIWithProgress:1.0 oldIndex:currentIndex currentIndex:currentIndex];
    }
}
//发布通知
- (void)addCurrentShowIndexNotificationWithIndex:(NSInteger)index {
    [[NSNotificationCenter defaultCenter] postNotificationName: ScrollPageViewDidShowThePageNotification object:nil userInfo:@{@"currentIndex": @(index)}];
    
}

#pragma mark - getter --- setter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.collectionViewLayout];
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        collectionView.bounces = NO;
        collectionView.scrollEnabled = self.segmentView.segmentStyle.isScrollContentView;
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)collectionViewLayout {
    if (_collectionViewLayout == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.bounds.size;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionViewLayout = layout;
    }
    
    return _collectionViewLayout;
}


@end
