//
//  ARLocationDelegate.h
//  AR Kit
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//


#import "ARGeoCoordinate.h"

@protocol ARLocationDelegate

//returns an array of ARGeoCoordinates
-(NSMutableArray *)geoLocations;
-(void) locationClicked:(ARGeoCoordinate *) coordinate;

@end

