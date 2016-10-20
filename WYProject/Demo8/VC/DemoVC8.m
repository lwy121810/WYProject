//
//  DemoVC8.m
//  WYProject
//
//  Created by lwy1218 on 16/9/14.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

/*
 CLLocation:封装位置信息（经纬度 海拔）
 CLPlacemark: 封装地标信息（位置信息CLLocation 地名name 国家country 邮编...）
 MKUserLocation:封装地图上大头针的位置信息 (位置信息CLLocation 标题title 子标题subTitle)
 CLLocationDegrees:度数 （经纬度）
 CLLocationCoordinate2D: 地理坐标（经度CLLocationDegrees longitude、纬度CLLocationDegrees latitude）
 MKCoordinateSpan:跨度 （经度跨度CLLocationDegrees longitudeDelta、纬度跨度CLLocationDegrees latitudeDelta）
 MKCoordinateRegion: 区域（中心位置CLLocationCoordinate2D center、区域跨度MKCoordinateSpan span）
 */

#import "DemoVC8.h"
#import <MapKit/MapKit.h>
#import "WYAnnotation.h"
#import "WYAnnotationView.h"
@interface DemoVC8 ()<MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DemoVC8

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setup];
    [self addAnnotation];
}
//添加大头针
- (void)addAnnotation
{
    /*
     MKUserLocation
     MKUserLocation其实是个大头针模型，包括以下属性
     @property (nonatomic, copy) NSString *title;
     显示在大头针上的标题
     
     @property (nonatomic, copy) NSString *subtitle;
     显示在大头针上的子标题
     
     @property (readonly, nonatomic) CLLocation *location;
     地理位置信息(大头针钉在什么地方?)
     */
    //WYAnnotation是自己创建的大头针
    WYAnnotation *anno1 = [[WYAnnotation alloc] init];
    anno1.coordinate = CLLocationCoordinate2DMake(39, 119);
    anno1.title = @"帝都";
    anno1.subtitle = @"那是你的地方 我去不了的地方";
    // 添加一个大头针模型（模型：描述大头针的信息）
    [self.mapView addAnnotation:anno1];
    
    
    WYAnnotation *anno2 = [[WYAnnotation alloc] init];
    anno2.coordinate = CLLocationCoordinate2DMake(35, 119);
    anno2.title = @"哪里";
    anno2.subtitle = @"爱哪哪 管你什么事";
    // 添加一个大头针模型（模型：描述大头针的信息）
    [self.mapView addAnnotation:anno2];
    
    __weak typeof(self)weakSelf = self;
    [self setupRightBarButtonItemWithTitle:@"插满大头针" buttonAction:^(UIBarButtonItem *barButtonItem) {
        [weakSelf setupFullAnnotation];
    }];
    
}
- (void)setupFullAnnotation
{
    /** 天朝经纬度
     纬度范围：N 3°51′ ~  N 53°33′
     经度范围：E 73°33′ ~  E 135°05′
     */
    
    WYAnnotation *tg1 = [[WYAnnotation alloc] init];
    tg1.title = @"xxx大饭店";
    tg1.subtitle = @"全场一律15折，会员20折";
    tg1.icon = @"category_1";
    tg1.coordinate = CLLocationCoordinate2DMake(37, 116);
    [self.mapView addAnnotation:tg1];
    
    WYAnnotation *tg2 = [[WYAnnotation alloc] init];
    tg2.title = @"xxx影院";
    tg2.subtitle = @"最新大片：美国队长2，即将上映。。。";
    tg2.icon = @"category_5";
    tg2.coordinate = CLLocationCoordinate2DMake(29, 110);
    [self.mapView addAnnotation:tg2];

    
//    for (int i = 0; i<100; i++) {
//        CLLocationDegrees latitude = 23 + arc4random_uniform(20);
//        CLLocationDegrees longitude = 73.2 + arc4random_uniform(50);
//        
//        WYAnnotation *anno = [[WYAnnotation alloc] init];
//        anno.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
//        [self.mapView addAnnotation:anno];
//    }
}
- (void)setup
{
    //设置地图类型
    /**
     MKMapTypeStandard ：普通地图
     MKMapTypeSatellite ：卫星云图
     MKMapTypeHybrid ：普通地图覆盖于卫星云图之上
     */
    self.mapView.mapType = MKMapTypeStandard;
    // 2.设置跟踪模式(MKUserTrackingModeFollow == 跟踪)
    /**
     MKUserTrackingModeNone ：不跟踪用户的位置
     MKUserTrackingModeFollow ：跟踪并在地图上显示用户的当前位置
     MKUserTrackingModeFollowWithHeading ：跟踪并在地图上显示用户的当前位置，地图会跟随用户的前进方向进行旋转
     */
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    //设置代理 监控地图的相关行为 比如显示的区域发生了改变
    self.mapView.delegate = self;
    
    
    
    
//     设置地图显示的中心位置 因为地图默认显示是苹果总部 我们可以设置地图显示的位置
//        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39, 116);
//        [self.mapView setCenterCoordinate:coordinate animated:YES];
    
//     设置地图显示的区域
//        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39, 116);
//    //设置跨度
//        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
//        MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
//        [self.mapView setRegion:region animated:YES];
}



