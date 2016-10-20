//
//  ResponderView.m
//  WYProject
//
//  Created by lwy1218 on 16/8/30.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "ResponderView.h"

@interface ResponderView ()
@property (nonatomic , weak) UIButton *redView;
@property (nonatomic , weak) UIButton *greenView;
@end
@implementation ResponderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *red = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *green = [UIButton buttonWithType:UIButtonTypeCustom];
        
        red.backgroundColor = [UIColor redColor];
        green.backgroundColor = [UIColor greenColor];
        
        [red wy_addTarget:self action:@selector(redClick)];
        [green wy_addTarget:self action:@selector(greedClick)];
        
        red.frame = CGRectMake(0, 0, 50, 50);
        
        green.frame = CGRectMake(80, 0, 50, 50);
        
        
        [self wy_addSubviews:@[red, green]];
        
        self.redView = red;
        self.greenView = green;
    }
    return self;
}
- (void)redClick
{
    NSLog(@"点击了绿色按钮 但是响应的是红色按钮的点击事件 redClick------- ");
}

- (void)greedClick
{
    NSLog(@"点击了红色按钮 但是响应的是绿色按钮的点击事件 greedClick------- ");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ResponderView touchesBegan");
}

//这个方法是点击屏幕的时候都会调用这个方法
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    /**例如这里是点击红色按钮 但是响应的是绿色的点击事件*/
    
    if (CGRectContainsPoint(self.redView.frame, point)) {//意思是点击的如果是这个view范围内的点的话
        return self.greenView;//返回是谁代表着是谁响应事件
    }else if (CGRectContainsPoint(self.greenView.frame, point))
    {
        return self.redView;
    }
    
    //不要返回self 因为返回self代表着无论点击了谁都是这个view来响应事件 应该交给父控件来处理
    return [super hitTest:point withEvent:event];
}

@end
