//
//  SpaceCenterTableViewCell.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFPActSpaceBottomView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SpaceCenterTableViewCellDelegate <NSObject>

- (void)spaceCenterCallHandel:(kSpaceBottomButtonType)type model:(BFPActivitySpaceModel *)model;

@end

@interface SpaceCenterTableViewCell : UITableViewCell

@property (nonatomic, strong) BFPActivitySpaceModel *spaceModel;

@property (nonatomic, weak) id<SpaceCenterTableViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
