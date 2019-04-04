//
//  ImageSizeObject.m
//  AutoLayoutForCell
//
//  Created by hzhy001 on 2018/5/7.
//  Copyright © 2018年 hzhy001. All rights reserved.
//

#import "ImageSizeObject.h"
#import "SDImageCache.h"

static ImageSizeObject *imageSizeObj = nil;

@implementation ImageSizeObject

+ (instancetype)shared{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageSizeObj = [[ImageSizeObject alloc] init];
    });
    return imageSizeObj;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageSizeObj = [super allocWithZone:zone];
    });
    return imageSizeObj;
}

/**
 *  根据图片url获取图片尺寸
 */
- (CGSize)getImageSizeWithURL:(id)URL{
    // 制作url
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    
    // 读缓存或者加载
    NSString* absoluteString = url.absoluteString;
    if([[SDImageCache sharedImageCache] diskImageDataExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:url.absoluteString];
            image = [UIImage imageWithData:data];
        }
        else
        {
            return image.size;
        }
    }
    
    // 根据类型获取图片尺寸
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString* pathExtendsion = [url.pathExtension lowercaseString];
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    
    // 如果获取文件头信息失败,发送异步请求请求原图 1
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            //如果未使用SDWebImage，则忽略；缓存该图片
#ifdef dispatch_main_sync_safe
//            [[SDImageCache sharedImageCache] storeImage:image imageData:data forKey:url.absoluteString toDisk:YES completion:nil];
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:url.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    
    // 如果获取文件头信息失败 2
    // 如果对加载速度及用户体验要求不高的话，可以通过主线程获取图片大小,会阻塞主线程,慎重使用!!!
//    __block CGSize imageSize = CGSizeZero;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (CGSizeEqualToSize(CGSizeZero, size)) {
            //直接获取图片大小
            NSData *data = [NSData dataWithContentsOfURL:URL];
            UIImage *image = [UIImage imageWithData:data];
            size = image.size;
        }
//    });
    
    return size;
}

//  获取PNG图片的大小

-(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request

{
    
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(data.length == 8)
        
    {
        
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        
        return CGSizeMake(w, h);
        
    }
    return CGSizeZero;
    
}

//  获取GIF图片的大小

-(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request

{
    
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if(data.length == 4)
        
    {
        
        short w1 = 0, w2 = 0;
        
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        
        short w = w1 + (w2 << 8);
        
        short h1 = 0, h2 = 0;
        
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        
        short h = h1 + (h2 << 8);
        
        return CGSizeMake(w, h);
        
    }
    
    return CGSizeZero;
    
}
//  获取JPG图片的大小

-(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request

{
    
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
    
    if ([data length] <= 0x58) {
        
        return CGSizeZero;
        
    }
    
    
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        
        short w1 = 0, w2 = 0;
        
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        
        short w = (w1 << 8) + w2;
        
        short h1 = 0, h2 = 0;
        
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        
        short h = (h1 << 8) + h2;
        
        return CGSizeMake(w, h);
        
    } else {
        
        short word = 0x0;
        
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        
        if (word == 0xdb) {
            
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            
            if (word == 0xdb) {// 两个DQT字段
                
                short w1 = 0, w2 = 0;
                
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                
                short w = (w1 << 8) + w2;
                
                short h1 = 0, h2 = 0;
                
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                
                short h = (h1 << 8) + h2;
                
                return CGSizeMake(w, h);
                
            } else {// 一个DQT字段
                
                short w1 = 0, w2 = 0;
                
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                
                short w = (w1 << 8) + w2;
                
                short h1 = 0, h2 = 0;
                
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                
                short h = (h1 << 8) + h2;
                
                return CGSizeMake(w, h);
                
            }
            
        } else {
            
            return CGSizeZero;
            
        }
        
    }
    
}
@end
