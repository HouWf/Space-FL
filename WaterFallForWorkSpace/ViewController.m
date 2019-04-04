//
//  ViewController.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/1/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "ViewController.h"
#import "BaseCollectionView.h"
#import "BaseTableView.h"
#import "BFPSpaceDetailViewController.h"
#import "PublishCommentsViewController.h"

typedef NS_ENUM(NSInteger , ControllerViewType) {
    ControllerViewTypeTabView = 0,
    ControllerViewTypeCollectionView
};

@interface ViewController ()

@property (nonatomic, strong) BaseCollectionView *collectionView;

@property (nonatomic, strong) BaseTableView *tabView;

@property (nonatomic, assign) ControllerViewType viewType;

@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UIButton *exchangeButton;

@property (nonatomic, strong) UIButton *signUpButton;

@end

@implementation ViewController
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden{
//    if (self.viewType == ControllerViewTypeTabView) {
       return [self.tabView tabPrefersStatusBarHidden];
//    }
    return NO;
}

-(BOOL)shouldAutorotate{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"活动空间瀑布流";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.signUpButton];
    
    self.viewType = ControllerViewTypeTabView;
    [self.view addSubview:self.tabView];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"changeTitle" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"userinf %@",x.userInfo);
        NSDictionary *dic = x.userInfo;
        self.navigationItem.title = dic[@"itemTitle"];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [[UIApplication sharedApplication].keyWindow addSubview:self.addButton];
    [[UIApplication sharedApplication].keyWindow addSubview:self.exchangeButton];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.addButton removeFromSuperview];
    [self.exchangeButton removeFromSuperview];
}

/**
 发布评论
 */
- (void)addClick{
//    self.addButton.enabled = NO;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.addButton.enabled = YES;
//    });
    [self pushToPublishCommentsCtr];
}

/**
 切换布局
 */
- (void)exchangeClick{
    
    self.exchangeButton.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.exchangeButton.enabled = YES;
    });
    
    if (self.viewType == ControllerViewTypeTabView) {
        self.viewType = ControllerViewTypeCollectionView;
    }
    else{
        self.viewType = ControllerViewTypeTabView;
    }
    [self reloadViewWithType:self.viewType];
}

/**
 活动报名
 */
- (void)signUpClick{
    NSLog(@"立即报名");
}

- (void)reloadViewWithType:(ControllerViewType)type{
#if 0
    if (type == ControllerViewTypeTabView) {
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:self.collectionView]) {
                [obj removeFromSuperview];
            }
        }];
        [self.view addSubview:self.tabView];
    }
    else{
        [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:self.tabView]) {
                [obj removeFromSuperview];
            }
        }];
        [self.view addSubview:self.collectionView];
    }
#else
    dispatch_async(dispatch_get_main_queue(), ^{
        if (type == ControllerViewTypeTabView) {
            self.view = self.tabView;
        }
        else{
            self.view = self.collectionView;
        }
    });
#endif
}

- (void)pushTopCenterView{
    BFPSpaceDetailViewController *detalCtr = [[BFPSpaceDetailViewController alloc] init];
    [self.navigationController pushViewController:detalCtr animated:YES];
}

- (void)pushToPublishCommentsCtr{
    PublishCommentsViewController *commentCtr = [[PublishCommentsViewController alloc] init];
    commentCtr.activityName = @"这是活动标题";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:commentCtr];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - Lazy
- (BaseCollectionView *)collectionView{
    if (!_collectionView) {
        
        _collectionView = [[BaseCollectionView alloc] initWithFrame:self.view.bounds baseVc:self];
    }
    return _collectionView;
}


- (BaseTableView *)tabView{
    if (!_tabView) {
        
        _tabView = [[BaseTableView alloc] initWithFrame:self.view.bounds baseVc:self];
    }
    return _tabView;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundImage:GetImage(@"space_add_btn_icon@2x") forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
        _addButton.frame = CGRectMake(Main_Screen_Width - 55, Main_Screen_Height - 135, 40, 40);
    }
    return _addButton;
}

- (UIButton *)exchangeButton{
    if (!_exchangeButton) {
        _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeButton setBackgroundImage:GetImage(@"space_exchange_btn_icon@2x") forState:UIControlStateNormal];
        [_exchangeButton addTarget:self action:@selector(exchangeClick) forControlEvents:UIControlEventTouchUpInside];
        _exchangeButton.frame = CGRectMake(Main_Screen_Width - 55, Main_Screen_Height - 80, 40, 40);

    }
    return _exchangeButton;
}

- (UIButton *)signUpButton{
    if (!_signUpButton) {
        
        _signUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_signUpButton setTitle:@"立即报名" forState:UIControlStateNormal];
        [_signUpButton setTitleColor:rgba(217, 57, 50, 1) forState:UIControlStateNormal];
        [_signUpButton addTarget:self action:@selector(signUpClick) forControlEvents:UIControlEventTouchUpInside];
        _signUpButton.titleLabel.font = FONT_SC(15);
    }
    return _signUpButton;
}

@end
