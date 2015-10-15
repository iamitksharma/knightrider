//
//  PlaceAnnotation.m
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import "PlaceAnnotation.h"
#import "Place.h"

@interface PlaceAnnotation ()
@property (nonatomic,strong)Place *place;
@end

@implementation PlaceAnnotation

-(id) initWithPlace :(Place *)place{
    if(self=[super init]){
        _place = place;
    }
    return self;
}

-(NSString *) title{
    return [_place placeName];
}

-(CLLocationCoordinate2D) coordinate{
    return _place.location.coordinate;
}


@end