#pragma mark - MKMapViewDelegate
//添加大头针的时候就会调用这个方法
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    //返回nil 会使用系统的大头针
    if (![annotation isKindOfClass:[WYAnnotation class]]) return nil;
    
   //获得大头针控件
    WYAnnotationView *annotationView = [WYAnnotationView annotationViewWithMapView:mapView];
    //传递模型数据
    annotationView.annotation = annotation;
    
    return annotationView;
}
//返回大头针模型（annotation）对应的大头针控件 用的是MKAnnotationView的子类
/*
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *ID = @"anno";
    //先从缓存池中取出可以循环利用的大头针控件
    //MKPinAnnotationView是MKAnnotationView的子类
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    //没有控件的话 自己创建
    if (!annotationView) {
        //传入标识创建大头针控件
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
        //显示标题和子标题
        annotationView.canShowCallout = YES;
        //设置大头针的头的颜色
        annotationView.pinTintColor = [UIColor purpleColor];
        //设置从天而降的动画
        annotationView.animatesDrop = YES;
        //添加左边/右边的视图
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        annotationView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
        //往大头针里添加一个按钮
//        [annotationView addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
        //设置点击大头针弹出的view （即annotationView）的显示的箭头的偏移
        //x:代表的是水平方向的偏移 正数是往右偏移 负数是往左偏移
        //y:代表的是竖直方向的偏移 正数是往下偏移 负数是往上偏移
        annotationView.calloutOffset = CGPointMake(0, -20);
        
    }
    
    //传递大头针数据模型 覆盖掉之前的旧数据
    annotationView.annotation = annotation;
    
    annotationView.image = [UIImage imageNamed:@"me"];
    return annotationView;
}
 */
//返回大头针模型（annotation）对应的大头针控件
/*
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *ID = @"anno";
    //先从缓存池中取出可以循环利用的大头针控件
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    //没有控件的话 自己创建
    if (!annotationView) {
        //传入标识创建大头针控件
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
        //显示标题和子标题
        annotationView.canShowCallout = YES;
    }
    
    //传递大头针数据模型 覆盖掉之前的旧数据
    annotationView.annotation = annotation;
    
    //设置图片
    if ([annotation isKindOfClass:[WYAnnotation class]]) {
        WYAnnotation *anno = (WYAnnotation *)annotation;
        annotationView.image = [UIImage imageNamed:anno.icon];
    }
    
    return annotationView;
}
*/
/**
 *  更新到用户的位置是就会调用（显示的位置 显示范围改变）
 *
 调用非常频繁，不断监测用户的当前位置
 每次调用，都会把用户的最新位置（userLocation参数）传进来
 *  userLocation:大头针模型数据 对大头针未知的一个封装 这里的userLocation描述的是用来显示用户位置的蓝色大头针）
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    userLocation.title = @"大头针";
    userLocation.subtitle = @"nibi";
    /**
     MKUserLocation其实是个大头针模型，包括以下属性
     @property (nonatomic, copy) NSString *title;
     显示在大头针上的标题
     
     @property (nonatomic, copy) NSString *subtitle;
     显示在大头针上的子标题
     
     @property (readonly, nonatomic) CLLocation *location;
     地理位置信息(大头针钉在什么地方?)
     */
    //获得大头针所在位置的经纬度
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    //设置地图的中心点
//    [self.mapView setCenterCoordinate:center animated:YES];
    //获得大头针所在位置的经纬度
//    CLLocationCoordinate2D center = userLocation.location.coordinate;
    //设置跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.002509, 0.002256);
    //显示区域
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
    
    NSLog(@"didUpdateUserLocation--------");
}
/**
 *  地图显示的区域改变了就会调用(显示的位置、显示范围改变)
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //拿到中心点
    CLLocationCoordinate2D center = mapView.region.center;
    //拿到跨度区域
    MKCoordinateSpan span = mapView.region.span;
    
    NSLog(@"regionDidChangeAnimated -----------  中心点=(%f, %f), 区域跨度=(%f, %f)", center.longitude, center.latitude, span.longitudeDelta, span.latitudeDelta);
}
/**
 *  地图显示的区域即将改变了就会调用
 */
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
}
#pragma mark - 回到初始位置
- (IBAction)backToUserLocal:(id)sender {
    //设置中心点 不设置跨度是因为使用了当前的跨度
    CLLocationCoordinate2D center =  self.mapView.userLocation.location.coordinate;
    [self.mapView setCenterCoordinate:center animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
