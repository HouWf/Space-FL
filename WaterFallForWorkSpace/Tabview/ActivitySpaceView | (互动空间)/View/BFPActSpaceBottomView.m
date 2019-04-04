//
//  BFPActSpaceBottomView.m
//  BFPlus
//
//  Created by hzhy001 on 2018/12/27.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import "BFPActSpaceBottomView.h"
#import "BFPActivitySpaceModel.h"

@interface BFPActSpaceBottomView ()

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *fabulousButton;

@property (nonatomic, strong) UIButton *commentButton;

@end

@implementation BFPActSpaceBottomView

- (instancetype)init{
    if (self == [super init]) {
        [self loadSpaceBottomView];
        
        [RACObserve(self, spaceModel) subscribeNext:^(BFPActivitySpaceModel *spaceModel) {
            self.timeLabel.text = spaceModel.time;
            CGSize commentSize = [NSString sizeWithText:spaceModel.commentNum maxSize:CGSizeMake(100, 20) font:FONT_SC(10*kScreenWidthRatio)];
            CGSize fabulousSize = [NSString sizeWithText:spaceModel.commentNum maxSize:CGSizeMake(100, 20) font:FONT_SC(10*kScreenWidthRatio)];
            
            self.commentButton.titleRect = CGRectMake(19, 0, commentSize.width, 20);
            self.fabulousButton.titleRect = CGRectMake(19, 0, fabulousSize.width, 20);
            [self.fabulousButton setTitle:spaceModel.faousNum forState:UIControlStateNormal];
            [self.commentButton setTitle:spaceModel.commentNum forState:UIControlStateNormal];
            self.fabulousButton.sd_layout.widthIs(fabulousSize.width+19);
            self.commentButton.sd_layout.widthIs(commentSize.width+19);
        }];
    }
    return self;
}

- (void)loadSpaceBottomView{
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self, 60*kScreenWidthRatio)
    .centerYEqualToView(self)
    .heightIs(20);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.commentButton.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self, 15*kScreenWidthRatio)
    .heightIs(20);
    
    self.fabulousButton.sd_layout
    .centerYEqualToView(self)
    .rightSpaceToView(self.commentButton, TAMargin)
    .heightRatioToView(self.commentButton, 1);
}

#pragma mark - Lazy
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = rgba(153, 153, 153, 1);
        _timeLabel.font = FONT_SC(10*kScreenWidthRatio);
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)fabulousButton{
    if (!_fabulousButton) {
        
        _fabulousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _fabulousButton.titleLabel.font = FONT_SC(10*kScreenWidthRatio);
        [_fabulousButton setTitleColor:rgba(153, 153, 153, 1) forState:UIControlStateNormal];
        [_fabulousButton setImage:GetImage(@"fabulous_little_icon") forState:UIControlStateNormal];
        _fabulousButton.imageRect = CGRectMake(0, 2, 16, 16);
        WEAK;
        [[_fabulousButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            STRONG;
            if (self.spaceBottomBlock) {
                self.spaceBottomBlock(kSpaceBottomButtonTypeFabulous);
            }
        }];
        [self addSubview:_fabulousButton];
    }
    return _fabulousButton;
}

- (UIButton *)commentButton{
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _commentButton.titleLabel.font = FONT_SC(10*kScreenWidthRatio);
        [_commentButton setTitleColor:rgba(153, 153, 153, 1) forState:UIControlStateNormal];
        [_commentButton setImage:GetImage(@"comment_little_icon") forState:UIControlStateNormal];
        _commentButton.imageRect = CGRectMake(0, 2, 16, 16);
        WEAK;
        [[_commentButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            STRONG;
            if (self.spaceBottomBlock) {
                self.spaceBottomBlock(kSpaceBottomButtonTypeComment);
            }
        }];
        [self addSubview:_commentButton];
        
    }
    return _commentButton;
}

@end
