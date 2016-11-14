
//
//  WYNavBarView.m
//  WYManagerNavViewController
//
//  Created by mac on 16/10/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WYNavBarView.h"


#define WYItemTitleFont [UIFont systemFontOfSize:14]
#define WYLineHeight  2

@interface WYNavBarView ()
{
    UIButton *_currentItem;
}
@property (nonatomic  , weak) UIView *downLine;
@property (nonatomic  , strong) NSMutableArray <UIButton *>*itemArray;
//每次偏移的最大值
@property (nonatomic  , assign) CGFloat everyTimeMaxOffset;

@end

@implementation WYNavBarView
- (NSMutableArray<UIButton *> *)itemArray
{
    
    if (!_itemArray) {
        self.itemArray = [NSMutableArray array];
    }
    return _itemArray;
}
- (UIView *)downLine
{
    if (!_downLine) {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view.backgroundColor = [UIColor colorForHex:@"#EDCC0C"];
        self.downLine = view;
    }
    return _downLine;
}
- (UIButton *)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = WYItemTitleFont;
    
    
    UIColor *color = [UIColor colorForHex:@"#FFFFFF"];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.tag = tag;
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}
- (void)setupTitles:(NSArray<NSString *> *)titles
{
    if (titles == nil || titles.count == 0) return;
    
    if (self.subviews && self.subviews.count > 0) {
        
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
            obj = nil;
        }];
    }
    
    [self.itemArray removeAllObjects];
    
    CGFloat firstX = 0;
    CGFloat itemMarginX = 0;
    
    CGFloat w = 100;
    CGFloat h = 30;
    CGFloat y = 0;
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        UIButton *button = [self createButtonWithTitle:obj tag:(idx + 1000)];
        
        button.frame = CGRectMake(firstX + (w + itemMarginX) * idx, y, w, h);
        
        
        [self addSubview:button];
        if(idx == 0)
        {
            button.selected = YES;
            _currentItem = button;
            self.downLine.frame = CGRectMake(0, CGRectGetMaxY(button.frame), button.width, WYLineHeight);
            
        }
        [self.itemArray addObject:button];
        
    }];
    
    self.height = CGRectGetMaxY(self.downLine.frame);
    
    self.contentSize = CGSizeMake(firstX + (w + itemMarginX) *titles.count, 0);
    CGFloat everyTimeMaxOffset = 2 * self.downLine.width;
    self.everyTimeMaxOffset = everyTimeMaxOffset;
}

- (void)setTitleColorWithColor:(UIColor *)titleColor
{
    if (self.itemArray == nil || self.itemArray.count == 0) {
        return;
    }
    
    [self.itemArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            obj.titleLabel.textColor = titleColor;
        }
    }];
}
- (void)setDownLineColor:(UIColor *)lineColor
{
    self.downLine.backgroundColor = lineColor;
}
- (void)setTitleFontWithFont:(UIFont *)font
{
    if (self.itemArray == nil || self.itemArray.count == 0) {
        return;
    }
    
    [self.itemArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            obj.titleLabel.font = font;
        }
    }];
}

- (void)moveLineToIndex:(NSInteger)index scale:(CGFloat)scale
{
    NSInteger tag = index + 1000;
    UIButton *currentItem = [self viewWithTag:tag];
    [self setCurrentItemSatus:currentItem];
    [UIView animateWithDuration:0.25 animations:^{
        self.downLine.x = currentItem.x;
    }];
    if (self.contentSize.width <= self.width) {
        return;
    }
    CGFloat offsetW = self.contentSize.width - self.width;
    
    
    
    
    CGFloat maxX = CGRectGetMaxX(self.downLine.frame);
    if (maxX >= self.contentSize.width) {
        return;
    }
    if (maxX + self.downLine.width > self.width) {
        //设置偏移
        
        
        CGFloat x = scale * self.contentSize.width;
        if (x > offsetW) {
            x = offsetW;
        }
        CGPoint offset = CGPointMake(x , 0);
        [self setContentOffset:offset animated:YES];
    }else{
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    //    if (maxX - self.width > self.downLine.width * 2) {
    //        if (self.contentSize.width <= self.contentOffset.x) {
    //
    //        }
    //        CGPoint offset = CGPointMake(maxX, 0);
    //        [self setContentOffset:offset animated:YES];
    //    }else{
    //    }
    
    //    if (self.downLine.x >= self.width - self.downLine.width * 2) {
    //        [self setContentOffset:CGPointMake(self.downLine.width * index, 0) animated:YES];
    //    }else{
    //
    //        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    //    }
    //    NSLog(@"contentOffset --- %.2f downLine的x--  %.2f", self.contentOffset.x, self.downLine.x);
}

- (void)setCurrentItemSatus:(UIButton *)sender
{
    _currentItem.selected = NO;
    _currentItem = sender;
    _currentItem.selected = YES;
    
}

- (void)buttonAction:(UIButton *)sender
{
    
    [self setCurrentItemSatus:sender];
    
    NSInteger index = sender.tag - 1000;
    if (self.indexBlock) {
        self.indexBlock(index);
    }
}

@end
