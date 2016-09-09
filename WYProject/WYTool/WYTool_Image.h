//
//  WYTool_Image.h
//  WYPhotoPicker
//
//  Created by lwy1218 on 16/6/14.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WYTool_Image : NSObject
/**按照指定宽度按比例缩放图片  sourceImage 传入的图片 defineWidth**/
+ (UIImage *)zoomImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

/**根据颜色绘制一张图片 返回绘制后的图片**/
+ (UIImage *)imageWithColor:(UIColor *)color   size:(CGSize)size;

/**等比例缩放 size 指定缩放的size image:缩放的image**/
+ (UIImage *)scaleToSize:(CGSize)size withImage:(UIImage *)image;


/**缩放从顶部开始平铺图片**/
+ (UIImage *)imageScaleAspectFillFromTop:(CGSize)frameSize withImage:(UIImage *)image;

/**裁剪图片**/
+ (UIImage*)subImageInRect:(CGRect)rect withImage:(UIImage *)image;

+ (UIImage *)imageFillSize:(CGSize)viewsize withImage:(UIImage *)image;

/**图片剪切成圆形  sourceImage:需要剪切的原图片 borderWidth:剪切后的边框宽度 一般不要边框 设为0就好 borderColor:边框颜色**/
+ (UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**保存view为一张图片 即截屏*/
+ (UIImage *)captureImageWithView:(UIView *)view;
@end
