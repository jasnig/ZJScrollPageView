//
//  ZJCollectionController.m
//  ZJScrollPageView
//
//  Created by ZeroJ on 16/7/7.
//  Copyright © 2016年 ZeroJ. All rights reserved.
//

#import "ZJCollectionController.h"

@interface ZJCollectionController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation ZJCollectionController


static NSString *cellId = @"cellId";


// ZJScrollPageViewChildVcDelegate 这个代理方法用于页面出现的时候处理
- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear: (BOOL)isFirstTime {
    [self.delegate setupScrollViewOffSetYWhenViewWillAppear:self.collectionView];

        if(isFirstTime) {
            // 加载数据


        } else {
            //刷新...

        }

    
}

#pragma UIScrollViewDelegate 
// 这个scrollView的代理方法中调用代理的方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    [self.delegate scrollViewIsScrolling:scrollView];
}


// 重写父类的方法, 返回这个控制器的scrollView
- (UIScrollView *)scrollView {
    return self.collectionView;
}

#pragma 以上三个方法是必须实现的
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(100, 100);
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    // 这个设置上面的内容偏移量为ZJVc9Controller里面定义的常量defaultOffSetY
    [self.collectionView setContentInset:UIEdgeInsetsMake(200+64+44, 0, 0, 0)];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];

    return cell;
}


@end
