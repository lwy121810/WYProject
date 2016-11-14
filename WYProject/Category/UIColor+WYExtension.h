//
//  UIColor+WYExtension.h
//  xianshi
//
//  Created by mac on 16/10/22.
//  Copyright © 2016年 dengchunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WYExtension)

+ (UIColor*)colorWithHexRGB:(NSUInteger)hexRGB;
+ (UIColor*)colorForHex:(NSString*)hexColor;
+ (UIColor *)randomColor;
@end
