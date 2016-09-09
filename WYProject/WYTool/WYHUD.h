//
//  WYHUD.h
//  DaDaImage-iPhone2.0
//
//  Created by lwy1218 on 16/8/11.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WYHUD : NSObject
+ (instancetype)shareHUD;
- (void)hiddenMBHUD;
- (void)showHUDWithTitle:(NSString *)title;
- (void)showHUDWithTitle:(NSString *)title autoHidden:(BOOL)autoHidden;
@end
