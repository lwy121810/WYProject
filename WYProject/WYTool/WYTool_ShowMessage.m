//
//  WYTool_ShowMessage.m
//  WYPhotoPicker
//
//  Created by lwy1218 on 16/6/15.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYTool_ShowMessage.h"

#define GreenColor [UIColor colorWithRed:54/255.0 green:174/255.0 blue:161/255.0 alpha:1]
@implementation WYTool_ShowMessage
{
    UIAlertController *  _alertVc;
}
+ (void)showWaitingAnimationWithText:(NSString *)text{
    //    [self hideWaitingAnimation];
    [self showMessageWithText:text ?: @"加载中..."];
}

+ (void)hideWaitingAnimation{
    UILabel *alertLabel = [[UIApplication sharedApplication].keyWindow viewWithTag:10001];
    [UIView animateWithDuration:1.0 animations:^{
        alertLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [alertLabel removeFromSuperview];
    }];
}

+ (void)showMessageWithText:(NSString *)text{
    UILabel *alertLabel = [[UILabel alloc] init];
    alertLabel.tag = 10001;
    alertLabel.font = [UIFont systemFontOfSize:15];
    alertLabel.text = text;
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.layer.masksToBounds = YES;
    alertLabel.textColor = [UIColor whiteColor];
    alertLabel.bounds = CGRectMake(0, 0, 100, 40);
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    alertLabel.center = CGPointMake(w * 0.5, h * 0.5);
    alertLabel.backgroundColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:0.8];
    alertLabel.layer.cornerRadius = 5.0f;
    [[UIApplication sharedApplication].keyWindow addSubview:alertLabel];
}

/**
 *  弹出信息框 适用于弹出之后停留在当前页面 Class 传入的是什么类型的对象  view 或者Vc
 *
 *  @param message      展示的信息
 *  @param Class 传入的是什么类型  view 或者Vc
 */
+ (void)showMessage:(NSString *)message Class:(id)class
{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        if ([class isKindOfClass:[UIViewController class]]) {
            UIViewController *vc = (UIViewController *)class;
            [vc presentViewController:alert animated:YES completion:nil];
        }else if ([class isKindOfClass:[UIView class]]){
            UIView *view = (UIView *)class;
            UIViewController *vc = [self getCurrentViewControllerWithView:view];
            [vc presentViewController:alert animated:YES completion:nil];
        }
}


/**
 *  弹出信息框 适用于弹出之后回到上一个页面
 *
 *  @param message 信息
 */
+ (void)showMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    //得到当前的控制器
    UIViewController *vc = [self getCurrentVC];
    [vc presentViewController:alert animated:YES completion:nil];
}
/**
 *  得到view所在的控制器
 *
 *  @param currentView 当前的view
 *
 *  @return 返回view所在的控制器
 */
+ (UIViewController *)getCurrentViewControllerWithView:(UIView *)currentView
{
    for (UIView *view = currentView; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (void)showMessage:(NSString *)message title:(NSString *)title Class:(id)class determineItemBlock:(void (^)())determineItemBlock
{
    
    UIAlertController *alert =  [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (determineItemBlock) {
            determineItemBlock();
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:done];
    [alert addAction:cancel];
    
    [done setValue:GreenColor forKey:@"_titleTextColor"];
    [cancel setValue:GreenColor forKey:@"_titleTextColor"];
    
    if (message) {
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertMessageStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, message.length)];
        [alert setValue:alertMessageStr forKey:@"attributedMessage"];
    }
    /*title*/
    if (title) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:GreenColor range:NSMakeRange(0, title.length)];
        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
    }
    
    if ([class isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)class;
        [vc presentViewController:alert animated:YES completion:nil];
    }else if ([class isKindOfClass:[UIView class]]){
        UIView *view = (UIView *)class;
        UIViewController *vc = [self getCurrentViewControllerWithView:view];
        [vc presentViewController:alert animated:YES completion:nil];
    }
}
/**
 *  得到当前的控制器
 */
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (instancetype)shareShowMessage
{
    static WYTool_ShowMessage *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[self alloc] init];
    });
    return tool;
}

- (void)dismissAlertVc
{
    [_alertVc dismissViewControllerAnimated:YES completion:nil];
}

/**只有一个确定按钮提示框 含有确认按钮的点击事件*/
- (void)showMessage:(NSString *)message title:(NSString *)title Class:(id)class confirmItemBlock:(void (^)())confirmItemBlock
{
    UIAlertController *alert =  [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (confirmItemBlock) {
            confirmItemBlock();
        }
    }];
    [alert addAction:done];
    
    [done setValue:GreenColor forKey:@"_titleTextColor"];
    
    if (message) {
        NSMutableAttributedString *alertMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
        [alertMessageStr addAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, message.length)];
        [alert setValue:alertMessageStr forKey:@"attributedMessage"];
    }
    /*title*/
    if (title) {
        NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:title];
        [alertControllerStr addAttribute:NSForegroundColorAttributeName value:GreenColor range:NSMakeRange(0, title.length)];
        [alert setValue:alertControllerStr forKey:@"attributedTitle"];
    }
    
    if ([class isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)class;
        [vc presentViewController:alert animated:YES completion:nil];
    }else if ([class isKindOfClass:[UIView class]]){
        UIView *view = (UIView *)class;
        UIViewController *vc = [WYTool_ShowMessage getCurrentViewControllerWithView:view];
        [vc presentViewController:alert animated:YES completion:nil];
    }
    _alertVc = alert;
}
@end
