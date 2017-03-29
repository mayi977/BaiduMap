//
//  ViewController.m
//  BaiduMapDemo
//
//  Created by Zilu.Ma on 16/3/28.
//  Copyright © 2016年 VSI. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"8tzjU85q2YsQeYFWPWnWD3hpcNydMDVX"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _mapView.delegate = self;
    _mapView.zoomLevel =15;
    _mapView.showsUserLocation=YES;
    //调节初始地图坐标
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(31.180214, 121.429932);//31.180214====121.429932
    
    //BMKMapTypeNone   设置地图为空白类型
    //BMKMapTypeStandard  切换为普通地图
    //BMKMapTypeSatellite  切换为卫星图
    [_mapView setMapType:BMKMapTypeStandard];
    
    //打开实时路况图层
    [_mapView setTrafficEnabled:YES];
    
    [self.view addSubview:_mapView];
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
    [_mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // 添加一个标注
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 31.180214;
    coor.longitude = 121.429932;//31.180214====121.429932
    annotation.coordinate = coor;
    annotation.title = @"这里是上海";
    [_mapView addAnnotation:annotation];
}

//气泡
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
- (void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
