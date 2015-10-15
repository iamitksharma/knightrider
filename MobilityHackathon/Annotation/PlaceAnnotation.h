//
//  PlaceAnnotation.h
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class Place;

@interface PlaceAnnotation : NSObject <MKAnnotation>

-(id) initWithPlace :(Place *)place;
-(NSString *) title;
-(CLLocationCoordinate2D) coordinate;

@end
