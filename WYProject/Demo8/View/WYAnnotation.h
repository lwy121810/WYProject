//
//  WYAnnotation.h
//  WYProject
//
//  Created by lwy1218 on 16/9/14.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
/**自定义大头针*/
@interface WYAnnotation : NSObject<MKAnnotation>
//大头针的坐标
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
