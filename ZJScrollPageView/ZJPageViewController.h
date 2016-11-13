//
//  ZJPageViewController.h
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/8/31.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZJPageViewControllerDelegate <NSObject>

- (void)scrollViewIsScrolling:(UIScrollView *)scrollView;

@end

@interface ZJPageViewController : UIViewController
// 代理
@property(weak, nonatomic)id<ZJPageViewControllerDelegate> delegate;

@property (strong, nonatomic) UIScrollView *scrollView;

@end
