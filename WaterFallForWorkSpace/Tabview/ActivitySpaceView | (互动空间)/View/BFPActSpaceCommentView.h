//
//  BFPActSpaceCommentView.h
//  BFPlus
//
//  Created by hzhy001 on 2018/12/27.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFPActSpaceCommentView : UIView

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray;

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow);

@end

NS_ASSUME_NONNULL_END
