//
//  BFPSpaceHeaderView.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/26.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "BFPSpaceHeaderView.h"

@interface BFPSpaceHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *actTitleLabel;

@end

@implementation BFPSpaceHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.whiteColor;
        [self loadHeaderView];
        
    }
    return self;
}

- (void)loadImage:(NSString *)image title:(NSString *)title{
    if ([image hasPrefix:@"http"]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:GetImage(@"placeholder_80@3x") options:SDWebImageProgressiveDownload | SDWebImageRetryFailed];
    }
    else{
        self.imageView.image = GetImage(image);
    }
    
    self.actTitleLabel.text = title;
}

- (void)loadHeaderView{
    
    self.imageView.sd_layout
    .leftSpaceToView(self, 15)
    .centerYEqualToView(self)
    .heightIs(50)
    .widthIs(75);
    
    self.actTitleLabel.sd_layout
    .centerYEqualToView(self.imageView)
    .leftSpaceToView(self.imageView, 10)
    .rightSpaceToView(self, 15)
    .autoHeightRatio(0);
    [self.actTitleLabel setMaxNumberOfLinesToShow:2];
}

#pragma mark - Lazy
- (UIImageView *)imageView{
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.image = GetImage(@"placeholder_80");
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)actTitleLabel{
    if (!_actTitleLabel) {
        
        _actTitleLabel = [[UILabel alloc] init];
        _actTitleLabel.numberOfLines = 0;
        _actTitleLabel.font = FONT_SC(16);
        [self addSubview:_actTitleLabel];
    }
    return _actTitleLabel;
}

@end
