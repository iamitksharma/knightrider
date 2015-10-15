//
//  IGBLEManager.m
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import "IGBLEManager.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BeaconInfoModel.h"
@interface IGBLEManager ()<CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property CLProximity previousProximity;
@property (nonatomic,strong) NSArray *beacons;
@property (nonatomic,strong) NSMutableDictionary *activeBeacons;

@end
@implementation IGBLEManager

/*This method used to initilize the TABleManager class and then intilize the locationmanager to get the location update when application enter or exit the vicinity of a beacon reagion*/
- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        
        NSArray *vComp = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
        
        if ([[vComp objectAtIndex:0] intValue] >= 8)
        {
            //NSLog(@"This is an ios8 api");
            [self.locationManager requestAlwaysAuthorization];
            
            [self.locationManager requestWhenInUseAuthorization];
        }
        self.locationManager.pausesLocationUpdatesAutomatically = NO;

        self.locationManager.delegate = self;
        
        self.activeBeacons = [NSMutableDictionary new];
    }
    return self;
}


- (void) addBeacons:(NSArray *)beacons
{
    NSMutableArray *beaconArray = [[NSMutableArray alloc]init];
    
    for(BeaconInfoModel *beaconInfoModelObj in beacons)
    {
        //NSDictionary *dict = (NSDictionary *)obj;
        
        NSUUID * uid = [[NSUUID alloc] initWithUUIDString:beaconInfoModelObj.uuid];
        CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uid identifier:beaconInfoModelObj.uuid];
        
        // When set to YES, the location manager sends beacon notifications when the user turns on the display
        // and the device is already inside the region.
        [beaconRegion setNotifyEntryStateOnDisplay:YES];
        [beaconRegion setNotifyOnEntry:YES];
        [beaconRegion setNotifyOnExit:YES];
        
        [self.locationManager startMonitoringForRegion:beaconRegion];
        [self.locationManager startRangingBeaconsInRegion:beaconRegion];
        
        [beaconArray addObject:beaconRegion];
    }
    self.beacons = beaconArray;
}
- (void) removeAllBeacons
{
    for (CLBeaconRegion *beaconRegion in _beacons)
    {
        [self.locationManager stopRangingBeaconsInRegion:beaconRegion];
        [self.locationManager stopMonitoringForRegion:beaconRegion];
    }
}

/*This method get called when an application enter in beacon region*/
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Device entered in beacon region");
    // See if we've entered the region.
    [self.delegate deviceEnterBeaconRegionNotification];
}

/*This method get called when an application exit an beacon region*/
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    [self.delegate deviceExitBeaconRegionNotification];
    NSLog(@"Device exit in beacon region");

    //[self removeBeaconFromActiveBeacons:theBeacon];
}

/*Local method to add beacons in active regions*/
- (void) addNewBeaconToActiveBeacons:(CLBeacon *)newBeacon
{
//    [self.activeBeacons setObject:newBeacon forKey:[self createUniqueString:newBeacon]];
}

/*Local method to remove beacon from active region*/
- (void) removeBeaconFromActiveBeacons:(CLBeacon *)beacon
{
//    [self.activeBeacons removeObjectForKey:[self createUniqueString:beacon]];
}

/*Delegate method of location manager and provide the data related to beacon ranging*/
-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    for(CLBeacon *beacon in beacons)
    {
        if((beacon.proximity == CLProximityFar) | CLProximityImmediate | CLProximityNear)
        {
            self.nearBeacon = beacon;
        }
    }
    
    if ( [beacons count] == 0)
    {
        return ;
    }
    
    [_delegate tableManager:self didRangeBeacons:self.nearBeacon inRegion:region];
}

- (CGPoint)getCoordinateWithBeaconA:(CGPoint)a beaconB:(CGPoint)b beaconC:(CGPoint)c distanceA:(CGFloat)dA distanceB:(CGFloat)dB distanceC:(CGFloat)dC
{
    CGFloat W, Z, x, y, y2;
    W = dA*dA - dB*dB - a.x*a.x - a.y*a.y + b.x*b.x + b.y*b.y;
    Z = dB*dB - dC*dC - b.x*b.x - b.y*b.y + c.x*c.x + c.y*c.y;
    
    x = (W*(c.y-b.y) - Z*(b.y-a.y)) / (2 * ((b.x-a.x)*(c.y-b.y) - (c.x-b.x)*(b.y-a.y)));
    y = (W - 2*x*(b.x-a.x)) / (2*(b.y-a.y));
    //y2 is a second measure of y to mitigate errors
    y2 = (Z - 2*x*(c.x-b.x)) / (2*(c.y-b.y));
    
    y = (y + y2) / 2;
    return CGPointMake(x, y);
}
@end
