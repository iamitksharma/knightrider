//
//  Place.m
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import "Place.h"

@implementation Place

- (id)initWithLocation:(CLLocation *)location reference:(NSString *)reference name:(NSString *)name address:(NSString *)address{
    
    if(self=[super init]){
        _location = location;
        _reference = reference;
        _placeName = name;
        _address = address;
    }
    return self;
}
@end
