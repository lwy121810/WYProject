//
//  WYTool_DeviceAuthorization.m
//  CMKitDemo
//
//  Created by yons on 17/1/20.
//  Copyright © 2017年 yons. All rights reserved.
//

#import "WYTool_DeviceAuthorization.h"
#import <AVFoundation/AVFoundation.h>
@implementation WYTool_DeviceAuthorization

+ (BOOL)isHaveCameraAuthorization
{
    BOOL isHave = NO;
    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        isHave = YES;
    }
    
    return isHave;
}

+ (void)openCameraAuthorization
{
    // 无权限 引导去开启
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
#else
        [[UIApplication sharedApplication]  openURL:url];
#endif
    }
}


@end
