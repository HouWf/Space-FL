//
//  BesTool.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/26.
//  Copyright © 2019 hzhy001. All rights reserved.
//
/* 贝塞尔曲线切割 */
/**
 *
 *  @param UIRectCorner
 *  左上 UIRectCornerTopLeft     = 1 << 0,
 左下 UIRectCornerBottomLeft  = 1 << 2,
 右下 UIRectCornerBottomRight = 1 << 3,
 所有角 UIRectCornerAllCorners  = ~0UL
 *
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BesTool : NSObject

+ (instancetype)share;

/**
 切割四个角

 @param orignView 待切割的视图
 @param radius 圆角大小
 @return 切割后的视图
 */
- (id)cornerRadiusView:(UIView *)orignView cornerRadius:(CGFloat)radius;

/**
 根据UIRectCorner切割

 @param orignView 待切割视图
 @param corner UIRectCorner
 @param size 圆角的半径
 @return 切割后的视图
 */
+ (id)cornerRadiusView:(UIView *)orignView rectCorner:(UIRectCorner)corner cornerRadii:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
