//
//  FKWalletAlertView.m
//  FiveKilometer
//
//  Created by 李卫友 on 2017/4/1.
//  Copyright © 2017年 utouu-imac. All rights reserved.
//

#import "FKWalletAlertView.h"
#import "UIView+Extension.h"
@interface FKWalletAlertView  ()
{
    CGRect keyboardFrame;
    CGFloat originY;
}
@property (nonatomic , strong) UIView *backView;
@end
@implementation FKWalletAlertView
- (UIView *)backView
{
    if (!_backView) {
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = [UIColor lightGrayColor];
        self.backView.alpha = .6;
    }
    return _backView;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addNotification];
}
- (void)addNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)keyboardWillShown:(NSNotification *) notify{
    
    
    keyboardFrame = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect beginKeyboardFrame = [[[notify userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    //取得键盘的动画时间，这样可以在视图上移的时候更连贯
    
    double duration = [[[notify userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (keyboardFrame.size.height > 0 && beginKeyboardFrame.origin.y - keyboardFrame.origin.y > 0) {
        
        __weak typeof(self) weakSelf = self;
        
        [UIView animateWithDuration:duration ? duration : 0.25f animations:^{
            
            CGRect alertViewFrame = weakSelf.frame;
            
            
            alertViewFrame.origin.y = keyboardFrame.origin.y - alertViewFrame.size.height - 10;
            
            weakSelf.frame = alertViewFrame;
            
            weakSelf.center = CGPointMake(SCREEN_WIDTH / 2 , weakSelf.center.y);
       
            
        } completion:^(BOOL finished) {}];
        
    }
    
}

- (void)keyboardWillHidden:(NSNotification *) notify{
    
    keyboardFrame = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    double duration = [[[notify userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:duration ? duration : 0.25f animations:^{
        
        
        CGRect alertViewFrame = weakSelf.frame;
        
        
        alertViewFrame.origin.y = originY;
        weakSelf.frame = alertViewFrame;
        
        self.center = CGPointMake(SCREEN_WIDTH / 2 , weakSelf.center.y);
        
    } completion:^(BOOL finished) {}];
    
}

- (void)alertShow
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.subviews containsObject:self]) {
        
        return;
    }
    self.backView.frame = window.bounds;
    [window addSubview:self.backView];
    
    [window addSubview:self];
    CGFloat w = 270;
    CGFloat x = (SCREEN_WIDTH - w) * 0.5;
    CGRect frame = CGRectMake(x, 195, w, 250);
    self.frame = frame;
    originY = self.y;
    
//    [UIView animateWithDuration:0.25 animations:^{
//        self.center = window.center;
//    } completion:^(BOOL finished) {
//         self.frame = frame;
//    }];
}
- (IBAction)confirmAction:(id)sender {
    if (self.itemCallBack) {
        self.itemCallBack(1);
    }
}
- (IBAction)cancelAction:(id)sender {
    if (self.itemCallBack) {
        self.itemCallBack(0);
    }
}
- (void)dismiss
{
    if (self.superview) {
        [self removeFromSuperview];
        [self.backView removeFromSuperview];
    }
}
@end
