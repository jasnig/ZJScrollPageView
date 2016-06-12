//
//  UIViewController+UIViewController_ZJScrollPageController.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/6/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "UIViewController+ZJScrollPageController.h"
#import <objc/runtime.h>
@implementation UIViewController (ZJScrollPageController)

static char key;
- (void)setScrollPageParentViewController:(UIViewController *)scrollPageParentViewController {
    objc_setAssociatedObject(self, &key, scrollPageParentViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (UIViewController *)scrollPageParentViewController {
    return (UIViewController *)objc_getAssociatedObject(self, &key);
}

@end
