//
//  BaseTableView.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/1/29.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "BaseTableView.h"
#import "DefaultModel.h"
#import "BFPActivitySubViewModel.h"
#import "BFPActivitySpaceCell.h"
#import "BFPSpaceHeaderView.h"
#import "ViewController.h"
#import "WMPlayer.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

static NSInteger headerHeight = 70;

@interface BaseTableView () <UITableViewDelegate, UITableViewDataSource, WMPlayerDelegate>

@property (nonatomic, strong) UITableView *main_tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) BFPActivitySubViewModel *viewModel;

@property (nonatomic, strong) BFPSpaceHeaderView *headerView;

@property (nonatomic, strong) ViewController *VC;

@property(nonatomic,strong) WMPlayer *wmPlayer;

@end

@implementation BaseTableView

- (BOOL)tabPrefersStatusBarHidden{
    if (self.wmPlayer.isFullscreen) {
        return self.wmPlayer.prefersStatusBarHidden;
    }
    return NO;
}

- (instancetype)initWithFrame:(CGRect)frame baseVc:(UIViewController *)VC{
    if (self == [super initWithFrame:frame]) {
        //获取设备旋转方向的通知,即使关闭了自动旋转,一样可以监测到设备的旋转方向
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
        self.VC = (ViewController *)VC;
        
        self.viewModel = [[BFPActivitySubViewModel alloc] init];
        
        self.main_tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self.main_tableView reloadData];
            [self.main_tableView.mj_header endRefreshing];
            [self.headerView loadImage:@"活动banner" title:@"比夫杯王者争霸赛季前赛全城开火,夺冠军赢万元现金大奖！"];
        }];
        [self.main_tableView.mj_header beginRefreshing];
        //旋转屏幕通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChange:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.spaceModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *activityspace_cell_identifier = @"activityspace_cell_identifier";
    BFPActivitySpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:activityspace_cell_identifier];
    if (!cell) {
        cell = [[BFPActivitySpaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:activityspace_cell_identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.hiddenLine = YES;
    cell.spaceModel = self.viewModel.spaceModels[indexPath.row];
    WEAK;
    cell.spaceCellBlock = ^(BFPActivitySpaceModel * _Nonnull model) {
        STRONG;
        model.isOpening = !model.isOpening;
        [self.main_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    cell.spaceCelButtonlBlock = ^(kSpaceBottomButtonType type, BFPActivitySpaceModel *model){
        NSString *str = type == kSpaceBottomButtonTypeFabulous ? @"赞": @"评论";
        NSLog(@"%@,%@",str, model.nameStr);
    };
 
    cell.spaceCelVideoBlock = ^(UIImageView * _Nonnull backgroundIV, VideoModel * _Nonnull videoModel) {
        STRONG;
        [self releaseWMPlayer];
        WMPlayerModel *playerModel = [WMPlayerModel new];
        playerModel.title = videoModel.title;
        playerModel.videoURL = [NSURL URLWithString:videoModel.mp4_url];
        self.wmPlayer.isFullscreen = NO;
        
        self.wmPlayer = [[WMPlayer alloc] init];
        self.wmPlayer.delegate = self;
        self.wmPlayer.playerModel = playerModel;
        [self videoViewOtherOrientation:UIInterfaceOrientationUnknown];

        [self.wmPlayer play];
        [self.main_tableView reloadData];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.row < self.viewModel.spaceModels.count) {
        BFPActivitySpaceModel *spaceModel = self.viewModel.spaceModels[indexPath.row];
        CGFloat height = [self.main_tableView cellHeightForIndexPath:indexPath model:spaceModel keyPath:@"spaceModel" cellClass:[BFPActivitySpaceCell class] contentViewWidth:Main_Screen_Width];
        return height;
    }
    else{
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.VC pushTopCenterView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = self.main_tableView.contentOffset;
    if (offset.y < headerHeight) {
        if (![self.VC.navigationItem.title isEqualToString:@"活动空间瀑布流"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTitle" object:nil userInfo:@{@"itemTitle":@"活动空间瀑布流"}];
        }
    }
    else if (offset.y >= headerHeight) {
        if ([self.VC.navigationItem.title isEqualToString:@"活动空间瀑布流"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTitle" object:nil userInfo:@{@"itemTitle":@"比夫杯王者争霸赛季前赛全城开火,夺冠军赢万元现金大奖！"}];
        }
    }
}
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange:(NSNotification *)notification{
    if (self.wmPlayer==nil){
        return;
    }
    if (self.wmPlayer.isLockScreen){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
            case UIInterfaceOrientationPortraitUpsideDown:{
                NSLog(@"第3个旋转方向---电池栏在下");
            }
            break;
            case UIInterfaceOrientationPortrait:{
                NSLog(@"第0个旋转方向---电池栏在上");
                [self toOrientation:UIInterfaceOrientationPortrait];
            }
            break;
            case UIInterfaceOrientationLandscapeLeft:{
                NSLog(@"第2个旋转方向---电池栏在左");
                [self toOrientation:UIInterfaceOrientationLandscapeLeft];
            }
            break;
            case UIInterfaceOrientationLandscapeRight:{
                NSLog(@"第1个旋转方向---电池栏在右");
                [self toOrientation:UIInterfaceOrientationLandscapeRight];
            }
            break;
        default:
            break;
    }
}

#pragma mark - about video
///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    NSLog(@"didClickedCloseButton");
#if 0
    if (wmplayer.isFullscreen) {
        [self toOrientation:UIInterfaceOrientationPortrait];
    }else{
        [self releaseWMPlayer];
        [self.wmPlayer removeFromSuperview];
    }
#else
    [self releaseWMPlayer];
    [self.wmPlayer removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
#endif
}
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (self.wmPlayer.isFullscreen) {//全屏
        [self toOrientation:UIInterfaceOrientationPortrait];
    }else{//非全屏
        [self toOrientation:UIInterfaceOrientationLandscapeRight];
    }
}
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    [self.VC setNeedsStatusBarAppearanceUpdate];
}
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}

///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidReadyToPlay");
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
}
//操作栏隐藏或者显示都会调用此方法
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL)isHidden{
    [self.VC setNeedsStatusBarAppearanceUpdate];
}

/**
 向上
 */
- (void)videoViewPortrait{
    [KeyWindow addSubview:self.wmPlayer];
    self.wmPlayer.isFullscreen = NO;
    self.wmPlayer.backBtnStyle = BackBtnStylePop;
    [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.height));
        make.height.equalTo(@([UIScreen mainScreen].bounds.size.width));
        make.center.equalTo(self.wmPlayer.superview);
    }];
}

