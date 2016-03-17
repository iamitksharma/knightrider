//
//  ARViewProtocol.h
//  AR Kit
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

@class ARGeoCoordinate;

@protocol ARMarkerDelegate <NSObject>
-(void) didTapMarker:(ARGeoCoordinate *) coordinate;
@end

@protocol ARDelegate <NSObject>

-(void) didUpdateHeading:(CLHeading *)newHeading;
-(void) didUpdateLocation:(CLLocation *)newLocation;
-(void) didUpdateOrientation:(UIDeviceOrientation) orientation;

@end
