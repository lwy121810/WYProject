//
//  WYManagerNavController.h
//  WYManagerNavViewController
//
//  Created by mac on 16/10/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define WYDebugWithAssert
@interface WYManagerNavController : UIViewController

- (instancetype)initWithViewControllers:(NSArray <UIViewController *> *)viewControllers;

/**设置子控制器的标题 如果文字长度跟子控制器的长度不一致会蹦... 不想崩的话关闭断言*/
- (void)setupTitles:(NSArray <NSString *>*)titles;


/**以下方法 未完待续-----*/
- (void)setTitleColor:(UIColor *)color;
- (void)setDownLineColor:(UIColor *)lineColor;
- (void)setTitleFont:(UIFont *)font;
@end
