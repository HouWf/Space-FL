//
//  SpaceCollectionViewCell.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/2/28.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "SpaceCollectionViewCell.h"
#import "BFPActivitySpaceModel.h"

@implementation SpaceCollectionViewCell

- (void)setLikeModel:(SDTimeLineCellLikeItemModel *)likeModel{
    _likeModel = likeModel;
    [self.collImageView sd_setImageWithURL:[NSURL URLWithString:likeModel.picture] placeholderImage:GetImage(@"placeholder_80") options:SDWebImageProgressiveDownload | SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
