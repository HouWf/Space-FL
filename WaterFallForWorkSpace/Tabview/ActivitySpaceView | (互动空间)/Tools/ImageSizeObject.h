//
//  ImageSizeObject.h
//  AutoLayoutForCell
//
//  Created by hzhy001 on 2018/5/7.
//  Copyright © 2018年 hzhy001. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageSizeObject : NSObject

+ (instancetype)shared;

/**
 获取图片大小

 @param URL url
 @return size
 */
- (CGSize)getImageSizeWithURL:(id)URL;

//  获取PNG图片的大小
-(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request;

//  获取GIF图片的大小
-(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request;

//  获取JPG图片的大小
-(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request;

@end
