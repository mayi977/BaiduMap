//
//  ViewController.h
//  BaiduMapDemo
//
//  Created by Zilu.Ma on 16/3/28.
//  Copyright © 2016年 VSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件


@interface ViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>

{
    BMKMapManager* _mapManager;
    BMKMapView *_mapView;
    BMKLocationService *_locService;
}

@end

