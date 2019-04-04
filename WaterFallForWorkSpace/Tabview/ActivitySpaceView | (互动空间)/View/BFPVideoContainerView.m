//
//  BFPVideoContainerView.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/3/5.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "BFPVideoContainerView.h"

@implementation BFPVideoContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self loadVideoCellView];
        
        WEAK;
        [[self.startButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            STRONG;
            if (self.startPlayVideoBlcok) {
                self.startPlayVideoBlcok(self.imageView, self.model);
            }
        }];
        
        [RACObserve(self, model) subscribeNext:^(VideoModel *model) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"logo"]];
        }];
    }
    return self;
}

- (void)loadVideoCellView{
    self.imageView.sd_layout
    .leftEqualToView(self)
    .topEqualToView(self)
    .widthRatioToView(self, 1)
    .heightRatioToView(self, 1);
    
    self.startButton.sd_layout
    .centerYEqualToView(self)
    .centerXEqualToView(self)
    .widthIs(66)
    .heightIs(64);
}

#pragma mark - Lazy
- (UIImageView *)imageView{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UIButton *)startButton{
    if (!_startButton) {
        
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startButton setBackgroundImage:GetImage(@"video_play_btn_bg") forState:UIControlStateNormal];
     
        [self addSubview:_startButton];
    }
    return _startButton;
}

@end
