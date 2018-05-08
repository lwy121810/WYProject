//
//  UIViewController+WYExtension.m
//  WYProject
//
//  Created by lwy on 2018/4/16.
//  Copyright © 2018年 lwy1218. All rights reserved.
//

#import "UIViewController+WYExtension.h"
#import <objc/runtime.h>
@implementation UIViewController (WYExtension)

/**
 弹出包含多个按钮的系统alert
 
 @param title 标题
 @param message msg
 @param buttonTitles 按钮标题组
 @param actionCallBack 回调
 */
- (void)presentAlertViewControllerWithTitle:(NSString *)title
                                    message:(NSString *)message
                               buttonTitles:(NSArray <NSString *>*)buttonTitles
                                     action:(void(^)(NSInteger index))actionCallBack
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [buttonTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actionCallBack) {
                actionCallBack(idx);
            }
        }];
        
        [alert addAction:action];
    }];
    [self presentViewController:alert animated:YES completion:nil];
}


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
                                     action:(AlertActionHandler)otherAction
{
    [self presentAlertViewControllerWithTitle:title message:message cancelTitle:nil otherTitle:actionTitle cancelAction:nil otherAction:otherAction];
}

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
                                     action:(AlertActionHandler)cancelAction
{
    
    [self presentAlertViewControllerWithTitle:title message:message cancelTitle:cancelActionTitle otherTitle:nil cancelAction:cancelAction otherAction:nil];
}
/**
 弹出系统alert 包含取消和自定义的两个按钮
 
 @param title title
 @param message msg
 @param cancelTitle 取消按钮标题 （如果为nil，则没有该按钮）
 @param otherTitle 其他按钮标题
 @param cancelAction 取消按钮的点击事件
 @param otherAction 其他按钮的点击事件
 */
- (void)presentAlertViewControllerWithTitle:(NSString *)title
                                    message:(NSString *)message
                                cancelTitle:(NSString *)cancelTitle
                                 otherTitle:(NSString *)otherTitle
                               cancelAction:(AlertActionHandler)cancelAction
                                otherAction:(AlertActionHandler)otherAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelAction];
        //        cancel.
        [alert addAction:cancel];
    }
    if (otherTitle) {
        
        UIAlertAction *other = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDestructive handler:otherAction];
        [alert addAction:other];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

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
                                otherAction:(AlertActionHandler)otherAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelAction];
        //        cancel.
        [alert addAction:cancel];
    }
    if (otherTitle) {
        
        UIAlertAction *other = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDestructive handler:otherAction];
        [alert addAction:other];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:message attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]}];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentLeft;//设置对齐方式
    paragraph.headIndent = 10;                  // 除了首行,全部缩进
    paragraph.firstLineHeadIndent = 10;         // 首行缩进
    
    
    
    [str setAttributes:@{NSParagraphStyleAttributeName:paragraph} range:NSMakeRange(0, str.length)];
    
    UILabel *label = nil;
    label.textAlignment = NSTextAlignmentLeft;
    [alert setValue:str forKeyPath:@"_attributedMessage"];
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)presentAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                  cancelTitle:(NSString *)cancelTitle
                   otherTitle:(NSString *)otherTitle
                 cancelAction:(AlertActionHandler)cancelAction
                  otherAction:(AlertActionHandler)otherAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelAction];
        //        cancel.
        [alert addAction:cancel];
    }
    if (otherTitle) {
        
        UIAlertAction *other = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDestructive handler:otherAction];
        [alert addAction:other];
    }
    
    //    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    //       textField.placeholder
    //    }];
    
    
    [self presentViewController:alert animated:YES completion:nil];
}


