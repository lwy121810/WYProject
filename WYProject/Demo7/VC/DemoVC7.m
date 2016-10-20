//
//  DemoVC7.m
//  WYProject
//
//  Created by lwy1218 on 16/9/14.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import "DemoVC7.h"
#import <CoreLocation/CoreLocation.h>
@interface DemoVC7 ()<CLLocationManagerDelegate>
@property (nonatomic , strong) CLLocationManager *locMgr;
//地理编码
@property (nonatomic , strong) CLGeocoder *geocoder;


#pragma mark - 地理编码
- (IBAction)geocode;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
//经度
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
//维度
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
//具体位置
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

#pragma mark - 反地理编码
- (IBAction)reverseGeocode;
////经度
@property (weak, nonatomic) IBOutlet UITextField *longtitudeField;
//维度
@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
//位置
@property (weak, nonatomic) IBOutlet UILabel *reverseDetailAddressLabel;
@end

@implementation DemoVC7
- (CLLocationManager *)locMgr
{
    if (!_locMgr) {
        //创建位置管理器
        self.locMgr = [[CLLocationManager alloc] init];
        //设置代理
        self.locMgr.delegate = self;
    }
    return _locMgr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //先判断能不能定位
    if ([CLLocationManager locationServicesEnabled]) {//能定位
        //开始用户定位
        [self.locMgr startUpdatingLocation];
        //每隔多少米定位一次
//        self.locMgr.distanceFilter = kCLDistanceFilterNone;
//        //定位精确度（越精确就越耗电
//        self.locMgr.desiredAccuracy = kCLLocationAccuracyBest;
        
#pragma mark - 开始监控 进入该区域之后会调用代理方法
//        self.locMgr startMonitoringForRegion:<#(nonnull CLRegion *)#>
        
        NSLog(@"开始定位");
    }else{//不能
        NSLog(@"不能定位");
    }
    [self countDistance];
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

/**
 *  地理编码：地名 -> 经纬度
 */
- (void)geocode
{
    NSLog(@"geocode");
    NSString *address = self.addressField.text;
    if (address.length == 0) {
        return;
    }
    //开始编码
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        /*
         CLPlacemark字面意思是地标 封装详细的地址位置信息
         CLPlacemark *placemark = placemarks.firstObject;
         //地理位置
         placemark.location;
         //区域
         placemark.region;
         //详细的地址信息
         placemark.addressDictionary;
         //地址名称
         placemark.name;
         //城市
         placemark.locality;
         */
        if (error || placemarks.count == 0) {
            //没有找到位置
            self.detailAddressLabel.text = @"没有找到位置";
        }
        for (CLPlacemark *placemark in placemarks) {
            
            NSLog(@"地址名称=%@ 城市=%@ 国家=%@ 邮编=%@", placemark.name, placemark.locality, placemark.country, placemark.postalCode);
        }
        
        // 显示最前面的地标信息
        CLPlacemark *firstPlacemark = [placemarks firstObject];
        self.detailAddressLabel.text = firstPlacemark.name;
        //取出经纬度
        CLLocationDegrees latitude = firstPlacemark.location.coordinate.latitude;
        CLLocationDegrees longitude = firstPlacemark.location.coordinate.longitude;
        self.latitudeLabel.text = [NSString stringWithFormat:@"%.2f", latitude];
        self.longitudeLabel.text = [NSString stringWithFormat:@"%.2f", longitude];
    }];
    
}
- (void)getAreaWithlongtitude:(NSString *)longtitudeText latitudeText:(NSString *)latitudeText
{
    if (longtitudeText.length == 0 || latitudeText.length == 0) return;
    //维度
    CLLocationDegrees latitude = [latitudeText doubleValue];
    CLLocationDegrees longtitude = [longtitudeText doubleValue];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
    //反向编码
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            self.reverseDetailAddressLabel.text = @"你输入的经纬度找不到，可能在火星上";
        } else { // 编码成功（找到了具体的位置信息）
            // 输出查询到的所有地标信息
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@", placemark.name, placemark.locality, placemark.country, placemark.postalCode);
            }
            
            // 显示最前面的地标信息
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            self.reverseDetailAddressLabel.text = firstPlacemark.name;
            
            CLLocationDegrees latitude = firstPlacemark.location.coordinate.latitude;
            CLLocationDegrees longitude = firstPlacemark.location.coordinate.longitude;
            self.latitudeField.text = [NSString stringWithFormat:@"%.2f", latitude];
            self.longtitudeField.text = [NSString stringWithFormat:@"%.2f", longitude];
        }
        
    }];

}

/**
 *  反地理编码：经纬度 -> 地名
 */

- (void)reverseGeocode
{
    
    NSLog(@"reverseGeocode");
    
    NSString *longtitudeText = self.longtitudeField.text;
    NSString *latitudeText = self.latitudeField.text;
    if (longtitudeText.length == 0 || latitudeText.length == 0) return;
    //维度
    CLLocationDegrees latitude = [latitudeText doubleValue];
    CLLocationDegrees longtitude = [longtitudeText doubleValue];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
    //反向编码
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
            self.reverseDetailAddressLabel.text = @"你输入的经纬度找不到，可能在火星上";
        } else { // 编码成功（找到了具体的位置信息）
            // 输出查询到的所有地标信息
            for (CLPlacemark *placemark in placemarks) {
                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@", placemark.name, placemark.locality, placemark.country, placemark.postalCode);
            }
            
            // 显示最前面的地标信息
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            self.reverseDetailAddressLabel.text = firstPlacemark.name;
            
            CLLocationDegrees latitude = firstPlacemark.location.coordinate.latitude;
            CLLocationDegrees longitude = firstPlacemark.location.coordinate.longitude;
            self.latitudeField.text = [NSString stringWithFormat:@"%.2f", latitude];
            self.longtitudeField.text = [NSString stringWithFormat:@"%.2f", longitude];
        }

    }];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)countDistance
{
    CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:40 longitude:116];
    CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:41 longitude:116];
    
    CLLocationDistance distance = [loc1 distanceFromLocation:loc2];
    NSLog(@"(%@)和(%@)的距离：%f", loc1, loc2, distance);
}

#pragma mark - CLLocationManagerDelegate
//当调用了startUpdatingLocation方法后，就开始不断地定位用户的位置，中途会频繁地调用代理的这个方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    /**
     CLLocation用来表示某个位置的地理信息，比如经纬度、海拔等等
     @property(readonly, nonatomic) CLLocationCoordinate2D coordinate;
     经纬度
     
     @property(readonly, nonatomic) CLLocationDistance altitude;
     海拔
     
     @property(readonly, nonatomic) CLLocationDirection course;
     路线，航向（取值范围是0.0° ~ 359.9°，0.0°代表真北方向）
     
     @property(readonly, nonatomic) CLLocationSpeed speed;
     行走速度（单位是m/s）
     
     用- (CLLocationDistance)distanceFromLocation:(const CLLocation *)location方法可以计算2个位置之间的距离
     */
    
    // 数组里面存放的是CLLocation对象， 一个CLLocation就代表一个位置
    CLLocation *loc = [locations lastObject];
    
    // 纬度：loc.coordinate.latitude
    // 经度：loc.coordinate.longitude
    NSLog(@"纬度=%f, 经度=%f", loc.coordinate.latitude, loc.coordinate.longitude);
    
    // 停止更新位置(不用定位服务，应当马上停止定位，非常耗电)
    [manager stopUpdatingLocation];
    NSLog(@"didUpdateLocations %lu" , (unsigned long)locations.count);
}
//进入该区域之后调用该方法
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
}
//离开某个区域的时候调用该方法
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
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
