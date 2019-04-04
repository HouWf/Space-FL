//
//  SpaceCenterFabulousCell.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFPActivitySpaceModel;

NS_ASSUME_NONNULL_BEGIN

@protocol SpaceCenterFabulousCellDelegate <NSObject>

- (void)resetCellHeight:(CGFloat)cellHeight;

@end

@interface SpaceCenterFabulousCell : UITableViewCell

@property (nonatomic, strong) BFPActivitySpaceModel *spaceModel;

@property (nonatomic, weak) id<SpaceCenterFabulousCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
