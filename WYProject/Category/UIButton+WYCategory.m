//
//  UIButton+WYCategory.m
//  DaDaImage-iPhone2.0
//
//  Created by lwy1218 on 16/6/22.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "UIButton+WYCategory.h"

@implementation UIButton (WYCategory)

+ (instancetype)wyShareButton
{
    return [UIButton buttonWithType:UIButtonTypeCustom];
}

- (void)setWy_title_Normal:(NSString *)title_Normal
{
    [self setTitle:title_Normal forState:UIControlStateNormal];
}
- (NSString *)wy_title_Normal
{
    return [self titleForState:UIControlStateNormal];
}

- (void)setWy_title_Selected:(NSString *)title_Selected
{
    [self setTitle:title_Selected forState:UIControlStateSelected];
}
- (NSString *)wy_title_Selected
{
    return [self titleForState:UIControlStateSelected];
}
- (void)setWy_backgroundImage_Normal:(UIImage *)backgroundImage_Normal
{
    [self setBackgroundImage:backgroundImage_Normal forState:UIControlStateNormal];
}
- (UIImage *)wy_backgroundImage_Normal
{
    return [self backgroundImageForState:UIControlStateNormal];
}

- (void)setWy_backgroundImage_Selected:(UIImage *)backgroundImage_Selected
{
    [self setBackgroundImage:backgroundImage_Selected forState:UIControlStateSelected];
}
- (UIImage *)wy_backgroundImage_Selected
{
    return [self backgroundImageForState:UIControlStateSelected];
}

- (void)setWy_backgroundColor_Normal:(UIColor *)backgroundColor_Normal
{
    UIImage *image = [self imageWithColor:backgroundColor_Normal size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateNormal];
}
- (UIColor *)wy_backgroundColor_Normal
{
    UIImage *image = [self backgroundImageForState:UIControlStateNormal];
    UIColor *color = [self colorWithImage:image];
    return  color;
}
- (void)setWy_backgroundColor_Selected:(UIColor *)backgroundColor_Selected
{
    UIImage *image = [self imageWithColor:backgroundColor_Selected size:self.frame.size];
    [self setBackgroundImage:image forState:UIControlStateSelected];
}
- (UIColor *)wy_backgroundColor_Selected
{
    UIImage *image = [self backgroundImageForState:UIControlStateSelected];
    UIColor *color = [self colorWithImage:image];
    return  color;
}

- (void)setWy_image_Normal:(UIImage *)image_Normal
{
    [self setImage:image_Normal forState:UIControlStateNormal];
}
- (UIImage *)wy_image_Normal
{
    return [self imageForState:UIControlStateNormal];
}

- (void)setWy_image_Selected:(UIImage *)image_Selected
{
    [self setImage:image_Selected forState:UIControlStateSelected];
}
- (UIImage *)wy_image_Selected
{
    return [self imageForState:UIControlStateSelected];
}

- (void)setWy_titleColor_Normal:(UIColor *)titleColor_Normal
{
    [self setTitleColor:titleColor_Normal forState:UIControlStateNormal];
}
- (UIColor *)wy_titleColor_Normal
{
    return [self titleColorForState:UIControlStateNormal];
}

- (void)setWy_titleColor_Selected:(UIColor *)titleColor_Selected
{
    [self setTitleColor:titleColor_Selected forState:UIControlStateSelected];
}
- (UIColor *)wy_titleColor_Selected
{
    return [self titleColorForState:UIControlStateSelected];
}

- (void)setWy_borderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}
- (CGFloat)wy_borderWidth
{
    return self.layer.borderWidth;
}

- (void)setWy_borderColor:(UIColor *)borderColor
{
    self.layer.borderColor =    borderColor.CGColor;
}
- (UIColor *)wy_borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setWy_cornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}
- (CGFloat)wy_cornerRadius
{
    return self.layer.cornerRadius;
}
- (void)setWy_shadowOffset:(CGSize)shadowOffset
{
    self.layer.shadowOffset =  shadowOffset;
}
- (CGSize)wy_shadowOffset
{
    return self.layer.shadowOffset;
}
- (void)setWy_shadowColor:(UIColor *)shadowColor
{
    self.layer.shadowColor = shadowColor.CGColor;
}
- (void)setWy_shadowOpacity:(CGFloat)shadowOpacity
{
    self.layer.shadowOpacity =  shadowOpacity;
}
- (CGFloat)wy_shadowOpacity
{
    return self.layer.shadowOpacity;
}
- (UIColor *)wy_shadowColor
{
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setWy_titleFont:(UIFont *)titleFont
{
    self.titleLabel.font = titleFont;
}
- (UIFont *)wy_titleFont
{
    return self.titleLabel.font;
}

/**设置圆形的button的背景图片**/
- (void)setWy_backgroundColor_Normal_CircularItem:(UIColor *)backgroundColor_Normal_CircularItem
{
    UIImage *image = [self imageWithColor:backgroundColor_Normal_CircularItem size:self.frame.size];
    UIImage *circleImage = [self circleImageWithImage:image borderWidth:0 borderColor:nil];
    [self setBackgroundImage:circleImage forState:UIControlStateNormal];
}
- (UIColor *)wy_backgroundColor_Normal_CircularItem
{
    UIImage *image = [self backgroundImageForState:UIControlStateNormal];
    UIColor *color = [self colorWithImage:image];
    return  color;
}

- (void)setWy_backgroundColor_Selected_CircularItem:(UIColor *)backgroundColor_Selected_CircularItem
{
    UIImage *image = [self imageWithColor:backgroundColor_Selected_CircularItem size:self.frame.size];
    UIImage *circleImage = [self circleImageWithImage:image borderWidth:0 borderColor:nil];
    [self setBackgroundImage:circleImage forState:UIControlStateSelected];
}
- (UIColor *)wy_backgroundColor_Selected_CircularItem
{
    UIImage *image = [self backgroundImageForState:UIControlStateSelected];
    UIColor *color = [self colorWithImage:image];
    return  color;
}

- (void)wy_addTarget:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}


/**裁剪图片为圆形**/
- (UIImage *)circleImageWithImage:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    CGFloat imageWidth = sourceImage.size.width + 2 * borderWidth;
    
    CGFloat imageHeight = sourceImage.size.height + 2 * borderWidth;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeight), NO, 0.0);
    
    UIGraphicsGetCurrentContext();
    
    CGFloat radius = (sourceImage.size.width < sourceImage.size.height?sourceImage.size.width:sourceImage.size.height)*0.5;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth * 0.5, imageHeight * 0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    bezierPath.lineWidth = borderWidth;
    
    [borderColor setStroke];
    
    [bezierPath stroke];
    
    [bezierPath addClip];
    
    [sourceImage drawInRect:CGRectMake(borderWidth, borderWidth, sourceImage.size.width, sourceImage.size.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
    
}

//image转color
- (UIColor *)colorWithImage:(UIImage *)image
{
    return [UIColor colorWithPatternImage:image];
}
//color转image
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
