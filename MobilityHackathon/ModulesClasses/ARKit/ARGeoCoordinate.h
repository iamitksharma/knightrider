//
//  ARGeoCoordinate.h
//  AR Kit
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "ARCoordinate.h"

@interface ARGeoCoordinate : ARCoordinate

@property (nonatomic, strong) CLLocation *geoLocation;
@property (nonatomic, strong) UIView *displayView;
@property (nonatomic) double distanceFromOrigin;
@property (nonatomic, strong) NSURL *photoURL;

- (float)angleFromCoordinate:(CLLocationCoordinate2D)first toCoordinate:(CLLocationCoordinate2D)second;


+ (ARGeoCoordinate *)coordinateWithLocation:(CLLocation *)location locationTitle:(NSString *) titleOfLocation photoURL:(NSURL*)photoURL;
+ (ARGeoCoordinate *)coordinateWithLocation:(CLLocation *)location fromOrigin:(CLLocation *)origin photoURL:(NSURL*)photoURL;

- (void)calibrateUsingOrigin:(CLLocation *)origin;

@end