/**
 弹出带有输入框的alert
 
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
                  otherAction:(void(^)(NSArray<UITextField *> *textFields))otherAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableArray *textArr = @[].mutableCopy;
    if (placeholders.count > 0) {
        [placeholders enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.keyboardType = UIKeyboardTypePhonePad;
                textField.placeholder = obj;
                [textArr addObject:textField];
            }];
        }];
    }
    
    if (cancelTitle) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelAction];
        [alert addAction:cancel];
    }
    if (otherTitle) {
        
        UIAlertAction *other = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (textArr.count > 0) {
                if (otherAction) {
                    otherAction(textArr);
                }
            }
            else {
                if (otherAction) {
                    otherAction(nil);
                }
            }
        }];
        [alert addAction:other];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}



/**
 弹出带有输入框的alert
 
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
                  otherAction:(void(^)(NSString *text))otherAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    __block UITextField * alertTextField = nil;
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = placeholder;
        alertTextField = textField;
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    if (otherTitle) {
        UIAlertAction *other = [UIAlertAction actionWithTitle:otherTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (otherAction) {
                otherAction(alertTextField.text);
            }
        }];
        [alert addAction:other];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)resetViewFrameWhenSafeAreaChanged:(UIView *)subview
{
    if (subview == nil) return;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets =  self.view.safeAreaInsets;
        CGRect frame = self.view.bounds;
        frame.origin.x = safeAreaInsets.left;
        frame.origin.y = safeAreaInsets.top;
        frame.size.width -= safeAreaInsets.left + safeAreaInsets.right;
        frame.size.height -= safeAreaInsets.top + safeAreaInsets.bottom;
        subview.frame = frame;
    } else {
        // Fallback on earlier versions
        subview.frame = self.view.bounds;
    }
}


- (BOOL)_getCurrentOritation
{
    UIInterfaceOrientation oritation = [[UIApplication sharedApplication] statusBarOrientation];
    BOOL isPortrait = UIInterfaceOrientationIsPortrait(oritation);
    return isPortrait;
}


//强制旋转屏幕
- (void)orientationToPortrait:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];//前两个参数已被target和selector占用
    [invocation invoke];
}


- (void)setLeftBarButtonItemFont:(UIFont *)font
{
    if (font == nil) return;
    NSDictionary *attr = @{NSFontAttributeName:font};
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:attr forState:UIControlStateNormal];
}

- (void)setRightBarButtonItemFont:(UIFont *)font
{
    if (font == nil) return;
    NSDictionary *attr = @{NSFontAttributeName:font};
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attr forState:UIControlStateNormal];
}

- (void)setRightBarButtonItemWithTitle:(NSString *)title
                                action:(SEL)action
{
    [self setRightBarButtonItemWithTitle:title style:UIBarButtonItemStylePlain action:action];
}

- (void)setRightBarButtonItemWithTitle:(NSString *)title
                                 style:(UIBarButtonItemStyle)style
                                action:(SEL)action
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:style target:self action:action];
    self.navigationItem.rightBarButtonItem = item;
}


static const void *BKBarButtonItemBlockKey = &BKBarButtonItemBlockKey;

- (void)setRightBarButtonItemWithTitle:(NSString *)title
                               handler:(void(^)(UIBarButtonItem *item))handler
{
    [self setRightBarButtonItemWithTitle:title style:UIBarButtonItemStylePlain handler:handler];
}
- (void)setRightBarButtonItemWithTitle:(NSString *)title
                                 style:(UIBarButtonItemStyle)style
                               handler:(void(^)(UIBarButtonItem *item))handler
{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:style target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = item;
    objc_setAssociatedObject(self, BKBarButtonItemBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)rightItemAction:(UIBarButtonItem *)item
{
    void(^block)(UIBarButtonItem *) = objc_getAssociatedObject(self, BKBarButtonItemBlockKey);
    if (block) {
        block(item);
    }
}

static const void *WYNoDataViewKey = &WYNoDataViewKey;

static const void *WYNoDataViewBlockKey = &WYNoDataViewBlockKey;

- (void)showEmptyViewWithDescribe:(NSString *)des
                          handler:(void(^)(UIButton *sender))handler
{
    UIView *view = objc_getAssociatedObject(self, WYNoDataViewKey);
    if (view == nil) {
        view = [UIView new];
        objc_setAssociatedObject(self, WYNoDataViewKey, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self.view addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = self.view.bounds;
        
        CGFloat buttonH = 30;
        CGFloat tipH = 30;
        UILabel *tip = [view viewWithTag:800];
        if (tip == nil) {
            tip = [[UILabel alloc] init];
            [view addSubview:tip];
            tip.textAlignment = NSTextAlignmentCenter;
            CGFloat y = (CGRectGetHeight(view.frame) - buttonH - tipH) * 0.5;
            CGFloat w = CGRectGetWidth(view.frame);
            if (self.navigationController) {
                y -= 64;
            }
            tip.frame = CGRectMake(0, y, w, tipH);
            tip.font = [UIFont systemFontOfSize:14];
            
            
            CGFloat textH = [des boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: tip.font} context:nil].size.height;
            if (textH > CGRectGetHeight(tip.frame)) {
                CGRect frame = tip.frame;
                frame.size.height = textH;
                tip.frame = frame;
            }
            tip.text = des;
        }
        
        if (handler) {
            UIButton *button = [view viewWithTag:801];
            if (button == nil) {
                button = [UIButton buttonWithType:UIButtonTypeSystem];
                [button addTarget:self action:@selector(noDataAction:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                [button setTitle:@"刷新" forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:13];
                CGFloat buttonW = 80;
                CGFloat h = buttonH;
                CGFloat w = CGRectGetWidth(view.frame);
                CGFloat x = (w - buttonW) * 0.5;
                CGFloat buttonY = CGRectGetMaxY(tip.frame);
                button.frame = CGRectMake(x, buttonY, buttonW, h);
                button.tag = 801;
            }
            
            void (^_handler)(UIButton *) = objc_getAssociatedObject(self, WYNoDataViewBlockKey);
            if (_handler == nil) {
                objc_setAssociatedObject(self, WYNoDataViewBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
            }
        }
    }
}
- (void)noDataAction:(UIButton *)sender
{
    if (sender && sender.hidden) {
        sender.hidden = NO;
    }
    void (^handler)(UIButton *) = objc_getAssociatedObject(self, WYNoDataViewBlockKey);
    
    if (handler) {
        handler(sender);
    }
}

- (void)setEmptyState:(BOOL)isEmpty handler:(void(^)(UIButton *sender))handler
{
    if (isEmpty) {
        [self showEmptyViewWithDescribe:@"暂无数据" handler:handler];
    }
    else {
        [self removeEmptyDataView];
        if (handler) {
            handler(nil);
        }
    }
}

- (void)removeEmptyDataView
{
    UIView *view = objc_getAssociatedObject(self, WYNoDataViewKey);
    if (view == nil) {
        return;
    }
    
    [view removeFromSuperview];
    view = nil;
}
static char wy_activityIndicatorKey;

- (void)startLoadingAnimating
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (self.activityIndicator.superview != window) {
        if (self.activityIndicator.superview) {
            [self.activityIndicator removeFromSuperview];
        }
        self.activityIndicator.center = window.center;
        self.activityIndicator.bounds = CGRectMake(0, 0, 40, 40);
        [window addSubview:self.activityIndicator];
    }
    
    self.activityIndicator.alpha = 1.0;
    [self.activityIndicator startAnimating];
}

- (void)stopLoadingAnimating
{
    if (self.activityIndicator.isAnimating) {
        [UIView animateWithDuration:0.15 animations:^{
            self.activityIndicator.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.activityIndicator stopAnimating];
            [self.activityIndicator removeFromSuperview];
            self.activityIndicator = nil;
        }];
    }
}
- (UIActivityIndicatorView *)activityIndicator
{
    UIActivityIndicatorView *activityIndicator = objc_getAssociatedObject(self, &wy_activityIndicatorKey);
    if (activityIndicator == nil) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.hidesWhenStopped = YES;
        activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return activityIndicator;
}
- (void)setActivityIndicator:(UIActivityIndicatorView *)activityIndicator
{
    objc_setAssociatedObject(self, &wy_activityIndicatorKey, activityIndicator, OBJC_ASSOCIATION_RETAIN);
}

@end
