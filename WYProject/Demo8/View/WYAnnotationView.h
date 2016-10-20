//
//  WYAnnotationView.h
//  WYProject
//
//  Created by lwy1218 on 16/10/12.
//  Copyright © 2016年 lwy1218. All rights reserved.
//

#import <MapKit/MapKit.h>
/**自定义的大头针控件*/
@interface WYAnnotationView : MKAnnotationView
+ (instancetype)annotationViewWithMapView:(MKMapView *)mapView;
@end
