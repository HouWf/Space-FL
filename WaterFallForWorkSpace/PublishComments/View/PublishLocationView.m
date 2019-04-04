//
//  PublishLocationView.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/3/2.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "PublishLocationView.h"

@interface PublishLocationView ()

@property (nonatomic, strong) UIImageView *logoView;

@property (nonatomic, strong) UIImageView *accesseryView;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UIView *topLine;

@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation PublishLocationView

- (void)setLocationStr:(NSString *)locationStr{
    _locationStr = locationStr;
    self.locationLabel.text = _locationStr;
}

- (instancetype)init{
    if (self == [super init]) {
        self.logoView.sd_layout
        .centerYEqualToView(self)
        .leftSpaceToView(self, 15)
        .heightIs(16)
        .widthIs(16);
        
        self.accesseryView.sd_layout
        .centerYEqualToView(self.logoView)
        .rightSpaceToView(self, 30)
        .heightIs(15)
        .widthIs(15);
        
        self.locationLabel.sd_layout
        .centerYEqualToView(self.logoView)
        .leftSpaceToView(self.logoView, 5)
        .rightSpaceToView(self.accesseryView, 5)
        .heightRatioToView(self, 1);
        
        self.topLine.sd_layout
        .topEqualToView(self)
        .heightIs(1)
        .leftSpaceToView(self, 15)
        .rightSpaceToView(self, 15);
        
        self.bottomLine.sd_layout
        .bottomEqualToView(self)
        .heightRatioToView(self.topLine, 1)
        .widthRatioToView(self.topLine, 1)
        .leftEqualToView(self.topLine);
        
        self.width_sd = Main_Screen_Width;
        self.height_sd = 50;
        self.fixedHeight = @(50);
        self.fixedWidth = @(Main_Screen_Width);
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.publishLocationViewBlock) {
        self.publishLocationViewBlock();
    }
}

#pragma mark - Lazy
- (UIImageView *)logoView{
    if (!_logoView) {
        
        _logoView = [[UIImageView alloc] init];
        _logoView.image = GetImage(@"publish_location_icon");
        [self addSubview:_logoView];
    }
    return _logoView;
}

- (UIImageView *)accesseryView{
    if (!_accesseryView) {
        
        _accesseryView = [[UIImageView alloc] init];
        _accesseryView.image = GetImage(@"publish_accessery_icon");
        [self addSubview:_accesseryView];
    }
    return _accesseryView;
}

- (UILabel *)locationLabel{
    if (!_locationLabel) {
        
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = FONT_SC(14);
        _locationLabel.text = @"所在位置";
        _locationLabel.numberOfLines = 0;
        [self addSubview:_locationLabel];
    }
    return _locationLabel;
}

- (UIView *)topLine{
    if (!_topLine) {
        
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = rgba(230, 230, 230, 1);
        [self addSubview:_topLine];
    }
    return _topLine;
}

- (UIView *)bottomLine{
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = rgba(230, 230, 230, 1);
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end
