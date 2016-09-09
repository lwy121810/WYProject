//
//  WYHUD.m
//  DaDaImage-iPhone2.0
//
//  Created by lwy1218 on 16/8/11.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYHUD.h"
#import "MBProgressHUD.h"

@implementation WYHUD
+ (instancetype)shareHUD
{
    static WYHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[self alloc] init];
    });
    return hud;
}
- (void)showHUDWithTitle:(NSString *)title toView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Set the label text.
    hud.label.text = title;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.0];
}
- (void)hiddenHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [MBProgressHUD hideHUDForView:view animated:YES];
}
- (void)hiddenMBHUD
{
    [self hiddenHUDForView:nil];
}
- (void)showHUDWithTitle:(NSString *)title
{
    if (title == nil) {
        title = @"登录中";
    }
    [self showHUDWithTitle:title toView:nil];
}
- (void)showHUDWithTitle:(NSString *)title autoHidden:(BOOL)autoHidden
{
    if (title == nil) {
        title = @"登录中";
    }
    [self showHUDWithTitle:title toView:nil];
}
@end
