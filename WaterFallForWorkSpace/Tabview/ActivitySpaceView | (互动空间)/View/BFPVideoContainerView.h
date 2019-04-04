//
//  BFPVideoContainerView.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/3/5.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^StartPlayVideoBlcok)(UIImageView *backgroundIV,VideoModel *videoModel);

@interface BFPVideoContainerView : UIView

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *startButton;// video_play_btn_bg

@property (nonatomic, retain)VideoModel *model;

@property (nonatomic, copy) StartPlayVideoBlcok startPlayVideoBlcok;

@end

NS_ASSUME_NONNULL_END