- (void)videoViewOtherOrientation:(UIInterfaceOrientation)currentOrientation{
    [KeyWindow addSubview:self.wmPlayer];
    self.wmPlayer.backBtnStyle = BackBtnStylePop;
    if(currentOrientation ==UIInterfaceOrientationPortrait){
        [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.height));
            make.height.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.center.equalTo(self.wmPlayer.superview);
        }];
    }else{
        [self.wmPlayer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.height.equalTo(@([UIScreen mainScreen].bounds.size.height));
            make.center.equalTo(self.wmPlayer.superview);
        }];
    }
}

//点击进入,退出全屏,或者监测到屏幕旋转去调用的方法
-(void)toOrientation:(UIInterfaceOrientation)orientation{
    //获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    //判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == orientation) {
        return;
    }
    [self.wmPlayer removeFromSuperview];
    
    //根据要旋转的方向,使用Masonry重新修改限制
    if (orientation ==UIInterfaceOrientationPortrait) {
        [self videoViewPortrait];
    }else{
        self.wmPlayer.isFullscreen = YES;
        [self videoViewOtherOrientation:currentOrientation];
    }
    
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    [UIView animateWithDuration:0.4 animations:^{
        self.wmPlayer.transform = CGAffineTransformIdentity;
        self.wmPlayer.transform = [WMPlayer getCurrentDeviceOrientation];
        [self.wmPlayer layoutIfNeeded];
        [self.VC setNeedsStatusBarAppearanceUpdate];
    }];
}

- (void)releaseWMPlayer{
    [self.wmPlayer pause];
    [self.wmPlayer removeFromSuperview];
    self.wmPlayer = nil;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Lazy
- (UITableView *)main_tableView{
    if (!_main_tableView) {
        
        _main_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64) style:UITableViewStyleGrouped];
        _main_tableView.delegate = self;
        _main_tableView.dataSource= self;
        _main_tableView.separatorInset = UIEdgeInsetsMake(0, 60, 0, 15);
        _main_tableView.tableHeaderView = self.headerView;
        _main_tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 0.5)];
        _main_tableView.sectionFooterHeight = 0;
        _main_tableView.sectionHeaderHeight = 0;
        [self addSubview:_main_tableView];
    }
    return _main_tableView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (BFPSpaceHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[BFPSpaceHeaderView alloc] initWithFrame: CGRectMake(0, 0, Main_Screen_Width, headerHeight)];
    }
    return _headerView;
}

@end
