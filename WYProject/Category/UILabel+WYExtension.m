//
//  UILabel+WYExtension.m
//  WYProject
//
//  Created by lwy on 2018/4/9.
//  Copyright © 2018年 lwy1218. All rights reserved.
//

#import "UILabel+WYExtension.h"

@implementation UILabel (WYExtension)


/**
 改变行间距 字间距

 @param lineSpace 行间距
 @param wordSpace 字间距
 */
- (void)changeLineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    NSDictionary *dict = @{
                           NSKernAttributeName:@(wordSpace),
                           NSParagraphStyleAttributeName:style
                           };
    [self addAttributes:dict];
}
/**
 修改行间距
 
 @param space 间距
 */
- (void)changeLineSpace:(CGFloat)space {
    [self changeParagraphStyle:^(NSMutableParagraphStyle *paragraphStyle) {
        paragraphStyle.lineSpacing = space;
    }];
}


/**
 修改文字间的间距
 
 @param space 间距
 */
- (void)changeWordSpace:(CGFloat)space {
    [self addAttribute:NSKernAttributeName value:@(space)];
}


/**
 改变文本的段落样式
 
 @param block block description
 */
- (void)changeParagraphStyle:(void(^)(NSMutableParagraphStyle *paragraphStyle))block
{
    NSString *text = self.text;
    if (text == nil || text.length == 0) {
        return;
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    if (block) {
        block(style);
    }
    if (style) {
        [self addAttribute:NSParagraphStyleAttributeName value:style];
    }
}

/**
 为文本添加样式
 
 @param name NSAttributedStringKey
 @param value value description
 */
- (void)addAttribute:(NSAttributedStringKey)name value:(id)value
{
    [self _setAttrText:^(NSMutableAttributedString *mutableAttr) {
        NSRange range = NSMakeRange(0, mutableAttr.length);
        [mutableAttr addAttribute:name value:value range:range];
    }];
}

- (void)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs
{
    [self _setAttrText:^(NSMutableAttributedString *mutableAttr) {
        NSRange range = NSMakeRange(0, mutableAttr.length);
        [mutableAttr addAttributes:attrs range:range];
    }];
}

- (void)_setAttrText:(void(^)(NSMutableAttributedString *mutableAttr))block
{
    NSMutableAttributedString *mutableAttr = nil;
    if (self.attributedText && self.attributedText.length > 0) {
        mutableAttr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }
    else if (self.text && self.text.length > 0) {
        mutableAttr = [[NSMutableAttributedString alloc] initWithString:self.text];
    }
    
    if (mutableAttr == nil) return;
    
    if (block) {
        block(mutableAttr);
    }
    if (mutableAttr) {
        [self setAttributedText:mutableAttr];
        [self sizeToFit];
    }
}
@end
