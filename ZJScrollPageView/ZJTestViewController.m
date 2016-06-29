//
//  TextViewController.m
//  ZJScrollPageView
//
//  Created by jasnig on 16/5/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJTestViewController.h"
#import "ZJSegmentStyle.h"

@interface ZJTestViewController ()

@end

@implementation ZJTestViewController
- (IBAction)testBtnOnClick:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectedIndex:) name:ScrollPageViewDidShowThePageNotification object:nil];
}

- (void)didSelectedIndex: (NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    NSLog(@"显示了%@页", userInfo[@"currentIndex"]);
    NSLog(@"%@",self.scrollPageParentViewController);
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    NSLog(@"%@-----test", self.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
