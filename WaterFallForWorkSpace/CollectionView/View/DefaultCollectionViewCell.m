//
//  DefaultCollectionViewCell.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/1/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "DefaultCollectionViewCell.h"
#import "DefaultModel.h"
#import "BFPCollectionCellBottomView.h"

@interface DefaultCollectionViewCell ()
// 背景
@property (nonatomic, strong) UIView *cusBackgroundView;
// 图片
@property (nonatomic, strong) UIImageView *imageView;
// 类型logo
@property (nonatomic, strong) UIImageView *iconView;
// 头像
@property (nonatomic, strong) UIImageView *headerView;
// 名字
@property (nonatomic, strong) UILabel *nameLabel;
// 标题
@property (nonatomic, strong) UILabel *titleLabel;
// 底部内容
@property (nonatomic, strong) BFPCollectionCellBottomView *bottomView;

@end

@implementation DefaultCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset= CGSizeMake(2,2);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 2;
      
        [self loadCellView];
    }
    return self;
}

- (void)setModel:(DefaultModel *)model{
    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:[UIImage imageNamed:@"placeholder_80"] options:SDWebImageProgressiveDownload | SDWebImageRetryFailed];
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:_model.header] placeholderImage:[UIImage imageNamed:@"placeholder_80"] options:SDWebImageProgressiveDownload | SDWebImageRetryFailed];
    
    self.nameLabel.text = _model.userName;
    self.titleLabel.text = model.actName;
    self.iconView.image = GetImage(@"space_photoLib_icon");
    [self.bottomView setTime:@"12-11 12:45" fabulous:@"516" comment:@"8888"];
    CGFloat heigth = CGRectGetWidth(self.contentView.frame) * _model.h/_model.w;
    self.imageView.sd_layout
    .heightIs(heigth);
}

- (void)loadCellView{
    
    self.cusBackgroundView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .widthRatioToView(self.contentView, 1)
    .heightRatioToView(self.contentView, 1);
    
    self.imageView.sd_layout
    .leftEqualToView(self.cusBackgroundView)
    .widthRatioToView(self.cusBackgroundView, 1)
    .topEqualToView(self.cusBackgroundView);
    
    self.iconView.sd_layout
    .topSpaceToView(self.cusBackgroundView, 5)
    .rightSpaceToView(self.cusBackgroundView, 8)
    .heightIs(24)
    .widthEqualToHeight();
    
    self.headerView.sd_layout
    .leftSpaceToView(self.cusBackgroundView, 10)
    .topSpaceToView(self.imageView, 10)
    .heightIs(20)
    .widthEqualToHeight();
    
    self.nameLabel.sd_layout
    .centerYEqualToView(self.headerView)
    .leftSpaceToView(self.headerView, 5)
    .rightSpaceToView(self.cusBackgroundView, 10)
    .heightIs(15);
    
    self.titleLabel.sd_layout
    .leftEqualToView(self.headerView)
    .rightSpaceToView(self.cusBackgroundView, 10)
    .topSpaceToView(self.headerView, 10)
    .autoHeightRatio(0);
    [self.titleLabel setMaxNumberOfLinesToShow:3];
    
    self.bottomView.sd_layout
    .leftEqualToView(self.cusBackgroundView)
    .widthRatioToView(self.cusBackgroundView, 1)
    .topSpaceToView(self.titleLabel, 10)
    .heightIs(26);
}

#pragma mark - Lazy

- (UIView *)cusBackgroundView{
    if (!_cusBackgroundView) {
        _cusBackgroundView = [[UIView alloc] init];
        _cusBackgroundView.layer.cornerRadius = 5;
        _cusBackgroundView.layer.masksToBounds = YES;
        _cusBackgroundView.backgroundColor = UIColor.whiteColor;
        [self.contentView addSubview:_cusBackgroundView];
    }
    return _cusBackgroundView;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        
        _imageView =[[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.cusBackgroundView addSubview:_imageView];
    }
    return _imageView;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        
        _iconView =[[UIImageView alloc] init];
        [self.cusBackgroundView addSubview:_iconView];
    }
    return _iconView;
}

- (UIImageView *)headerView{
    if (!_headerView) {
        
        _headerView = [[UIImageView alloc] init];
        [self.cusBackgroundView addSubview:_headerView];
    }
    return _headerView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT_SC(12);
        _nameLabel.textColor = rgba(41, 122, 204, 1);
        [self.cusBackgroundView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        
        _titleLabel.font = FONT_SC(14);
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.numberOfLines = 0;
        [self.cusBackgroundView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        
        _bottomView = [[BFPCollectionCellBottomView alloc] init];
        _bottomView.backgroundColor = rgba(242, 242, 242, 1);
        [self.cusBackgroundView addSubview:_bottomView];
    }
    return _bottomView;
}


@end
