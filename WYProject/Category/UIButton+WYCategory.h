//
//  UIButton+WYCategory.h
//  DaDaImage-iPhone2.0
//
//  Created by lwy1218 on 16/6/22.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WYCategory)

@property (nonatomic , copy)   NSString *wy_title_Normal;
@property (nonatomic , copy)   NSString *wy_title_Selected;
@property (nonatomic , strong) UIImage *wy_backgroundImage_Normal;
@property (nonatomic , strong) UIImage *wy_backgroundImage_Selected;
/**只用来设置不同状态下的背景颜色  需要给过frame才能设置 而且该背景颜色是没有圆角的 设置圆角的背景颜色应该是backgroundColor_Normal_CircularItem**/
@property (nonatomic , strong) UIColor *wy_backgroundColor_Normal;
/**只用来设置不同状态下的背景颜色 需要给过frame才能设置 而且该背景颜色是没有圆角的 设置圆角的背景颜色应该是backgroundColor_Selected_CircularItem**/
@property (nonatomic , strong) UIColor *wy_backgroundColor_Selected;
@property (nonatomic , strong) UIImage *wy_image_Normal;
@property (nonatomic , strong) UIImage *wy_image_Selected;
@property (nonatomic , strong) UIColor *wy_titleColor_Normal;
@property (nonatomic , strong) UIColor *wy_titleColor_Selected;
@property (nonatomic , assign) CGFloat wy_borderWidth;
@property (nonatomic , strong) UIColor *wy_borderColor;
@property (nonatomic , assign) CGFloat wy_cornerRadius;
/**设置圆形的button的Normal的背景颜色**/
@property (nonatomic , strong) UIColor *wy_backgroundColor_Normal_CircularItem;
/**设置圆形的button的背景图片**/
@property (nonatomic , strong) UIColor *wy_backgroundColor_Selected_CircularItem;
/**阴影颜色**/
@property (nonatomic , strong) UIColor *wy_shadowColor;

@property (nonatomic , assign) CGSize wy_shadowOffset;
/**阴影不透明度**/
@property (nonatomic , assign) CGFloat wy_shadowOpacity;

@property (nonatomic , strong) UIFont *wy_titleFont;

+ (instancetype)wyShareButton;

- (void)wy_addTarget:(id)target action:(SEL)action;
@end
