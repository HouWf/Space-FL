//
//  PhotoContainerView.m
//  AutoLayoutForCell
//
//  Created by hzhy001 on 2018/5/7.
//  Copyright © 2018年 hzhy001. All rights reserved.
//

#import "PhotoContainerView.h"
#import "SDPhotoBrowser.h"
#import "UIImageView+WebCache.h"
#import "ImageSizeObject.h"
//#import "UIImage+GIF.h"

#define kMaxWidth 300*kScreenWidthRatio
#define kItemSpace 8*kScreenWidthRatio

@interface PhotoContainerView()<SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;

@end

@implementation PhotoContainerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setPhotoView];
    }
    return self;
}

/**
 创建视图
 */
- (void)setPhotoView{
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i< 9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.tag = i;
        UITapGestureRecognizer *tapGesutre = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        
        [imageView addGestureRecognizer:tapGesutre];
        [self addSubview:imageView];
        [tempArray addObject:imageView];
    }
    
    self.imageViewsArray = [NSMutableArray arrayWithArray:tempArray];
}

/**
 set方法设置视图

 @param picPathStringsArray 图片数组
 */
- (void)setPicPathStringsArray:(NSArray *)picPathStringsArray{
    _picPathStringsArray = picPathStringsArray;
    // 隐藏超出视图（放到创建时隐藏会有问题）
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    if (_picPathStringsArray.count == 0) {
        self.height_sd = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    NSMutableArray *picArr = [NSMutableArray arrayWithCapacity:9];
    if (_picPathStringsArray.count > 9) {
        for (NSInteger index = 0; index < 9; index++) {
            [picArr addObject:_picPathStringsArray[index]];
        }
        _picPathStringsArray = picArr;
    }
    
    // 宽高
    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = 0;
    BOOL urlAdd = [_picPathStringsArray.firstObject hasPrefix:@"http:"] || [_picPathStringsArray.firstObject hasPrefix:@"https:"];
    if (_picPathStringsArray.count == 1) {
        // 判断是网络加载还是本地
        if (urlAdd) {
            CGSize size = [[ImageSizeObject shared] getImageSizeWithURL:_picPathStringsArray[0]];
            itemH = 0.5*itemW; // size.height / size.width * itemW;
        }
        else{
            UIImage *image = [UIImage imageNamed:_picPathStringsArray.firstObject];
            if (image.size.width) {
                itemH = 0.5*itemW; //image.size.height / image.size.width * itemW;
            }
        }
    }
    else {
        if (self.autoHeight) {
            itemH = itemW*self.autoHeight;
        }
        else{
            itemH = itemW;
        }
    }
    
    // 每行视图数
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = kItemSpace;
    // 设置frame
    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.frame = CGRectMake(columnIndex * (itemW + margin), rowIndex * (itemH + margin), itemW, itemH);
//        [[BesTool share] cornerRadiusView:imageView cornerRadius:5];
        if (urlAdd) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:obj] placeholderImage:[UIImage imageNamed:@"big_placeholder"] options:SDWebImageProgressiveDownload];
        }
        else{
            imageView.image = [UIImage imageNamed:obj];
        }
    }];
    
    // 获取总宽高
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * margin;
    int columnCount = ceilf(_picPathStringsArray.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * margin;
    self.width_sd = w;
    self.height_sd = h;
    self.fixedHeight = @(h);
    self.fixedWidth = @(w);
}

/**
 获取宽度

 @param picArray 图片数组
 @return 宽度
 */
- (CGFloat)itemWidthForPicPathArray:(NSArray *)picArray{
    if (self.pictureWidth != 0) {
        return self.pictureWidth;
    }
    else{
        if (picArray.count == 1) {
            return kMaxWidth;
        }
        else if (picArray.count == 2){
            return (kMaxWidth-kItemSpace)/2.f;
        }
        else{
            CGFloat width = (kMaxWidth - 2*kItemSpace)/3.f;
            return width;
        }
    }
}

/**
 获取每行展示图片数

 @param array 图片数组
 @return 数量
 */
- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (self.perRowItemCount != 0) {
        return self.perRowItemCount;
    }
    else{
        if (array.count < 3) {
            return array.count;
        }
//        else if (array.count <= 5) {
//            return 2;
//        }
        else {
            return 3;
        }
    }
}

- (void)tapGesture:(UIGestureRecognizer *)gesture{
    UIView *tapView = gesture.view;
    NSLog(@"tapView tag %ld",tapView.tag);
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.currentImageIndex = tapView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];
}


#pragma mark - SDPhotoBrowserDelegate

- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *imageName = self.picPathStringsArray[index];
    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
    return url;
}

- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}


@end
