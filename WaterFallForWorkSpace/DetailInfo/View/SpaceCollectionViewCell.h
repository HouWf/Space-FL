//
//  SpaceCollectionViewCell.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDTimeLineCellLikeItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface SpaceCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *collImageView;

@property (nonatomic, strong) SDTimeLineCellLikeItemModel *likeModel;

@end

NS_ASSUME_NONNULL_END
