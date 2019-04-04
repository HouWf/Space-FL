//
//  BFPActivitySpaceModel.m
//  BFPlus
//
//  Created by hzhy001 on 2018/12/27.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import "BFPActivitySpaceModel.h"

extern CGFloat maxContentLabelHeight;

@implementation SDTimeLineCellLikeItemModel


@end

@implementation SDTimeLineCellCommentItemModel


@end

@interface BFPActivitySpaceModel ()
{
    CGFloat _lastContentWidth;
}

@end

@implementation BFPActivitySpaceModel

@synthesize contentStr = _contentStr;

- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
}

- (NSString *)contentStr{
    CGFloat contetW = Main_Screen_Width - 75*kScreenWidthRatio;
    if (contetW != _lastContentWidth) {
        
        _lastContentWidth = contetW;
        CGSize textSize = [NSString sizeWithText:_contentStr maxSize:CGSizeMake(contetW, MAXFLOAT) font:FONT_SC(14*kScreenWidthRatio)];
        if (textSize.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        }
        else{
            _shouldShowMoreButton = NO;
        }
    }
    return _contentStr;
}

- (void)setIsOpening:(BOOL)isOpening{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    }
    else{
        _isOpening = isOpening;
    }
}

+ (NSDictionary *)mj_objectClassInArray{
    //前边，是属性数组的名字，后边就是类名
    return @{@"likeItemsArray":@"SDTimeLineCellLikeItemModel",
             @"commentItemsArray":@"SDTimeLineCellCommentItemModel"
             };
}

@end
