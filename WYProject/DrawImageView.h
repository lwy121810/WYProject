//
//  DrawImageView.h
//  WYProject
//
//  Created by lwy1218 on 16/8/30.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawImageView : UIView
@property (nonatomic , assign) CGFloat lineWidth;
@property (nonatomic , strong) UIColor *lineColor;

- (void)clearView;
- (void)backView;
@end
