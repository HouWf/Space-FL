//
//  SpaceKeyboardView.m
//  WaterFallForWorkSpace
//
//  Created by hzhy001 on 2019/3/1.
//  Copyright © 2019 hzhy001. All rights reserved.
//

#import "SpaceKeyboardView.h"

@interface SpaceKeyboardView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView *bottomBgView;

@property (nonatomic, strong) UIButton *senderBtn;

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation SpaceKeyboardView

- (void)showView
{
    [self setHidden:NO];
}

- (void)hideView
{
    [self setHidden:YES];
}

- (void)setReplyPlaceholderString:(NSString *)placeHolder
{
    if (placeHolder.length != 0) {
        NSString *name = placeHolder;
        NSString *string = [NSString stringWithFormat:@"回复：%@",name];
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName : rgba(41, 122, 204, 1)} range:[string rangeOfString:name]];
        [attributeStr addAttributes:@{NSForegroundColorAttributeName : rgba(153, 153, 153, 1)} range:[string rangeOfString:@"回复："]];
        self.placeHolderLabel.hidden = NO;
        self.placeHolderLabel.attributedText = attributeStr;
    }
    else{
        self.placeHolderLabel.text = @"";
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, Main_Screen_Height-k_Height_TabBar, Main_Screen_Width, k_Height_TabBar);
        self.backgroundColor = [UIColor clearColor];
        
        [self addNotification];
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.bottomBgView];
    [self.bottomBgView addSubview:self.textView];
    [self.bottomBgView addSubview:self.senderBtn];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPress:)];
    tapGesture.numberOfTapsRequired=1;
    [self addGestureRecognizer:tapGesture];
}

/**
 noti
 */
-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = keyboardF.origin.y;
    
    self.mj_y = 0;
    self.height = Main_Screen_Height;
    self.bottomBgView.mj_y = Main_Screen_Height-k_Height_TabBar;
    
    [UIView animateWithDuration:duration animations:^{
        self.bottomBgView.mj_y = keyboardY-49;
    }];
}

- (void)keyboardWillhide:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat keyboardY = keyboardF.origin.y;
    
    self.mj_y = Main_Screen_Height-k_Height_TabBar;
    self.height = k_Height_TabBar;
    self.bottomBgView.mj_y = 0;
    
    [UIView animateWithDuration:duration animations:^{
        self.bottomBgView.mj_y = 0;
    }];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    //    NSDictionary *userInfo = notification.userInfo;
    //    // 动画的持续时间
    //    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    // 键盘的frame
    //    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //    CGFloat keyboardY = keyboardF.origin.y;
    //
    //    [UIView animateWithDuration:duration animations:^{
    //        self.bottomBgView.mj_y = keyboardY-49;
    //    }];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification
{
    
}

#pragma mark - Action
- (void)handleTapPress:(UITapGestureRecognizer *)gestureRecognizer
{
    [self endEditing:YES];
}

- (void)senderBtnClick
{
    if (self.textView.text.length<=0) {
        return;
    }
    [self endEditing:YES];
    self.textView.text = @"";
    if ([self.delegate respondsToSelector:@selector(keyboardInputViewSendTextMessage:)]) {
        [self.delegate keyboardInputViewSendTextMessage:self.textView.text];
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.placeHolderLabel.hidden = textView.text.length != 0;
    });
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [self senderBtnClick];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    self.placeHolderLabel.hidden = textView.text.length != 0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma makr - Lazy
- (UIView *)bottomBgView
{
    if (!_bottomBgView) {
        _bottomBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, k_Height_TabBar)];
        _bottomBgView.backgroundColor = [UIColor whiteColor];
        
        //        UIView * bLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _bottomBgView.width, 0.5f)];
        //        bLine.backgroundColor = [UIColor grayColor];
        //        [_bottomBgView addSubview:bLine];
    }
    return _bottomBgView;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 7, Main_Screen_Width-15-80, 35)];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.scrollsToTop = NO;
        _textView.layer.masksToBounds = YES;
        _textView.layer.cornerRadius = 5.0f;
        _textView.layer.borderWidth = 0.5f;
        _textView.layer.borderColor= rgba(204, 204, 204, 1).CGColor;
        _textView.backgroundColor = rgba(242, 242, 242, 1);
        _textView.returnKeyType = UIReturnKeySend;
        _textView.delegate = self;
        
        [_textView addSubview:self.placeHolderLabel];
    }
    return _textView;
}

- (UILabel *)placeHolderLabel{
    if (!_placeHolderLabel) {
        
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.frame = CGRectMake(5, 0, Main_Screen_Width-100, 35);
        _placeHolderLabel.textColor = rgba(153, 153, 153, 1);
        _placeHolderLabel.font = FONT_SC(14);
    }
    return _placeHolderLabel;
}

- (UIButton *)senderBtn
{
    if (!_senderBtn) {
        _senderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _senderBtn.frame = CGRectMake(Main_Screen_Width-65, 13, 50, 24);
        [_senderBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_senderBtn setTitleColor:rgba(153, 153, 153, 1) forState:UIControlStateNormal];
        _senderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _senderBtn.layer.cornerRadius = 7;
        _senderBtn.layer.masksToBounds = YES;
        _senderBtn.layer.borderColor = rgba(153, 153, 153, 1).CGColor;
        _senderBtn.layer.borderWidth = 0.5f;
        [_senderBtn addTarget:self action:@selector(senderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _senderBtn;
}

@end
