//
//  GPSLocationManager.m
//  IKToolsModule
//
//  Created by HU on 2018/8/9.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "GPSLocationManager.h"
#import "JHToolsDefine.h"
@interface GPSLocationManager()<CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) LocationResult locationResultBlock;
@property (nonatomic, assign) BOOL isStop;
@end

@implementation GPSLocationManager

SingletonM(GPSLocationManager)

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0) {
                [_locationManager requestWhenInUseAuthorization];
            } else {
                [_locationManager startUpdatingLocation];
            }
            break;
        case kCLAuthorizationStatusDenied:
            //请打开系统设置中\"隐私->定位服务\",允许使用您的位置。
            break;
        case kCLAuthorizationStatusRestricted:
            //定位服务无法使用！
            break;
            
        default:
            [_locationManager startUpdatingLocation];//开启位置更新
            break;
    }
}

#pragma mark - 启动定位
- (void)startLocationAndCompletion:(LocationResult)completion{
    //初始化CLLocationManager
    if (_locationManager) {
        _isStop = NO;
        _locationManager = nil;
    }
    if (_locationResultBlock) {
        _locationResultBlock = nil;
    }
    NSLog(@"启动定位");
    
    _locationResultBlock = completion;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    [_locationManager requestAlwaysAuthorization];// 前后台同时定位
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    if (_isStop) {
        return;
    }
    
    //得到Location
    CLLocation *coord = [locations objectAtIndex:0];
    
    NSLog(@"采集到的坐标经度:%f, 维度:%f  精度%f", coord.coordinate.longitude, coord.coordinate.latitude, coord.horizontalAccuracy);
    //判断采集到的精度
    if (_locationResultBlock && !_isStop) {
        _locationResultBlock(coord, kLocationFailedError);
    }
}

#pragma mark - 定位失败
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败:%@", error);
    if (!_isStop && _locationResultBlock) {
        _locationResultBlock(kZeroLocation, error);
    }
}

- (void)stop{
    _isStop = YES;
    [_locationManager stopUpdatingLocation];
}

- (void)geocodeAddressWithCoordinate:(CLLocationCoordinate2D)loc completion:(void (^)(NSString *))completion{
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    CLLocation *mycurLocaton=[[CLLocation alloc]initWithLatitude:loc.latitude longitude:loc.longitude];
    //反解析
    [geoCoder reverseGeocodeLocation:mycurLocaton completionHandler:^(NSArray *places,NSError *error){
        //取得第一个地标，地标中存储了详细的地址信息，注意：一个地名可能搜索出多个地址
        CLPlacemark *placemark = [places firstObject];
        NSDictionary *addressDic = placemark.addressDictionary;//详细地址信息字典,包含以下部分信息
        NSString *city = @"";
        if (addressDic && addressDic[@"City"]) {
            city = addressDic[@"City"];
        }
        completion(city);
    }];
}

@end
