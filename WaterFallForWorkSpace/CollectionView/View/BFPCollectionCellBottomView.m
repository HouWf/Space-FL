//
//  BFPCollectionCellBottomView.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/27.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "BFPCollectionCellBottomView.h"

@interface CustomButton ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *numbLabel;

@end

@implementation CustomButton

- (void)setNumber:(NSString *)number{
    _number = number;
    self.numbLabel.text = number;
}

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (selected) {
        self.iconView.image = GetImage(@"fabulous_sel_icon");
    }
    else{
        self.iconView.image = GetImage(@"fabulous_desel_icon");
    }
}

- (void)addTarget:(nullable id)target action:(nonnull SEL)selector
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [tapGesture addTarget:target action:selector];
    [self addGestureRecognizer:tapGesture];
}

- (instancetype)init{
    if (self == [super init]) {
        UIImage *img = GetImage(@"fabulous_desel_icon");
        self.iconView = [[UIImageView alloc] init];
        self.iconView.image = img;
        [self addSubview:self.iconView];
        
        self.numbLabel = [[UILabel alloc] init];
        self.numbLabel.font = FONT_SC(10);
        self.numbLabel.textColor = rgba(153, 153, 153, 1);
        self.numbLabel.textAlignment = NSTextAlignmentRight;
        self.numbLabel.text = @"0";
        [self addSubview:self.numbLabel];
        
        self.numbLabel.sd_layout
        .rightEqualToView(self)
        .centerYEqualToView(self)
        .heightIs(20);
        [self.numbLabel setSingleLineAutoResizeWithMaxWidth:25];
        
        self.iconView.sd_layout
        .centerYEqualToView(self.numbLabel)
        .rightSpaceToView(self.numbLabel, 5)
        .heightIs(img.size.height)
        .widthIs(img.size.width);
    }
    return self;
}


@end

@interface BFPCollectionCellBottomView ()

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) CustomButton *fabulousButton;

@property (nonatomic, strong) CustomButton *commentButton;

@end

@implementation BFPCollectionCellBottomView

- (instancetype)init{
    if (self == [super init]) {
        
        [self loadBottomView];
    }
    return self;
}

- (void)setTime:(NSString *)time fabulous:(NSString *)fabulous comment:(NSString *)comment{
    self.timeLabel.text = time;
    self.fabulousButton.number = fabulous;
    self.commentButton.number = comment;
}

/**
 加载界面
 */
- (void)loadBottomView{
    
    self.timeLabel.sd_layout
    .centerYEqualToView(self)
    .leftSpaceToView(self, 10)
    .heightIs(20)
    .widthRatioToView(self, 0.48);
    
    self.commentButton.sd_layout
    .centerYEqualToView(self)
    .heightRatioToView(self, 1)
    .widthRatioToView(self, 0.25)
    .rightSpaceToView(self, 10);
    
    self.fabulousButton.sd_layout
    .centerYEqualToView(self.commentButton)
    .widthRatioToView(self.commentButton, 1)
    .heightRatioToView(self.commentButton, 1)
    .rightSpaceToView(self.commentButton, 5);
}

- (void)fabulousClick{
    self.fabulousButton.selected = !self.fabulousButton.selected;
    if (self.fabulousButton.selected) {
        self.fabulousButton.number = @"8888";
    }
    else{
        self.fabulousButton.number = @"0";
    }
}

- (void)commentClick{
    NSLog(@"跳转评论");
}

#pragma mark - Lazy
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT_SC(10);
        _timeLabel.textColor = rgba(153, 153, 153, 1);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (CustomButton *)fabulousButton{
    if (!_fabulousButton) {
        
        _fabulousButton = [[CustomButton alloc] init];
        [_fabulousButton addTarget:self action:@selector(fabulousClick)];
        [self addSubview:_fabulousButton];
    }
    return _fabulousButton;
}

- (CustomButton *)commentButton{
    if (!_commentButton) {
        
        _commentButton = [[CustomButton alloc] init];
        [_commentButton addTarget:self action:@selector(commentClick)];
        [self addSubview:_commentButton];
    }
    return _commentButton;
}

@end
