//
//  WYTool_ShowMessage.h
//  WYPhotoPicker
//
//  Created by lwy1218 on 16/6/15.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**显示过渡动画**/
@interface WYTool_ShowMessage : NSObject
/**开始动画  显示加载中...或者自定义文字**/
+ (void)showWaitingAnimationWithText:(NSString *)text;
/**隐藏动画**/
+ (void)hideWaitingAnimation;


/**
 *  弹出信息框 适用于弹出之后回到上一个页面
 *
 *  @param message 信息
 */
+ (void)showMessage:(NSString *)message;


/**
 *  弹出信息框 适用于弹出之后停留在当前页面 Class 传入的是什么类型的对象  view 或者Vc
 *
 *  @param message      展示的信息
 *  @param Class 传入的是什么类型  view 或者Vc
 */
+ (void)showMessage:(NSString *)message Class:(id)view;

/**含有确定取消按钮提示框 含有确认按钮的点击事件*/
+ (void)showMessage:(NSString *)message title:(NSString *)title Class:(id)view determineItemBlock:(void(^)())determineItemBlock;

/**只有一个确定按钮提示框 含有确认按钮的点击事件*/
- (void)showMessage:(NSString *)message title:(NSString *)title Class:(id)view confirmItemBlock:(void(^)())confirmItemBlock;

- (void)dismissAlertVc;
+ (instancetype)shareShowMessage;
@end
