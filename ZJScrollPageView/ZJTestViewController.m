//
//  TextViewController.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTestViewController.h"

@interface ZJTestViewController ()

@end

@implementation ZJTestViewController
- (IBAction)testBtnOnClick:(UIButton *)sender {
    
}


- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear:(BOOL)isFirstTime {
    if (isFirstTime) {
//        if ([title isEqualToString:@"国际要闻"]) {
//            NSLog(@"加载'国际要闻'相关的内容");
//        }
        NSLog(@"%s", __func__);
    }
}

- (void)childViewWillAppear {
    NSLog(@"%s", __func__);
}

- (void)childViewWillDisappear {
    NSLog(@"%s", __func__);
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc
{
    NSLog(@"%@-----test---销毁", self.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
