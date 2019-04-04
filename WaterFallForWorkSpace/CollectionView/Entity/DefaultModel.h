//
//  DefaultModel.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/1/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DefaultModel : NSObject

/** 宽度  */
@property (nonatomic, assign) CGFloat w;
/** 高度  */
@property (nonatomic, assign) CGFloat h;
/** 图片  */
@property (nonatomic, copy) NSString *img;
/** 活动标题  */
@property (nonatomic, copy) NSString *actName;
/** 头像  */
@property (nonatomic, copy) NSString *header;
/** 名字  */
@property (nonatomic, copy) NSString *userName;

// 底部高度
@property (nonatomic, assign) CGFloat offsetH;

@end

NS_ASSUME_NONNULL_END
