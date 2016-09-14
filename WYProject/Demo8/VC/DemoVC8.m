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
    WYAnnotation *anno1 = [[WYAnnotation alloc] init];
    anno1.coordinate = CLLocationCoordinate2DMake(39, 119);
    anno1.title = @"帝都";
    anno1.subtitle = @"帝都帝都帝都帝都帝都";
    // 添加一个大头针模型（模型：描述大头针的信息）
    [self.mapView addAnnotation:anno1];
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
    
    
    
    
//     设置地图显示的中心位置
//        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39, 116);
//        [self.mapView setCenterCoordinate:coordinate animated:YES];
//    
////     设置地图显示的区域
//        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39, 116);
//        MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
//        MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
//        [self.mapView setRegion:region animated:YES];
}

#pragma mark - MKMapViewDelegate
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
    
//    CLLocationCoordinate2D center = userLocation.location.coordinate;
//    //设置地图的中心点
//    [self.mapView setCenterCoordinate:center animated:YES];
    
    CLLocationCoordinate2D center = userLocation.location.coordinate;
    //设置跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2509, 0.2256);
    //显示区域
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    [self.mapView setRegion:region animated:YES];
}
/**
 *  地图显示的区域改变了就会调用(显示的位置、显示范围改变)
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D center = mapView.region.center;
    MKCoordinateSpan span = mapView.region.span;
    
    NSLog(@"中心点=(%f, %f), 区域跨度=(%f, %f)", center.longitude, center.latitude, span.longitudeDelta, span.latitudeDelta);
}
/**
 *  地图显示的区域即将改变了就会调用
 */
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
}
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
