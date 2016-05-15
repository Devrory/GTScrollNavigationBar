//
//  GTViewController.m
//  GTScrollNavigationBarExample
//
//  Created by Rory on 16/5/15.
//  Copyright © 2016年 Luu Gia Thuy. All rights reserved.
//

#import "GTViewController.h"
#import "GTScrollNavigationBar.h"
#import "MJRefresh.h"
#import "GTCollectionViewCell.h"

@interface GTViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation GTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.navigationBar.hidden = YES;
    
    [self createTable];
    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
    
    __weak __typeof(self) weakSelf = self;
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.header endRefreshing];
        });
    }];
    
    UINavigationBar *navBar = self.navigationController.navigationBar;
    CGRect frame = CGRectMake(0, -20, CGRectGetWidth(navBar.frame), CGRectGetHeight(navBar.frame) + 20);
    UIView *barView = [[UIView alloc] initWithFrame:frame];
    barView.backgroundColor = [UIColor redColor];
        [navBar addSubview:barView];
//    [self.view addSubview:barView];
    
//    [self createCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    self.navigationItem.title = @"DemoScrollNavigationBar";
    self.navigationController.scrollNavigationBar.scrollView = self.tableView;
}

//- (void)createCollectionView {
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    [self.view addSubview:collectionView];
//    
//    [collectionView registerClass:[GTCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
//}

//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 30;
//}


//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    GTCollectionViewCell *cell = (GTCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[GTCollectionViewCell alloc] init];
//    }
//    return cell;
//}

- (void)createTable {
//    CGRect frame = CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height);
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    table.frame = self.view.bounds;
    table.dataSource = self;
    table.delegate = self;
    self.tableView = table;
    [self.view addSubview:table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [[NSNumber numberWithInteger:indexPath.row] stringValue];
    return cell;
}

@end
