//
//  SpaceKeyboardView.h
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/3/1.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol KeyboardViewDelegate <NSObject>

-(void)keyboardInputViewSendTextMessage:(NSString *)message;

@end


@interface SpaceKeyboardView : UIView

@property (nonatomic, strong) UITextView * textView;

@property(nonatomic,weak)id<KeyboardViewDelegate>delegate;

/**
 设置回复占位

 @param placeHolder 站位内容（名称）
 */
- (void)setReplyPlaceholderString:(NSString *)placeHolder ;

- (void)showView;

- (void)hideView;

@end

NS_ASSUME_NONNULL_END
