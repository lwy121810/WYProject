//
//  WYNavBarView.h
//  WYManagerNavViewController
//
//  Created by mac on 16/10/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WYHeaderBlock)(NSInteger index);
@interface WYNavBarView : UIScrollView
@property (nonatomic , copy) WYHeaderBlock indexBlock;
- (void)moveLineToIndex:(NSInteger)index scale:(CGFloat)scale;
- (void)setupTitles:(NSArray <NSString *>*)titles;
//- (void)moveLineToIndex:(NSInteger)index;
- (void)setTitleFontWithFont:(UIFont *)font;
- (void)setTitleColorWithColor:(UIColor *)titleColor;
- (void)setDownLineColor:(UIColor *)lineColor;
@end
