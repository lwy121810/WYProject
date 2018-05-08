//
//  UIViewController+WYExtension.h
//  WYProject
//
//  Created by lwy on 2018/4/16.
//  Copyright © 2018年 lwy1218. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^AlertActionHandler)(UIAlertAction *  action);

@interface UIViewController (WYExtension)


/**
 弹出系统alert 只有一个自定义的按钮
 
 @param title title
 @param message msg
 @param actionTitle 按钮标题
 @param otherAction 按钮事件
 */
- (void)presentAlertViewControllerWithTitle:(NSString *)title
                                    message:(NSString *)message
                                actionTitle:(NSString *)actionTitle
                                     action:(AlertActionHandler)otherAction;

/**
 弹出系统alert 包含取消和自定义的两个按钮
 
 @param title title
 @param message message
 @param cancelTitle 取消按钮的标题 如果为nil，则不会有取消按钮
 @param otherTitle 其他按钮的标题 如果为nil，则不会有该按钮
 @param cancelAction 取消按钮的事件
 @param otherAction 其他按钮的事件
 */
- (void)presentAlertViewControllerWithTitle:(NSString *)title
                                    message:(NSString *)message
                                cancelTitle:(NSString *)cancelTitle
                                 otherTitle:(NSString *)otherTitle
                               cancelAction:(AlertActionHandler)cancelAction
                                otherAction:(AlertActionHandler)otherAction;


/**
 弹出系统alert 只有一个取消按钮
 
 @param title title description
 @param message message description
 @param cancelActionTitle 取消按钮的标题
 @param cancelAction cancelAction description
 */
- (void)presentAlertViewControllerWithTitle:(NSString *)title
                                    message:(NSString *)message
                          cancelActionTitle:(NSString *)cancelActionTitle
                                     action:(AlertActionHandler)cancelAction;


/**
 弹出带有多个输入框（number 键盘）的alert
 
 @param title title description
 @param message message description
 @param placeholders placeholder数组
 @param cancelTitle cancelTitle description
 @param otherTitle otherTitle description
 @param cancelAction cancelAction description
 @param otherAction otherAction description
 */
- (void)presentAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                 placeholders:(NSArray <NSString *>*)placeholders
                  cancelTitle:(NSString *)cancelTitle
                   otherTitle:(NSString *)otherTitle
                 cancelAction:(AlertActionHandler)cancelAction
                  otherAction:(void(^)(NSArray<UITextField *> *textFields))otherAction;


/**
 弹出带有一个输入框的alert
 
 @param title title description
 @param message message description
 @param placeholder placeholder
 @param otherTitle otherTitle description
 @param otherAction otherAction description
 */
- (void)presentAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                  placeholder:(NSString *)placeholder
                   otherTitle:(NSString *)otherTitle
                  otherAction:(void(^)(NSString *text))otherAction;

/**
 弹出系统alert message左对其 包含取消和自定义的两个按钮
 
 @param title title
 @param message msg
 @param cancelTitle 取消按钮标题 （如果为nil，则没有该按钮）
 @param otherTitle 其他按钮标题
 @param cancelAction 取消按钮的点击事件
 @param otherAction 其他按钮的点击事件
 */
- (void)presentAlertViewControllerWithTitle:(NSString *)title
                                attrmessage:(NSString *)message
                                cancelTitle:(NSString *)cancelTitle
                                 otherTitle:(NSString *)otherTitle
                               cancelAction:(AlertActionHandler)cancelAction
                                otherAction:(AlertActionHandler)otherAction;

- (void)resetViewFrameWhenSafeAreaChanged:(UIView *)subview;


- (void)setRightBarButtonItemFont:(UIFont *)font;
- (void)setLeftBarButtonItemFont:(UIFont *)font;

- (void)setRightBarButtonItemWithTitle:(NSString *)title
                                action:(SEL)action;

- (void)setRightBarButtonItemWithTitle:(NSString *)title
                               handler:(void(^)(UIBarButtonItem *item))handler;


/**
 页面没有数据时 显示的view
 
 @param des 描述文本
 @param handler handler description
 */
- (void)showEmptyViewWithDescribe:(NSString *)des
                          handler:(void(^)(UIButton *sender))handler;


/**
 移除空数据view
 */
- (void)removeEmptyDataView;


/**
 设置页面是否有数据
 
 @param isEmpty YES:为空数据 会显示空数据view NO:有数据
 @param handler  isEmpty 为NO时 没有事件响应
 */
- (void)setEmptyState:(BOOL)isEmpty handler:(void(^)(UIButton *sender))handler;

- (void)startLoadingAnimating;
- (void)stopLoadingAnimating;

@end
