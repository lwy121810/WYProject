//
//  WYTool_Animation.h
//  DaDaImage-iPhone2.0
//
//  Created by lwy1218 on 16/6/23.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WYTool_Animation : NSObject

/**
 *  打开菜单
 *
 *  @param view     打开的view
 *  @param from     开始的位置
 *  @param to       到达的位置
 *  @param duration 时间
 */
+ (void)showSomeView:(UIView *)view
           fromPoint:(CGPoint)from
             toPoint:(CGPoint)to
            duration:(CFTimeInterval)duration;

/**
 *  收回菜单
 *
 *  @param view     要收回的view
 *  @param from     开始的位置
 *  @param to       到某个位置
 *  @param duration 时间
 */
+ (void)takeBackSomeView:(UIView *)view
               fromPoint:(CGPoint)from
           toOriginPoint:(CGPoint)to
                duration:(CFTimeInterval)duration;

/**加载动画 范围0-1 可用于显示下载进度*/
+ (void)showProgress:(CGFloat)toValue animationFrame:(CGRect)frame superView:(UIView *)superView
;
@end
