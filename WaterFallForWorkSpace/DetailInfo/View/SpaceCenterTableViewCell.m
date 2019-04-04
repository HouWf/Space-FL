//
//  BFPActivitySpaceCell.m
//  BFPlus
//
//  Created by hzhy001 on 2018/12/27.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import "SpaceCenterTableViewCell.h"
#import "PhotoContainerView.h"
#import "BFPActivitySpaceModel.h"

@interface SpaceCenterTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *locationIcon;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) PhotoContainerView *photoView;

@property (nonatomic, strong) BFPActSpaceBottomView *bottomView;

@end

@implementation SpaceCenterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadActivityView];
        
        [RACObserve(self, spaceModel) subscribeNext:^(BFPActivitySpaceModel *spaceModel) {
            if (!spaceModel) {
                return ;
            }
            
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:spaceModel.iconNameUrl] placeholderImage:GetImage(@"placeholder_80") options:SDWebImageProgressiveDownload];
            self.nameLabel.text = spaceModel.nameStr;
            self.contentLabel.text = spaceModel.contentStr;
            
            self.photoView.picPathStringsArray = spaceModel.pictureArray;
            self.bottomView.spaceModel = spaceModel;
            self.locationLabel.text = spaceModel.cityName;
            
            CGFloat picContainerTopMargin = 0;
            if (spaceModel.pictureArray.count) {
                picContainerTopMargin = 10;
            }
            self.photoView.sd_layout.topSpaceToView(self.contentLabel, picContainerTopMargin);
            
            UIView *currentBottomView;
            currentBottomView = self.bottomView;
            
            [self setupAutoHeightWithBottomView:currentBottomView bottomMargin:5];
        }];
    }
    return self;
}

- (void)loadActivityView{
    
    self.iconView.sd_layout
    .leftSpaceToView(self.contentView, 15*kScreenWidthRatio)
    .topSpaceToView(self.contentView, 15*kScreenWidthRatio)
    .heightIs(32*kScreenWidthRatio)
    .widthEqualToHeight();
    self.iconView.sd_cornerRadiusFromWidthRatio = @0.5f;
    
    self.nameLabel.sd_layout
    .centerYEqualToView(self.iconView)
    .leftSpaceToView(self.iconView, 13*kScreenWidthRatio)
    .heightIs(20);
    [self.nameLabel setSingleLineAutoResizeWithMaxWidth:200*kScreenWidthRatio];
    
    self.contentLabel.sd_layout
    .leftEqualToView(self.nameLabel)
    .topSpaceToView(self.iconView, 5)
    .widthIs(300*kScreenWidthRatio)
    .autoHeightRatio(0);
    
    self.photoView.sd_layout
    .leftEqualToView(self.nameLabel);
    
    UIImage *img = GetImage(@"space_location_icon");
    self.locationIcon.sd_layout
    .leftEqualToView(self.nameLabel)
    .topSpaceToView(self.photoView, 7)
    .widthIs(img.size.width)
    .heightIs(img.size.height);
    
    self.locationLabel.sd_layout
    .centerYEqualToView(self.locationIcon)
    .leftSpaceToView(self.locationIcon, 5)
    .rightEqualToView(self.contentLabel)
    .heightIs(16);
    
    self.bottomView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topSpaceToView(self.locationIcon, 1.f)
    .heightIs(25*kScreenWidthRatio);
}

#pragma mark - Lazy
- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = [UIColor lightGrayColor];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT_SC(14);
        _nameLabel.textColor = rgba(41, 122, 204, 1);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT_SC(14);
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (PhotoContainerView *)photoView{
    if (!_photoView) {
        _photoView = [[PhotoContainerView alloc] init];
        _photoView.autoHeight = 13/19.f;
        [self.contentView addSubview:_photoView];
    }
    return _photoView;
}

- (UIImageView *)locationIcon{
    if (!_locationIcon) {
        
        _locationIcon = [[UIImageView alloc] init];
        _locationIcon.image = GetImage(@"space_location_icon");
        [self.contentView addSubview:_locationIcon];
    }
    return _locationIcon;
}

- (UILabel *)locationLabel{
    if (!_locationLabel) {
        
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textColor = UIColor.blackColor;
        _locationLabel.font = FONT_SC(12);
        [self.contentView addSubview:_locationLabel];
    }
    return _locationLabel;
}

- (BFPActSpaceBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BFPActSpaceBottomView alloc] init];
        WEAK;
        _bottomView.spaceBottomBlock = ^(kSpaceBottomButtonType type) {
            STRONG;
            if ([self.delegate respondsToSelector:@selector(spaceCenterCallHandel:model:)]) {
                [self.delegate spaceCenterCallHandel:type model:self.spaceModel];
            }
        };
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
