//
//  DefaultCollectionViewCell.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/1/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DefaultModel;

NS_ASSUME_NONNULL_BEGIN

@interface DefaultCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) DefaultModel *model;


@end

NS_ASSUME_NONNULL_END
