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
#import <SpeechKit/SpeechKit.h>



@interface ViewController : UIViewController<CLLocationManagerDelegate, UISearchBarDelegate, MKMapViewDelegate, ARCameraViewControllerDelegate,IGBLEManagerDelegate,CBPeripheralManagerDelegate , SpeechKitDelegate, SKRecognizerDelegate, SKVocalizerDelegate>


@property (strong, nonatomic) CLLocationManager *locationManager;

@property (strong, nonatomic) SKRecognizer* voiceSearch;

@property (strong, nonatomic) NSString* searchCriteria;

@property (strong, nonatomic) SKVocalizer* vocalizer;

@property (strong, nonatomic) NSString* searchText;

@property BOOL isSpeaking;


@end

