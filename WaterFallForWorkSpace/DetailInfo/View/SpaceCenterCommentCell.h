//
//  SpaceCenterCommentCell.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/3/1.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDTimeLineCellCommentItemModel;

NS_ASSUME_NONNULL_BEGIN

@protocol SpaceCenterCommentCellDelegate <NSObject>

- (void)commentCellReply:(SDTimeLineCellCommentItemModel *)commentModel;

@end

@interface SpaceCenterCommentCell : UITableViewCell

@property (nonatomic, strong) SDTimeLineCellCommentItemModel *commentModel;

@property (nonatomic, weak) id<SpaceCenterCommentCellDelegate>delegate;

- (void)showCommentLogo:(BOOL)show;


@end

NS_ASSUME_NONNULL_END
