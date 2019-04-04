//
//  BFPCollectionCellBottomView.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/27.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomButton : UIView
// 是否被选中
@property (nonatomic, assign) BOOL selected;
// 显示文字内容
@property (nonatomic, copy) NSString *number;

/**
 添加事件
 */
- (void)addTarget:(nullable id)target action:(nonnull SEL)selector;

@end

@interface BFPCollectionCellBottomView : UIView

- (void)setTime:(NSString *)time fabulous:(NSString *)fabulous comment:(NSString *)comment;

@end

NS_ASSUME_NONNULL_END
