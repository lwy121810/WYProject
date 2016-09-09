//
//  WYTextField.m
//  yibolai
//
//  Created by lwy1218 on 16/9/6.
//  Copyright © 2016年 liangang. All rights reserved.
//

#import "WYTextField.h"

@implementation WYTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _underLineColor = [UIColor redColor];
        [self setup];
    }
    return self;
}
- (void)setLeftViewWidth:(CGFloat)leftViewWidth
{
    _leftViewWidth = leftViewWidth;
    [self leftViewRectForBounds:self.bounds];
}
- (void)setUnderLineColor:(UIColor *)underLineColor
{
    _underLineColor = underLineColor;
    
    [self setNeedsDisplay];
}
- (void)setLeftTitleFont:(UIFont *)leftTitleFont
{
//    _leftTitleFont = leftTitleFont;
    _leftLabel.font =  leftTitleFont;
}
-(UIFont *)leftTitleFont
{
    return _leftLabel.font;
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    
    [super leftViewRectForBounds:bounds];
    CGRect frame = bounds;
    
    frame.size.width = _leftViewWidth;
    
    return frame;
}
- (void)setup
{
    UILabel *label = [[UILabel alloc] init];
    self.leftView = label;
    self.leftViewMode = UITextFieldViewModeAlways;
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setTextColor:[UIColor colorWithRed:0.875 green:0.110 blue:0.337 alpha:1.000]];
    _leftLabel = label;
    
    _leftLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
}
- (void)drawRect:(CGRect)rect
{
    if (!_underLineColor) return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_underLineColor set];
    
    CGFloat y = CGRectGetHeight(self.bounds);
    CGContextMoveToPoint(context, 0, y);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), y);
    //设置线的宽度
    CGContextSetLineWidth(context, 2);
    //渲染 显示到self上
    CGContextStrokePath(context);
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    if (!self.placeholder) return;//必须先判断是否有placeholder 没有placeholder用这种方法的话会崩溃 可以使用KVC方式直接赋值
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = placeholderColor;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    [self setAttributedPlaceholder:attribute];
    
    //也可以通过KVC方式直接赋值 使用KVC赋值的时候 没有placeholder的时候会没有效果 显示的是系统默认的样式 但不会崩溃
//        [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont
{
    if (!self.placeholder) return; //必须先判断是否有placeholder 没有placeholder用这种方法的话会崩溃 可以使用KVC方式直接赋值
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = placeholderFont;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    [self setAttributedPlaceholder:attribute];
    //也可以通过KVC方式直接赋值 使用KVC赋值的时候 没有placeholder的时候会没有效果 显示的是系统默认的样式 但不会崩溃
//        [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
}
- (void)setLeftTitleColor:(UIColor *)leftTitleColor
{
    _leftTitleColor = leftTitleColor;
    [_leftLabel setTextColor:leftTitleColor];
}
- (void)setLeftTitle:(NSString *)leftTitle
{
    _leftTitle = leftTitle;
    [_leftLabel setText:leftTitle];
    
    CGSize size = [leftTitle sizeWithAttributes:@{NSFontAttributeName:_leftLabel.font}];
    if (!_leftViewWidth) {
        self.leftViewWidth = size.width;
    }
}

@end
