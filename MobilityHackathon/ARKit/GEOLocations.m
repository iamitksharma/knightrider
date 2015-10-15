//
//  GEOLocations.m
//  AR Kit
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//


#import "GEOLocations.h"

@implementation GEOLocations

@synthesize delegate;

- (id)initWithDelegate:(id<ARLocationDelegate>) aDelegate
{
	[self setDelegate:aDelegate];

	return self;
}

- (NSMutableArray*)returnLocations 
{
	return [delegate geoLocations];
}

- (void)dealloc
{
	
}



@end
