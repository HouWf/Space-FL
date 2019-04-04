//
//  PhotoContainerView.h
//  AutoLayoutForCell
//
//  Created by hzhy001 on 2018/5/7.
//  Copyright © 2018年 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoContainerView : UIView

@property (nonatomic, strong) NSArray *picPathStringsArray;
// 图片宽度
@property (nonatomic, assign) CGFloat pictureWidth;
// 图片高/宽比例
@property (nonatomic, assign) CGFloat autoHeight;
// 每页显示数 默认2
@property (nonatomic, assign) NSInteger perRowItemCount;

@end
