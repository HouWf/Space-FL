//
//  BFPActivitySpaceCell.m
//  BFPlus
//
//  Created by hzhy001 on 2018/12/27.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import "BFPActivitySpaceCell.h"
#import "PhotoContainerView.h"
#import "BFPActivitySpaceModel.h"
#import "BFPActSpaceCommentView.h"
#import "BFPVideoContainerView.h"

CGFloat maxContentLabelHeight = 0; // 根据具体font而定

@interface BFPActivitySpaceCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIImageView *locationIcon;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) PhotoContainerView *photoView;

@property (nonatomic, strong) BFPVideoContainerView *videoView;

@property (nonatomic, strong) BFPActSpaceBottomView *bottomView;

@property (nonatomic, strong) BFPActSpaceCommentView *commentView;

@end

@implementation BFPActivitySpaceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadActivityView];
        
        [RACObserve(self, spaceModel) subscribeNext:^(BFPActivitySpaceModel *spaceModel) {
            if (!spaceModel) {
                return ;
            }
            if (spaceModel.videoModel == nil) {
                [self.commentView setupWithLikeItemsArray:spaceModel.likeItemsArray commentItemsArray:spaceModel.commentItemsArray];
                self.videoView.hidden = YES;
                self.commentView.hidden = NO;
            }
            else{
                self.videoView.model = spaceModel.videoModel;
                self.videoView.hidden = NO;
                self.commentView.hidden = YES;
            }
            
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:spaceModel.iconNameUrl] placeholderImage:GetImage(@"placeholder_80") options:SDWebImageProgressiveDownload];
            self.nameLabel.text = spaceModel.nameStr;
            self.contentLabel.text = spaceModel.contentStr;
            
            self.photoView.picPathStringsArray = spaceModel.pictureArray;
            self.bottomView.spaceModel = spaceModel;
            self.locationLabel.text = spaceModel.cityName;

            if (spaceModel.shouldShowMoreButton) {
                self.moreButton.sd_layout.heightIs(20);
                self.moreButton.hidden = NO;
                if (spaceModel.isOpening) { // 如果需要展开
                    self.contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
                    [self.moreButton setTitle:@"收起" forState:UIControlStateNormal];
                } else {
                    self.contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
                    [self.moreButton setTitle:@"全文" forState:UIControlStateNormal];
                }
            } else {
                self.moreButton.sd_layout.heightIs(0);
                self.moreButton.hidden = YES;
            }
            
            CGFloat picContainerTopMargin = 0;
            if (spaceModel.pictureArray.count) {
                picContainerTopMargin = 10;
            }
            if (spaceModel.videoModel == nil) {
                self.photoView.sd_layout.topSpaceToView(self.moreButton, picContainerTopMargin);
                self.locationIcon.sd_layout.topSpaceToView(self.photoView, 7);
            }
            else{
                self.locationIcon.sd_layout.topSpaceToView(self.videoView, 7);
            }
            
            UIView *currentBottomView;
            if (spaceModel.commentItemsArray != nil && spaceModel.likeItemsArray != nil) {
                currentBottomView = self.commentView;
            } else {
                currentBottomView = self.bottomView;
            }
            
            [self setupAutoHeightWithBottomView:currentBottomView bottomMargin:10];
        }];
        
        [RACObserve(self, hiddenLine) subscribeNext:^(NSNumber *hidden) {
            if ([hidden boolValue]) {
                self.lineView.hidden = YES;
            }
            else{
                self.lineView.hidden = NO;
            }
        }];
        
        [self.commentView setDidClickCommentLabelBlock:^(NSString * _Nonnull commentId, CGRect rectInWindow) {
            NSLog(@"界面跳转详情");
        }];
        
        WEAK;
        self.videoView.startPlayVideoBlcok = ^(UIImageView * _Nonnull backgroundIV, VideoModel * _Nonnull videoModel) {
            STRONG;
            if (self.spaceCelVideoBlock) {
                self.spaceCelVideoBlock(backgroundIV, videoModel);
            }
        };
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
    
    self.moreButton.sd_layout
    .leftEqualToView(self.contentLabel)
    .topSpaceToView(self.contentLabel, 1)
    .widthIs(30);
    
    self.photoView.sd_layout
    .leftEqualToView(self.nameLabel);
    
    self.videoView.sd_layout
    .topSpaceToView(self.moreButton, 10)
    .leftEqualToView(self.nameLabel)
    .widthIs(300*kScreenWidthRatio)
    .heightIs(150*kScreenWidthRatio);
    
    UIImage *img = GetImage(@"space_location_icon");
    self.locationIcon.sd_layout
    .leftEqualToView(self.nameLabel)
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
    
    self.commentView.sd_layout
    .leftEqualToView(self.contentLabel)
    .rightEqualToView(self.contentLabel)
    .topSpaceToView(self.bottomView, 1); 
    
    self.lineView.sd_layout
    .leftEqualToView(self.nameLabel)
    .rightEqualToView(self.contentLabel)
    .heightIs(0.5)
    .bottomEqualToView(self.contentView);
}

- (void)moreButtonClicked{
    NSLog(@"展开、收起");
    if (self.spaceCellBlock) {
        self.spaceCellBlock(self.spaceModel);
    }
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
        if (maxContentLabelHeight == 0) {
            maxContentLabelHeight = _contentLabel.font.lineHeight * 4;
        }
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        [_moreButton setTitleColor:rgba(41, 122, 204, 1) forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_moreButton];
    }
    return _moreButton;
}

- (PhotoContainerView *)photoView{
    if (!_photoView) {
        _photoView = [[PhotoContainerView alloc] init];
        _photoView.autoHeight = 13/19.f;
        [self.contentView addSubview:_photoView];
    }
    return _photoView;
}

- (BFPVideoContainerView *)videoView{
    if (!_videoView) {
        
        _videoView = [[BFPVideoContainerView alloc] init];
        [self.contentView addSubview:_videoView];
    }
    return _videoView;
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
            if (self.spaceCelButtonlBlock) {
                self.spaceCelButtonlBlock(type, self.spaceModel);
            }
        };
        [self.contentView addSubview:_bottomView];
    }
    return _bottomView;
}

- (BFPActSpaceCommentView *)commentView{
    if(!_commentView){
        _commentView = [[BFPActSpaceCommentView alloc] init];
        [self.contentView addSubview:_commentView];
    }
    return _commentView;
}

- (UIView *)lineView{
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [rgba(153, 153, 153, 1) colorWithAlphaComponent:0.6];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
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
