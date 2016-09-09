//
//  WYButton.m
//  WYProject
//
//  Created by lwy1218 on 16/8/27.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYButton.h"

@implementation WYButton
+ (WYButton *)shareButton
{
    static WYButton *button = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        button = [WYButton buttonWithType:UIButtonTypeCustom];
    });
    return button;
}
+ (WYButton *)wyButton
{
    WYButton *button = [WYButton buttonWithType:UIButtonTypeCustom];
    return button;
}

- (WYMargin)xIs
{
    __weak typeof(self)weakSelf = self;
    return ^(CGFloat value){
        weakSelf.x = value;
        return weakSelf;
    };
}
- (WYMargin)yIs
{
    __weak typeof(self)weakSelf = self;
    return ^(CGFloat value){
        weakSelf.y = value;
        return weakSelf;
    };
}

- (WYMargin)widthIs
{
    __weak typeof(self)weakSelf = self;
    return ^(CGFloat value){
        weakSelf.width = value;
        return weakSelf;
    };
}
- (WYMargin)heightIs
{
    __weak typeof(self)weakSelf = self;
    return ^(CGFloat value){
        weakSelf.height = value;
        return weakSelf;
    };
}
- (WYButtonTitle)wy_title_normal
{
    __weak typeof(self)weakSelf = self;
    return ^(NSString * title){
        [weakSelf setTitle:title forState:UIControlStateNormal];
        return weakSelf;
    };
}

- (WYButtonTitle)wy_title_select
{
    __weak typeof(self)weakSelf = self;
    return ^(NSString * title){
        [weakSelf setTitle:title forState:UIControlStateSelected];
        return weakSelf;
    };
}
- (WYButtonColor)wy_titleColor_normal
{
    __weak typeof(self)weakSelf = self;
    return ^(UIColor *titleColor){
        [weakSelf setTitleColor:titleColor forState:UIControlStateNormal];
        return weakSelf;
    };
}

- (WYButtonColor)wy_titleColor_select
{
    __weak typeof(self)weakSelf = self;
    return ^(UIColor *titleColor){
        [weakSelf setTitleColor:titleColor forState:UIControlStateSelected];
        return weakSelf;
    };
}
- (WYButtonColor)wy_backgroundColor
{
    __weak typeof(self)weakSelf = self;
    return ^(UIColor * color){
        weakSelf.backgroundColor = color;
        return weakSelf;
    };
}
- (WYButtonFrame)wy_frame
{
    __weak typeof(self)weakSelf = self;
    return ^(CGFloat x , CGFloat y , CGFloat w ,CGFloat h){
        weakSelf.frame = CGRectMake(x, y, w, h);
        return weakSelf;
    };
}
- (WYButtonSuperView)wy_superView
{
    __weak typeof(self)weakSelf = self;
    return ^(UIView *superView){
        if (superView) {
            [superView addSubview:weakSelf];
        }
        return weakSelf;
    };
}
- (WYButtonTargetAction)wy_targetAction
{
    __weak typeof(self)weakSelf = self;
    return ^(id target , SEL sel){
        [weakSelf addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        return weakSelf;
    };
}
- (WYButtonTag)wy_tag
{
    __weak typeof(self)weakSelf = self;
    return ^(NSInteger tag){
        [weakSelf setTag:tag];
        return weakSelf;
    };
}
@end
