//
//  BFPActSpaceBottomView.h
//  BFPlus
//
//  Created by hzhy001 on 2018/12/27.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFPActivitySpaceModel;

typedef NS_ENUM(NSInteger, kSpaceBottomButtonType) {
    kSpaceBottomButtonTypeFabulous = 0,
    kSpaceBottomButtonTypeComment
};

NS_ASSUME_NONNULL_BEGIN

@interface BFPActSpaceBottomView : UIView

@property (nonatomic, strong) BFPActivitySpaceModel *spaceModel;

@property (nonatomic, copy) void (^spaceBottomBlock)(kSpaceBottomButtonType type);

@end

NS_ASSUME_NONNULL_END
