//
//  WYImageBrowserView.m
//  WYImageBrowserViewDemo
//
//  Created by lwy on 2018/2/26.
//  Copyright © 2018年 lwy. All rights reserved.
//

#import "WYImageBrowserView.h"


@interface WYImageBrowserView ()<UIScrollViewDelegate>
@property (nonatomic , strong) UIImageView *imageView;
@property (nonatomic , assign) CGRect fromRect;
@property (nonatomic , strong) UIScrollView *scrollView;
@property (nonatomic , weak) UIImage *originImage;
@property (nonatomic , weak) UIImage *highlightedImage;

@end

@implementation WYImageBrowserView
- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.scrollView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView = imageView;
    }
    return _imageView;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [self addSubview:scrollView];
        scrollView.delegate = self;
        _scrollView = scrollView;
    }
    return _scrollView;
}
- (instancetype)initWithOriginImage:(UIImage *)originImage
                   highlightedImage:(UIImage *)highlightedImage
                           fromRect:(CGRect)fromRect
{
    if (self = [super init]) {
        self.originImage = originImage;
        self.highlightedImage = highlightedImage;
        self.fromRect = fromRect;
        
        
        
        [self setupView];
        
        [self setupDefaultValue];
        
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:singleTap];
        
        UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGesture:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}
- (void)setupDefaultValue
{
    self.minimumZoomScale = 1;
    self.maximumZoomScale = 2;
    
    self.animationDuration = 0.5;
}
- (void)setMinimumZoomScale:(CGFloat)minimumZoomScale
{
    _minimumZoomScale = minimumZoomScale;
    self.scrollView.minimumZoomScale = minimumZoomScale;
}
- (void)setMaximumZoomScale:(CGFloat)maximumZoomScale
{
    _maximumZoomScale = maximumZoomScale;
    self.scrollView.maximumZoomScale = maximumZoomScale;
}
- (void)setupView
{
    self.scrollView.frame = self.bounds;
    [self imageView];
}

- (void)layoutSubviews
{
    self.scrollView.frame = self.bounds;
}
- (void)show
{
    [self showInView:nil];
}

- (void)showInView:(UIView *)view
{
    if (self.superview == nil) {
        if (view == nil) {
            view = [UIApplication sharedApplication].keyWindow;
        }
        [view addSubview:self];
        
        self.frame = view.bounds;
    }
    
    [self showOriginImageWithAnimation];
}


- (void)dismissWithAnimated:(BOOL)animated completion:(void(^)(void))completion
{
    CGRect frame = self.fromRect;
    CGFloat originX = self.scrollView.contentOffset.x + frame.origin.x;
    CGFloat originY = self.scrollView.contentOffset.y + frame.origin.y;
    frame.origin = CGPointMake(originX, originY);
    
    if (animated) {
        [UIView animateWithDuration:_animationDuration animations:^{
            self.imageView.frame = frame;
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (completion) {
                completion();
            }
        }];
    }
    else {
        self.imageView.frame = frame;
        self.alpha = 0.f;
        
        [self removeFromSuperview];
        if (completion) {
            completion();
        }
    }
}
- (CGRect)getScaledFinalFrame
{
    return [self calculateScaledFinalFrame];
}
- (CGRect)calculateScaledFinalFrame
{
    CGSize thumbSize = self.originImage.size;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGFloat finalHeight = width * (thumbSize.height / thumbSize.width);
    CGFloat top = 0.f;
    if (finalHeight < height)
    {
        top = (height - finalHeight) / 2.f;
    }
    return CGRectMake(0.f, top, width, finalHeight);
}

- (void)showOriginImageWithAnimation
{
    self.imageView.frame = self.fromRect;
    if (self.originImage) {
        CGRect finalRect = [self getScaledFinalFrame];
        if (finalRect.size.height > CGRectGetHeight(self.scrollView.frame)) {
            self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame), finalRect.size.height);
        }
        self.alpha = 0.f;
        self.imageView.image = self.originImage;
        [UIView animateWithDuration:_animationDuration animations:^{
            self.imageView.frame = finalRect;
            self.alpha = 1.f;
        } completion:^(BOOL finished) {
            if (self.highlightedImage) {
                self.imageView.image = self.highlightedImage;
            }
        }];
    }
    else {
        self.imageView.frame = self.bounds;
        self.alpha = 0;
        if (self.highlightedImage) {
            self.imageView.image = self.highlightedImage;
        }
        [UIView animateWithDuration:_animationDuration animations:^{
            self.alpha = 1.f;
        } completion:nil];
    }
}

#pragma mark - 手势事件
- (void)dismiss
{
    [self dismissWithAnimated:YES completion:nil];
}
- (void)doubleTapGesture:(UITapGestureRecognizer *)tap
{
    if (self.scrollView.zoomScale > _minimumZoomScale) {// 已经放大 现在缩小
        [self.scrollView setZoomScale:_minimumZoomScale animated:YES];
    }
    else {
        // 已经缩小 现在放大
        CGPoint point = [tap locationInView:self.scrollView];
        //        [self zoomScrollView:self.scrollView toPoint:point withScale:_maximumZoomScale animated:YES];
        // 方法一 以point为中心点进行放大
        CGRect zoomRect = [self zoomRectForScrollView:self.scrollView withScale:_maximumZoomScale withCenter:point];
        [self.scrollView zoomToRect:zoomRect animated:YES];
        // 方法二 也可以通过这种方法 来放大 这种是直接放大 以scrollView的中心点
        //        [self.scrollView setZoomScale:_maximumZoomScale animated:YES];
    }
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
// any zoom scale changes
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat scrollW = CGRectGetWidth(scrollView.frame);
    CGFloat scrollH = CGRectGetHeight(scrollView.frame);
    
    CGSize contentSize = scrollView.contentSize;
    CGFloat offsetX = scrollW > contentSize.width ? (scrollW - contentSize.width) * 0.5 : 0;
    CGFloat offsetY = scrollH > contentSize.height ? (scrollH - contentSize.height) * 0.5 : 0;
    
    CGFloat centerX = contentSize.width * 0.5 + offsetX;
    CGFloat centerY = contentSize.height * 0.5 + offsetY;
    
    self.imageView.center = CGPointMake(centerX, centerY);
}

/**
 该方法返回的矩形适合传递给zoomToRect:animated:方法。
 
 @param scrollView UIScrollView实例
 @param scale 新的缩放比例（通常zoomScale通过添加或乘以缩放量而从现有的缩放比例派生而来)
 @param center 放大缩小的中心点
 @return zoomRect 是以内容视图为坐标系
 */
- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    // the size of the rect grows.
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}
@end
