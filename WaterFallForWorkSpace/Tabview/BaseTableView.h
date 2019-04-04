//
//  BaseTableView.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/1/29.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableView : UIView

- (instancetype)initWithFrame:(CGRect)frame baseVc:(UIViewController *)VC;

- (BOOL)tabPrefersStatusBarHidden;

@end

NS_ASSUME_NONNULL_END
