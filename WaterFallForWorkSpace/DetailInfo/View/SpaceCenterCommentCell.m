//
//  SpaceCenterCommentCell.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/3/1.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "SpaceCenterCommentCell.h"
#import "BFPActivitySpaceModel.h"

@interface SpaceCenterCommentCell  ()

@property (nonatomic, strong) UIImageView *logoView;

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *replyButton;

@end

@implementation SpaceCenterCommentCell

- (void)showCommentLogo:(BOOL)show{
    self.logoView.hidden = !show;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = rgba(242, 242, 242, 1);
        
        [self loadCommentView];
        
        [RACObserve(self, commentModel) subscribeNext:^(SDTimeLineCellCommentItemModel *commentModel) {
           
            if (commentModel == nil) {
                return ;
            }
            [self.headerView sd_setImageWithURL:[NSURL URLWithString:commentModel.firstPicure] placeholderImage:GetImage(@"placeholder_80") options:SDWebImageProgressiveDownload | SDWebImageRetryFailed];
            
            NSMutableAttributedString *attrName = [self generateAttributedStringWithCommentItemModel:commentModel];
            self.nameLabel.attributedText = attrName;
            
            self.contentLabel.text = commentModel.commentString;
            
            self.timeLabel.text = commentModel.time;
        }];
        
        [self setupAutoHeightWithBottomView:self.replyButton bottomMargin:0];
    }
    return self;
}

#pragma mark - private actions

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(SDTimeLineCellCommentItemModel *)model
{
    NSString *text = model.firstUserName;
    if (model.secondUserName.length) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUserName]];
    }
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString setAttributes:@{NSForegroundColorAttributeName : rgba(41, 122, 204, 1)} range:[text rangeOfString:model.firstUserName]];
    if (model.secondUserName) {
        [attString setAttributes:@{NSForegroundColorAttributeName : rgba(41, 122, 204, 1)} range:[text rangeOfString:model.secondUserName]];
    }
    return attString;
}

- (void)loadCommentView{
    
    self.logoView.sd_layout
    .topSpaceToView(self.contentView, 13)
    .heightIs(16)
    .widthIs(16)
    .leftSpaceToView(self.contentView, 22);
    
    self.headerView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 55)
    .heightIs(32)
    .widthEqualToHeight();
    self.headerView.sd_cornerRadiusFromHeightRatio = @(0.5f);
    
    self.nameLabel.sd_layout
    .centerYEqualToView(self.headerView)
    .heightIs(20)
    .leftSpaceToView(self.headerView, 10)
    .rightSpaceToView(self.contentView, 15);
    
    self.contentLabel.sd_layout
    .leftEqualToView(self.nameLabel)
    .topSpaceToView(self.headerView, 5)
    .rightSpaceToView(self.contentView, 15)
    .autoHeightRatio(0);
    
    self.timeLabel.sd_layout
    .leftEqualToView(self.contentLabel)
    .topSpaceToView(self.contentLabel, 10)
    .heightIs(15);
    [self.timeLabel setSingleLineAutoResizeWithMaxWidth:80];
    
    self.replyButton.sd_layout
    .centerYEqualToView(self.timeLabel)
    .rightSpaceToView(self.contentView, 30)
    .heightIs(20)
    .widthIs(30);
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Lazy
- (UIImageView *)logoView{
    if (!_logoView) {
        _logoView = [[UIImageView alloc] init];
        _logoView.image = GetImage(@"space_comment_icon");
        [self.contentView addSubview:_logoView];
    }
    return _logoView;
}

- (UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] init];
        _headerView.image = GetImage(@"placeholder_80");
        [self.contentView addSubview:_headerView];
    }
    return _headerView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT_SC(14);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT_SC(14);
        [self.contentView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = FONT_SC(10);
        _timeLabel.textColor = rgba(153, 153, 153, 1);
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UIButton *)replyButton{
    if (!_replyButton) {
        
        _replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyButton setTitle:@"回复" forState:UIControlStateNormal];
        [_replyButton setTitleColor:rgba(153, 153, 153, 1) forState:UIControlStateNormal];
        _replyButton.titleLabel.font = FONT_SC(10);
        [[_replyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if ([self.delegate respondsToSelector:@selector(commentCellReply:)]) {
                [self.delegate commentCellReply:self.commentModel];
            }
        }];
        [self.contentView addSubview:_replyButton];
    }
    return _replyButton;
}

@end
