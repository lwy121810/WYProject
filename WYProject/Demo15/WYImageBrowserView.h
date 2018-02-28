//
//  WYImageBrowserView.h
//  WYImageBrowserViewDemo
//
//  Created by lwy on 2018/2/26.
//  Copyright © 2018年 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>


#define WYIMAGEBROWSERVIEWUNAVAILABLE __attribute__((unavailable("请使用‘(initWithOriginImage:highlightedImage:fromRect:)方法进行初始化’")))

@interface WYImageBrowserView : UIView
/// 动画时间 默认0.5s
@property (nonatomic , assign) double animationDuration;
/// 最小缩放比例 默认 1
@property (nonatomic , assign) CGFloat minimumZoomScale;
/// 最大缩放比例 默认 2
@property (nonatomic , assign) CGFloat maximumZoomScale;

- (instancetype)initWithFrame:(CGRect)frame WYIMAGEBROWSERVIEWUNAVAILABLE;
- (instancetype)init WYIMAGEBROWSERVIEWUNAVAILABLE;


/**
 初始化

 @param originImage 原图片（缩略图）
 @param highlightedImage 高清图
 @param fromRect fromRect description
 @return return value description
 */
- (instancetype)initWithOriginImage:(UIImage *)originImage
                   highlightedImage:(UIImage *)highlightedImage
                           fromRect:(CGRect)fromRect;


/**
 显示 等于 [showInView:nil];
 */
- (void)show;

/**
 显示

 @param view 如果为nil 显示在window上
 */
- (void)showInView:(UIView *)view;

/**
 消失

 @param animated 是否有动画
 @param completion completion description
 */
- (void)dismissWithAnimated:(BOOL)animated completion:(void(^)(void))completion;
@end
