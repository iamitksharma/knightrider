//
//  ARKit.h
//  AR Kit
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//



#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ARGeoCoordinate.h"
#import "ARLocationDelegate.h"
#import "ARViewProtocol.h"
#import "GEOLocations.h"
#import "AugmentedRealityController.h"


@interface ARKit : NSObject

+(BOOL)deviceSupportsAR;

@end
