//
//  ViewController.m
//  iBeaconTest00
//
//  Created by tikomo on 2014/12/10.
//  Copyright (c) 2014年 tikomo. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    
    [_locationManager requestAlwaysAuthorization]; // iOS8
    
    [self chkBeaconStart];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
// ビーコン監視を開始
//
-(void) chkBeaconStart{
    
    NSString *uuid = @"C768FFC6-B7C4-4079-8EC7-9094AAA19782";
    CLBeaconRegion *region = [[CLBeaconRegion alloc]initWithProximityUUID:[[NSUUID alloc]initWithUUIDString:uuid] identifier:@"MyBeacon"];
    [_locationManager startRangingBeaconsInRegion:region];
    
}

//
// ビーコンが検出された場合
//
-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region{
    
    if( beacons.count > 0) {
        
        NSLog(@"count = %d", beacons.count);
        
        //CLBeacon *beacon = beacons[0];
        CLBeacon *beacon = beacons.firstObject;
        
        
        
        NSLog(@"rssi = %d", beacon.rssi);
        NSLog(@"major = %@", beacon.major);
        NSLog(@"minor = %@", beacon.minor);
        NSLog(@"accuracy = %f", beacon.accuracy);
        
        if (beacon.proximity == CLProximityUnknown) {
            NSLog(@"CLProximityUnknown");
        }else if (beacon.proximity == CLProximityFar) {
            NSLog(@"CLProximityFar");
        }else if (beacon.proximity == CLProximityNear) {
            NSLog(@"CLProximityNear");
        }else if (beacon.proximity == CLProximityImmediate) {
            NSLog(@"CLProximityImmediate");
        }
        
        
        
    }
    
}

//
// ビーコンが検出できなかった場合
// 位置情報、BluetoothがOFFのケースでも呼ばれることがある
//
-(void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error{
    
}

@end
