//
//  BFPActivitySpaceModel.h
//  BFPlus
//
//  Created by hzhy001 on 2018/12/27.
//  Copyright © 2018 hzhy001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SDTimeLineCellLikeItemModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *picture;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end


@interface SDTimeLineCellCommentItemModel : NSObject

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstPicure;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, copy) NSString *secondUserId;

@property (nonatomic, copy) NSAttributedString *attributedContent;

@end

@interface BFPActivitySpaceModel : NSObject

@property (nonatomic, copy) NSString *iconNameUrl;

@property (nonatomic, copy) NSString *nameStr;

@property (nonatomic, copy) NSString *contentStr;

@property (nonatomic, strong) NSArray *pictureArray;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *commentNum;

@property (nonatomic, copy) NSString *faousNum;

@property (nonatomic, copy) NSString *cityName;

@property (nonatomic, strong) NSArray<SDTimeLineCellLikeItemModel *> *likeItemsArray;

@property (nonatomic, strong) NSArray<SDTimeLineCellCommentItemModel *> *commentItemsArray;


@property (nonatomic, strong) VideoModel *videoModel;

@property (nonatomic, assign) BOOL liked;

@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign) BOOL shouldShowMoreButton;

@end


NS_ASSUME_NONNULL_END
