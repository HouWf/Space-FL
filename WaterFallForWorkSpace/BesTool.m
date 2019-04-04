//
//  BesTool.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/26.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "BesTool.h"

@implementation BesTool
static BesTool *tool;
+ (instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[BesTool alloc] init];
    });
    return tool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [super allocWithZone:zone];
    });
    return tool;
}

- (id)cornerRadiusView:(UIView *)orignView cornerRadius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:orignView.frame cornerRadius:radius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = orignView.frame;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    orignView.layer.mask = maskLayer;
    
    return orignView;
}

+ (id)cornerRadiusView:(UIView *)orignView rectCorner:(UIRectCorner)corner cornerRadii:(CGSize)size{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:orignView.frame byRoundingCorners:corner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = orignView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    orignView.layer.mask = maskLayer;
    
    return orignView;
}

@end
