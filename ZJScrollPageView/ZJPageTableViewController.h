//
//  ZJPageTableViewController.h
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/8/31.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJPageViewController.h"
#import "ZJScrollPageViewDelegate.h"

@interface ZJPageTableViewController : ZJPageViewController<ZJScrollPageViewChildVcDelegate>
@property (strong, nonatomic) NSArray *data;

@end
