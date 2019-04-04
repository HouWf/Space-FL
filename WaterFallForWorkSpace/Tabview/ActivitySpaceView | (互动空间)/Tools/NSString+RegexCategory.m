//
//  NSString+RegexCategory.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/1/29.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "NSString+RegexCategory.h"

@implementation NSString (RegexCategory)

//对象方法
-(CGSize) sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font{
    //属性字典根据字体大小
    NSDictionary * dict = @{NSFontAttributeName:font};
    
    //The specified origin is the line fragment origin, not the base line origin
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    return size;
}

//类方法
+(CGSize) sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font{
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}

@end
