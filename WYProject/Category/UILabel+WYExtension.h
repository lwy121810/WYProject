//
//  UILabel+WYExtension.h
//  WYProject
//
//  Created by lwy on 2018/4/9.
//  Copyright © 2018年 lwy1218. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WYExtension)

/**
 修改行间距
 
 @param space 间距
 */
- (void)changeLineSpace:(CGFloat)space;
/**
 修改文字间的间距
 
 @param space 间距
 */
- (void)changeWordSpace:(CGFloat)space;

/**
 改变行间距 字间距
 
 @param lineSpace 行间距
 @param wordSpace 字间距
 */
- (void)changeLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

/**
 改变文本的段落样式
 
 @param block block description
 */
- (void)changeParagraphStyle:(void(^)(NSMutableParagraphStyle *paragraphStyle))block;


/**
 为文本添加样式
 
 @param name NSAttributedStringKey
 @param value value description
 */
- (void)addAttribute:(NSAttributedStringKey)name value:(id)value;

@end
