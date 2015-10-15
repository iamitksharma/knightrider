//
//  IGBLEManager.h
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLBeaconRegion;
@class CLBeacon;

@protocol IGBLEManagerDelegate <NSObject>

- (void) tableManager:(id)sender didRangeBeacons:(CLBeacon *)beacon inRegion:(CLBeaconRegion *)region;
-(void)deviceEnterBeaconRegionNotification;
-(void)deviceExitBeaconRegionNotification;

@end

@interface IGBLEManager : NSObject

@property (nonatomic,strong) CLBeacon *nearBeacon;
@property (nonatomic,weak) id<IGBLEManagerDelegate> delegate;

- (void) addBeacons:(NSArray *)beacons;
- (void) removeAllBeacons;

@end
