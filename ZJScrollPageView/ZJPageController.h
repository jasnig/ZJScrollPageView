//
//  ZJPageViewController.h
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/7/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJScrollPageViewDelegate.h"

@protocol PageTableViewDelegate <NSObject>

- (void)scrollViewIsScrolling:(UIScrollView *)scrollView;
- (void)setupScrollViewOffSetYWhenViewWillAppear:(UIScrollView *)scrollView;
@end


@interface ZJPageController : UIViewController<ZJScrollPageViewChildVcDelegate>
// 这个scrollView是由子类重写返回子类的tableView或者collectionView的
@property(strong, nonatomic)UIScrollView *scrollView;
// 这个代理是给子类调用相应的代理方法的
@property(weak, nonatomic)id<PageTableViewDelegate> delegate;


@end
