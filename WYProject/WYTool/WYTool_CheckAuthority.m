//
//  WYTool_CheckAuthority.m
//  WYPhotoPicker
//
//  Created by lwy1218 on 16/6/14.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYTool_CheckAuthority.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation WYTool_CheckAuthority
+ (BOOL)checkIsHavePhotoAlbumAuthority
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied) {
        
        CGFloat kSystemMainVersion = [UIDevice currentDevice].systemVersion.floatValue;
        NSString *title = nil;
        NSString *msg = @"还没有开启相册权限~请在系统设置中开启";
        NSString *cancelTitle = @"暂不";
        NSString *otherButtonTitles = @"去设置";
        
        if (kSystemMainVersion < 8.0) {
            title = @"相册权限未开启";
            msg = @"请在系统设置中开启相机服务\n(设置>隐私>相册>开启)";
            cancelTitle = @"知道了";
            otherButtonTitles = nil;
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherButtonTitles, nil];
        [alertView show];
        return NO;
    }else{
        return YES;
    }
}
#pragma mark - <UIAlertDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        CGFloat kSystemMainVersion = [UIDevice currentDevice].systemVersion.floatValue;
        if (kSystemMainVersion >= 8.0) { // ios8 以后支持跳转到设置 跳转到设置
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}

@end
