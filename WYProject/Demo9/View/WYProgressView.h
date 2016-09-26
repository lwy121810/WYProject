//
//  WYProgressView.h
//  TestProgressView
//
//  Created by lwy1218 on 16/5/5.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYProgressView;
@protocol WYProgressViewDelegate <NSObject>
@optional
/**
 *  将要更新进度之前的回调
 *
 *  @param progressView self
 *  @param percentage   更新进度之前的当前进度的百分比
 */
- (void)wyProgressViewWillUpdateProgress:(WYProgressView *)progressView percentage:(CGFloat)percentage;
/**
 *  实时更新进度之后的回调
 *
 *  @param progressView self
 *  @param percentage   更新进度之后的当前进度之后的百分比
 */
- (void)wyProgressViewDidUpdateProgress:(WYProgressView *)progressView percentage:(CGFloat)percentage;
/**
 *  暂停计时之后的回调 调用stop方法之后会触发该回调
 *
 *  @param progressView self
 *  @param percentage   当前进度的百分比
 */
- (void)wyProgressViewDidStopProgress:(WYProgressView *)progressView percentage:(CGFloat)percentage;

@end

@interface WYProgressView : UIView
/**
 *  倒计时的总共时间 默认10秒
 */
@property (nonatomic , assign) CGFloat totalTime;
/**
 *  是否展示最外环的边缘
 */
@property (nonatomic , assign) BOOL showRing;
/**
 *  圆的边缘颜色 默认蓝色 只有在showRing为YES时有效
 */
@property(nonatomic, strong) UIColor *circleBackgroundColor;
/**
 *  显示边缘的宽度 最外环的边缘宽 默认为2 只有在showRing为YES时有效
 */
@property (nonatomic , assign) CGFloat ringWidth;

@property (nonatomic ,assign) id<WYProgressViewDelegate>delegate;
/**
 *  初始化方法
 *
 *  @param frame                 frame
 *  @param progressCurrentColor  当前进度的颜色 即完成进度的颜色 不传值的话默认黄色
 *  @param progressUnfinishColor 进度的背景颜色 即未完成进度的颜色 不传值的话默认红色
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame withProgressCurrentColor:(UIColor *)progressCurrentColor progressUnfinishColor:(UIColor *)progressUnfinishColor;
/**
 结束计时
 */
- (void)stop;
/**
 *  开始计时
 */
- (void)start;
@end
