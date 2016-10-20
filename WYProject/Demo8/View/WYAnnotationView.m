//
//  WYAnnotationView.m
//  WYProject
//
//  Created by lwy1218 on 16/10/12.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "WYAnnotationView.h"
#import "WYAnnotation.h"


@interface WYAnnotationView ()

@property (nonatomic, weak) UIImageView *iconView;
@end
@implementation WYAnnotationView

+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView
{
    static NSString *annoID = @"anno";
    //从缓存池中取
    WYAnnotationView *annotationView = (WYAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:annoID];
    
    if (!annotationView) {
        //传入标识创建大头针控件
        annotationView = [[WYAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:annoID];
    }
    
    return annotationView;
}


- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {//设置默认设置
        //显示标题和子标题
        self.canShowCallout = YES;
        
        // 左边显示一个图片
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.bounds = CGRectMake(0, 0, 50, 50);
        self.leftCalloutAccessoryView = iconView;
        self.iconView = iconView;

    }
    return self;
}

- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];//调用super的目的是把数据模型传给super super才知道要显示在什么地方 不写这一句 子标题和位置会不见
    
    if ([annotation isKindOfClass:[WYAnnotation class]]) {
        WYAnnotation *anno = (WYAnnotation *)annotation;
        self.image = [UIImage imageNamed:anno.icon];
        self.iconView.image = self.image;
    }
}

@end
