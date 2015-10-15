//
//  ViewController.h
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ARCameraViewController.h"
#import "IGBLEManager.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface ViewController : UIViewController<CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate, ARCameraViewControllerDelegate,IGBLEManagerDelegate,CBPeripheralManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

