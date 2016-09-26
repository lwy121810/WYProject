//
//  WYProgressView.m
//  TestProgressView
//
//  Created by lwy1218 on 16/5/5.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYProgressView.h"
#import "UIView+Extension.h"

#define UIColorMake(r, g, b, a) [UIColor colorWithRed:r / 255. green:g / 255. blue:b / 255. alpha:a]

@interface WYProgressView ()
{
    CGFloat _progress;
    CGFloat _currentProgress;
}
@property(nonatomic, strong) NSTimer *timer;
/**
 *  当前进度的颜色 即完成进度的颜色 默认黄色
 */
@property(nonatomic, strong) UIColor *progressCurrentColor;

/**
 *  进度的背景颜色 即未完成进度的颜色 默认红色
 */
@property(nonatomic, strong) UIColor *progressUnfinishColor;
@end
@implementation WYProgressView
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.ringWidth = 2;
    _showRing = NO;
    self.circleBackgroundColor = [UIColor blueColor];
    _currentProgress = 0.f;
}
- (void)start
{
    if (!self.timer.isValid) {
        if (_currentProgress < 0 || _currentProgress > 100) {
            _currentProgress = 0.f;
        }
        //*0.01也就是1/100.self.totalTime * 0.01是因为在updateProgress方法里_currentProgress/100; time 默认10s是因为100*0.1等于10；
        CGFloat time = self.totalTime ? self.totalTime * 0.01 : 0.1;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:time
                                                      target:self
                                                    selector:@selector(updateProgress)
                                                    userInfo:nil
                                                     repeats:YES];
        [self.timer fire];
    }
}
- (instancetype)initWithFrame:(CGRect)frame withProgressCurrentColor:(UIColor *)progressCurrentColor progressUnfinishColor:(UIColor *)progressUnfinishColor
{
    if (self = [super initWithFrame:frame]) {
        self.progressUnfinishColor = progressUnfinishColor ? progressUnfinishColor :[UIColor redColor];
        self.progressCurrentColor = progressCurrentColor ? progressCurrentColor : [UIColor yellowColor];
        //设置初始值
        [self setup];
    }
    return self;
}
- (void)stop
{
    [self.timer invalidate];
     self.timer = nil;
    if ([_delegate respondsToSelector:@selector(wyProgressViewDidStopProgress:percentage:)]) {
        [_delegate wyProgressViewDidStopProgress:self percentage:_progress];
    }
    [self setNeedsDisplay];
}
- (void)updateProgress {
    if ([_delegate respondsToSelector:@selector(wyProgressViewWillUpdateProgress:percentage:)]) {
        [_delegate wyProgressViewWillUpdateProgress:self percentage:_progress];
    }
    //计算当前的进度
    _progress = _currentProgress++ / 100;
    if (_progress >= 1) {
        [self stop];
        return;
    }
    //会自动调用drawRect方法
    [self setNeedsDisplay];
    if ([_delegate respondsToSelector:@selector(wyProgressViewDidUpdateProgress:percentage:)]) {
        [_delegate wyProgressViewDidUpdateProgress:self percentage:_progress];
    }
}
- (void)drawRect:(CGRect)rect
{
    CGFloat margin = _showRing ? _ringWidth : 0;
    if (_showRing) {
        //设置背景圆形 也是边缘的环形
        [self drawCircleWithRect:rect margin:0 color:self.circleBackgroundColor percentage:1];
    }
    [self drawCircleWithRect:rect margin:margin color:self.progressUnfinishColor percentage:1];
    //设置显示当前进度的圆
    [self drawCircleWithRect:rect margin:margin color:self.progressCurrentColor percentage:_progress];
}
- (void)drawCircleWithRect:(CGRect)rect margin:(CGFloat)margin color:(UIColor *)color percentage:(CGFloat)percentage
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置半径
    CGFloat radius = MIN(CGRectGetHeight(rect), CGRectGetWidth(rect)) * 0.5 - margin;
    //圆心
    CGFloat centerX = CGRectGetWidth(rect) * 0.5;
    CGFloat centerY = CGRectGetHeight(rect) * 0.5;
    //设置起始角度
    CGFloat startAngle = M_PI * 1.5;//从y轴正方向开始画
    //根据传过来的百分比计算改变的角度的值
    CGFloat changeAngle = M_PI * 2 * percentage;
    //设置结束时的角度 改变的角度加上起始时的角度就是结束时的角度
    CGFloat endAngle = changeAngle + startAngle;
    //设置绘图的起始点
    CGContextMoveToPoint(context, centerX, centerY);
    //画圆
    CGContextAddArc(context, centerX, centerY, radius, startAngle, endAngle, 0);
    //设置图形的颜色
    CGContextSetFillColorWithColor(context, color.CGColor);
    //闭合路径
    CGContextClosePath(context);
    //填充路径
    CGContextFillPath(context);
}

@end
