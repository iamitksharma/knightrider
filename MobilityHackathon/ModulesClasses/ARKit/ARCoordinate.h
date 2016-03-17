//
//  ARCoordinate.h
//  AR Kit
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import <UIKit/UIKit.h>


#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (x * (180.0/M_PI))

@interface ARCoordinate : NSObject

- (NSUInteger) hash;
- (BOOL) isEqual:(id)other;
- (BOOL) isEqualToCoordinate:(ARCoordinate *) otherCoordinate;

+ (ARCoordinate *)coordinateWithRadialDistance:(double)newRadialDistance inclination:(double)newInclination azimuth:(double)newAzimuth;

@property (nonatomic, retain)	NSString *title;
@property (nonatomic, copy)		NSString *subtitle;
@property (nonatomic) double	radialDistance;
@property (nonatomic) double	inclination;
@property (nonatomic) double	azimuth;

@end
