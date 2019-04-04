//
//  BFPActivitySpaceCell.h
//  BFPlus
//
//  Created by hzhy001 on 2018/12/27.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFPActSpaceBottomView.h"
#import "VideoModel.h"
@class BFPActivitySpaceModel;

NS_ASSUME_NONNULL_BEGIN

@interface BFPActivitySpaceCell : UITableViewCell

@property (nonatomic, strong) BFPActivitySpaceModel *spaceModel;

@property (nonatomic, assign) BOOL hiddenLine;

@property (nonatomic, copy) void(^spaceCellBlock)(BFPActivitySpaceModel *model);

@property (nonatomic, copy) void(^spaceCelButtonlBlock)(kSpaceBottomButtonType type, BFPActivitySpaceModel *model);

@property (nonatomic, copy) void(^spaceCelVideoBlock)(UIImageView *backgroundIV, VideoModel *videoModel);

@end

NS_ASSUME_NONNULL_END
