//
//  DrawImageView.m
//  WYProject
//
//  Created by lwy1218 on 16/8/30.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "DrawImageView.h"


@interface DrawImageView ()
@property (nonatomic , strong) NSMutableArray *paths;
@end
@implementation DrawImageView

- (NSMutableArray *)paths
{
    if (!_paths) {
        self.paths = [NSMutableArray array];
    }
    return _paths;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint startPoint = [touch locationInView:touch.view];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGFloat lineW = self.lineWidth ? self.lineWidth : 10;
    // 3.1设置路径的相关属性
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineWidth:lineW];
    
    [path moveToPoint:startPoint];
    [self.paths addObject:path];
 
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:touch.view];
    
    UIBezierPath *currentPath = [self.paths lastObject];
    [currentPath addLineToPoint:movePoint];
    [self setNeedsDisplay];
}
// 离开view(停止触摸)
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     // 1.获取手指对应UITouch对象
     UITouch *touch = [touches anyObject];
     // 2.通过UITouch对象获取手指触摸的位置
     CGPoint endPoint = [touch locationInView:touch.view];
     
     // 3.取出当前的path
     UIBezierPath *currentPaht = [self.paths lastObject];
     // 4.设置当前路径的终点
     [currentPaht addLineToPoint:endPoint];
     
     // 6.调用drawRect方法重回视图
     [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect
{
    UIColor *color = self.lineColor ? self.lineColor :[UIColor redColor];
    [color set];
    [self.paths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIBezierPath *path = (UIBezierPath *)obj;
        [path stroke];
    }];
}

- (void)clearView
{
    if (self.paths.count > 0) {
        [self.paths removeAllObjects];
        [self setNeedsDisplay];
    }
}
- (void)backView
{
    if (self.paths.count > 0) {
        [self.paths removeLastObject];
        [self setNeedsDisplay];
    }
}
@end
