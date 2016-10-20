//
//  WYTool_CheckAuthority.h
//  WYPhotoPicker
//
//  Created by lwy1218 on 16/6/14.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**检测相册权限的类**/
@interface WYTool_CheckAuthority : NSObject<UIAlertViewDelegate>
/**检查是否有相册权限  YES:有  NO:没有 没有的话会有弹窗提示**/
+ (BOOL)checkIsHavePhotoAlbumAuthority;

@end
