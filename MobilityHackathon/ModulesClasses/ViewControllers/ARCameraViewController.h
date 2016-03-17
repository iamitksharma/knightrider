//
//  ARCameraViewController.h
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ARKit.h"


@class ARCameraViewController;

@protocol ARCameraViewControllerDelegate
- (void)ARCameraViewControllerDidFinish:(ARCameraViewController *)controller;
@end

@interface ARCameraViewController : UIViewController<ARLocationDelegate, ARDelegate, ARMarkerDelegate>

@property (strong, nonatomic) NSArray *locations;
@property (strong, nonatomic) MKUserLocation *userLocation;
@property (weak, nonatomic) id <ARCameraViewControllerDelegate> delegate;

@end
