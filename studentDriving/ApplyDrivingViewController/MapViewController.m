//
//  MapViewController.m
//  BlackCat
//
//  Created by bestseller on 15/9/14.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import <BaiduMapAPI/BMKMapView.h>
#import <BaiduMapAPI/BMKPointAnnotation.h>
#import <BaiduMapAPI/BMKPinAnnotationView.h>
@interface MapViewController ()<BMKMapViewDelegate>

@property (strong, nonatomic) BMKMapView *mapView;
@end

@implementation MapViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"地图";
    
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.zoomLevel = 15;

    [self.view addSubview:_mapView];
   

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _mapView = nil;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

    
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    CLLocationCoordinate2D coor;
    coor.latitude = self.latitudeNum.doubleValue;
    coor.longitude = self.longitudeNum.doubleValue;
    annotation.coordinate = coor;
    NSLog(@"latitude = %@ ",annotation);
    [_mapView addAnnotation:annotation];
    
    _mapView.centerCoordinate = coor;
    
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{

    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        NSLog(@"new = %@",newAnnotationView);

        return newAnnotationView;
        
    }
    return nil;
}

@end
