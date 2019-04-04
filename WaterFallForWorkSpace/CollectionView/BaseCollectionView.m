//
//  BaseCollectionView.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/1/29.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "BaseCollectionView.h"
#import "ViewController.h"
#import "LMHWaterFallLayout.h"
#import "DefaultCollectionViewCell.h"
#import "BFPSpaceHeaderView.h"
#import "DefaultModel.h"

static NSInteger ContentInsetTop = 70;
static NSString *cell_identifier = @"cell_identifier";

@interface BaseCollectionView ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, LMHWaterFallLayoutDeleaget>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) BFPSpaceHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) ViewController *VC;

@end

@implementation BaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame baseVc:(UIViewController *)VC{
    if (self == [super initWithFrame:frame]) {
        
        self.VC = (ViewController *)VC;
        
        MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadNewShops];
        }];
        refreshHeader.ignoredScrollViewContentInsetTop = ContentInsetTop;
        self.collectionView.mj_header = refreshHeader;
        [self.collectionView.mj_header beginRefreshing];
        
        self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadMoreShops];
        }];
        
        [self.headerView loadImage:@"活动banner" title:@"比夫杯王者争霸赛季前赛全城开火,夺冠军赢万元现金大奖！"];
    }
    return self;
}

/**
 * 加载新的商品
 */
- (void)loadNewShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray * model = [DefaultModel mj_objectArrayWithFilename:@"shop.plist"];
        
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:model];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    });
}

/**
 * 加载更多商品
 */
- (void)loadMoreShops{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSArray * model = [DefaultModel mj_objectArrayWithFilename:@"shop.plist"];
        [self.dataSource addObjectsFromArray:model];
        // 刷新表格
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
    });
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    self.collectionView.mj_footer.hidden = self.dataSource.count == 0;
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DefaultCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_identifier forIndexPath:indexPath];
    
    cell.model = self.dataSource[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    DefaultModel *model = self.dataSource[indexPath.item];
//    CGFloat height = model.offsetH;
//    if (height == 0) {
//        height = height + 30;
//    }
//    else{
//        height = 0;
//    }
//    model.offsetH = height;
//    [self.collectionView reloadData];
    
    [self.VC pushTopCenterView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = self.collectionView.contentOffset;
    if (offset.y < ContentInsetTop) {
        if (![self.VC.navigationItem.title isEqualToString:@"活动空间瀑布流"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTitle" object:nil userInfo:@{@"itemTitle":@"活动空间瀑布流"}];
        }
    }
    else if (offset.y >= ContentInsetTop) {
        if ([self.VC.navigationItem.title isEqualToString:@"活动空间瀑布流"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTitle" object:nil userInfo:@{@"itemTitle":@"比夫杯王者争霸赛季前赛全城开火,夺冠军赢万元现金大奖！"}];
        }
    }
}

#pragma mark - LMHWaterFallLayoutDeleaget
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth
{
    DefaultModel *defModel = self.dataSource[indexPath];
    CGFloat textHeigh = [NSString sizeWithText:defModel.actName maxSize:CGSizeMake(itemWidth-20, 60) font:FONT_SC(14)].height;
    return itemWidth * defModel.h / defModel.w + 76 + textHeigh + defModel.offsetH;
}

#pragma mark - Lazy
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        
        LMHWaterFallLayout *waterLayout = [[LMHWaterFallLayout alloc] init];
        waterLayout.delegate = self;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:waterLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = rgba(242, 242, 242, 1);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.contentInset =UIEdgeInsetsMake(ContentInsetTop,0, 0,0);
        [_collectionView registerClass:[DefaultCollectionViewCell class] forCellWithReuseIdentifier:cell_identifier];
        [self addSubview:_collectionView];
    }
    return _collectionView;
}

- (BFPSpaceHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[BFPSpaceHeaderView alloc] initWithFrame:CGRectMake(0, -ContentInsetTop, Main_Screen_Width, ContentInsetTop)];
        [self.collectionView addSubview:_headerView];
    }
    return _headerView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
