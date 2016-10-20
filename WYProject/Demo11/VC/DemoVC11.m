//
//  DemoVC11.m
//  WYProject
//
//  Created by lwy1218 on 16/10/17.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "DemoVC11.h"
#import <MapKit/MapKit.h>
#import "WYAnnotation.h"

@interface DemoVC11 ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
//地理编码
@property (nonatomic , strong) CLGeocoder *geocoder;

@property (nonatomic, strong) MKPlacemark *sourceMKPm;
@property (nonatomic, strong) MKPlacemark *destinationMKPm;
@end

@implementation DemoVC11
- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    NSString *soure = @"广州";
    NSString *destination = @"北京";
    
    //地理编码 一个geocoder同一时间只能地理编码一个位置 而且是异步的
    [self.geocoder geocodeAddressString:soure completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *gzPm = [placemarks firstObject];
        if (gzPm == nil) {
            return ;
        }
        //添加大头针
        WYAnnotation *gzAnno = [[WYAnnotation alloc] init];
        //大头针的位置就是地标的位置
        gzAnno.coordinate = gzPm.location.coordinate;
        gzAnno.title = soure;
        gzAnno.subtitle = gzPm.name;
        
        [self.mapView addAnnotation:gzAnno];
        
        
        [self.geocoder geocodeAddressString:destination completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            CLPlacemark *bjPm = [placemarks firstObject];
            if (bjPm == nil) {
                return ;
            }
            //添加大头针
            WYAnnotation *bjAnno = [[WYAnnotation alloc] init];
            //大头针的位置就是地标的位置
            bjAnno.coordinate = bjPm.location.coordinate;
            bjAnno.title = destination;
            bjAnno.subtitle = bjPm.name;
            [self.mapView addAnnotation:bjAnno];
            
            [self drawLineWithSourceCLPm:gzPm destinationCLPm:bjPm];
            
        }];

    }];
    
    __weak typeof(self)weakSelf = self;
    [self setupRightBarButtonItemWithTitle:@"开始导航" buttonAction:^(UIBarButtonItem *barButtonItem) {
        [weakSelf startNav];
    }];
}
//开始导航
- (void)startNav
{
    
    if (self.sourceMKPm == nil || self.destinationMKPm == nil) {
        return;
    }
    
    //起点
    MKMapItem *sourceItem = [[MKMapItem alloc] initWithPlacemark:self.sourceMKPm];;
    //终点
    MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:self.destinationMKPm];;
    
    //存放起点和终点
    NSArray *items = @[sourceItem ,destinationItem];
    
    //参数
    NSMutableDictionary *options = [NSMutableDictionary dictionary];
    //导航模式  驾驶模式
    options[MKLaunchOptionsDirectionsModeKey] = MKLaunchOptionsDirectionsModeDriving;
    //是否显示路况
    options[MKLaunchOptionsShowsTrafficKey] = @YES;
    
    //打开苹果官方的导航应用
    [MKMapItem openMapsWithItems:items launchOptions:options];
}
- (void)drawLineWithSourceCLPm:(CLPlacemark *)sourceCLPm destinationCLPm:(CLPlacemark *)destinationCLPm
{
    if (sourceCLPm == nil || destinationCLPm == nil) {
        return;
    }
    //1.初始化方向请求
    //方向请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    //设置起点
    MKPlacemark *sourcePm = [[MKPlacemark alloc] initWithPlacemark:sourceCLPm];
    request.source = [[MKMapItem alloc] initWithPlacemark:sourcePm];
    
    self.sourceMKPm = sourcePm;
    
    //设置终点
    MKPlacemark *destinationPm = [[MKPlacemark alloc] initWithPlacemark:destinationCLPm];
    request.destination = [[MKMapItem alloc] initWithPlacemark:destinationPm];
    
    self.destinationMKPm = destinationPm;
    
    //2.根据请求创建方向
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    //3.根据方向计算路线
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return ;
        }
        for (MKRoute *rote in response.routes) {
            // 添加路线遮盖（传递路线的遮盖模型数据）
            [self.mapView addOverlay:rote.polyline];
        }
    }];
}


#pragma makr - MKMapViewDelegate 显示线的话需要实现这个代理
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    
    renderer.lineWidth = 5;
    renderer.strokeColor = [UIColor blueColor];
    return renderer;
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
