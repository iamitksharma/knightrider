//
//  ViewController.m
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import "ViewController.h"
#import "PlaceLoader.h"
#import "PlaceAnnotation.h"
#import "ARCameraViewController.h"
#import "Place.h"
#import "IGDataManager.h"
#import "AppDelegate.h"
#import "SpeechConstant.h"

NSString * const kNameKey = @"name";
NSString * const kReferenceKey = @"reference";
NSString * const kAddressKey = @"vicinity";
NSString * const kLatitudeKeypath = @"geometry.location.lat";
NSString * const kLongitudeKeypath = @"geometry.location.lng";

@interface ViewController ()
{
    AppDelegate* appDelegate;
}
@property (weak, nonatomic) IBOutlet UISearchBar *searchLocation;
@property (nonatomic,strong) IGBLEManager *bleManagerObj;
@property (nonatomic,strong) IGDataManager *dataManagerObj;
@property (nonatomic,strong) CLBeacon *beaconObj;
@property (strong, nonatomic) CLLocation *accurateLocationInformation;
@property (nonatomic, strong) NSArray *locations;
@end


const unsigned char SpeechKitApplicationKey[] = {0xa8, 0xa9, 0xe8, 0x6a, 0xc9, 0xe5, 0x23, 0xab, 0xe0, 0x64, 0xff, 0xb4, 0xb3, 0x4e, 0x29, 0x75, 0x9a, 0xf7, 0x63, 0x65, 0x23, 0x4c, 0x24, 0xc7, 0x6a, 0x61, 0x26, 0xb9, 0x42, 0x5e, 0x47, 0xea, 0x08, 0x2f, 0x55, 0xd1, 0x15, 0x78, 0x7c, 0xf5, 0xdc, 0x7c, 0xa9, 0x90, 0xca, 0xd3, 0x05, 0x64, 0xca, 0x68, 0xc9, 0xed, 0xb4, 0xed, 0xb5, 0x1f, 0x4e, 0xdb, 0xd8, 0x91, 0x3a, 0x1f, 0x7b, 0x42};

@implementation ViewController

//@synthesize mapView;
//@synthesize locationManager;
- (IBAction)cameraClicked:(id)sender {
    ARCameraViewController *cameraView = [self.storyboard instantiateViewControllerWithIdentifier:@"ARCameraViewController"];
    [self presentViewController:cameraView animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initilizeManagers];
    [self startScanningBeacons];
    
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
    
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [SpeechConstant setupSpeechKitConnection];
    
    self.vocalizer = [[SKVocalizer alloc] initWithLanguage:@"en_US" delegate:self];
    
    [_mapView setShowsUserLocation:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_searchLocation resignFirstResponder];
}

#pragma mark - SearchBar Delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //NSLog(@"Search Text : %@", searchBar.text);
    [self searchForLocation];
    
    [searchBar resignFirstResponder];
}

#pragma mark - CLLocationManagerDelegates

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *lastLocation = locations.lastObject;
    CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
    
    if(accuracy < 100.0){
        _accurateLocationInformation = lastLocation;
        
        MKCoordinateSpan span = MKCoordinateSpanMake(0.15, 0.15);
        MKCoordinateRegion region =  MKCoordinateRegionMake([lastLocation coordinate], span);
        [_mapView setRegion:region animated:YES];
        [manager stopUpdatingLocation];
        
    }
}

-(void)searchForLocation{
    
    NSMutableArray *annotationsToRemove = [[NSMutableArray alloc] initWithArray: _mapView.annotations];
    [_mapView removeAnnotations:annotationsToRemove];

    
    [[PlaceLoader sharedInstance]loadPOIsForLocation:_accurateLocationInformation radius:1000  searchKey:_searchLocation.text
                                      successHandler:^(NSDictionary *response) {
                                          if([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
                                              
                                              id places = [response objectForKey:@"results"];
                                              
                                              NSMutableArray *temp = [NSMutableArray array];
                                              
                                              
                                              if([places isKindOfClass:[NSArray class]]) {
                                                  for(NSDictionary *resultsDict in places) {
                                                      
                                                      CLLocation *location = [[CLLocation alloc] initWithLatitude:[[resultsDict valueForKeyPath:kLatitudeKeypath] floatValue] longitude:[[resultsDict valueForKeyPath:kLongitudeKeypath] floatValue]];
                                                      
                                                      
                                                      Place *currentPlace = [[Place alloc] initWithLocation:location reference:[resultsDict objectForKey:kReferenceKey] name:[resultsDict objectForKey:kNameKey] address:[resultsDict objectForKey:kAddressKey]];
                                                      
                                                      [temp addObject:currentPlace];
                                                      
                                                      
                                                      PlaceAnnotation *annotation = [[PlaceAnnotation alloc] initWithPlace:currentPlace];
                                                      [_mapView addAnnotation:annotation];
                                                  }
                                              }
                                              
                                              
                                              _locations = [temp copy];
                                              
                                              //NSLog(@"Locations: %@", _locations);
                                          }
                                          
                                      } errorHandler:^(NSError *error) {
                                          NSLog(@"Error: %@", error);
                                      }];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error While Update : %@",error);
}

#pragma mark - ARCamera View

- (void)ARCameraViewControllerDidFinish:(ARCameraViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        [[segue destinationViewController] setLocations:_locations];
        [[segue destinationViewController] setUserLocation:[_mapView userLocation]];
    }
}


- (void) tableManager:(id)sender didRangeBeacons:(CLBeacon *)beacon inRegion:(CLBeaconRegion *)region
{
    NSLog(@"Beacon detection call back");
}


-(void)deviceEnterBeaconRegionNotification
{
    NSLog(@"app enter into the beacon reason");
}
-(void)deviceExitBeaconRegionNotification
{
    
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    
}

-(void)initilizeManagers
{
    self.bleManagerObj = [[IGBLEManager alloc]init];
    self.bleManagerObj.delegate = self;
    self.dataManagerObj = [[IGDataManager alloc]init];

}
-(void)startScanningBeacons
{
    NSArray *beaconDataArray = [self.dataManagerObj getBeaconData];
    [self.bleManagerObj addBeacons:beaconDataArray];
}


# pragma mark - when record button is tapped

- (IBAction)recordButtonTapped:(id)sender {
    self.recordButton.selected = !self.recordButton.isSelected;
    
    if (self.recordButton.isSelected) {
        self.voiceSearch = [[SKRecognizer alloc] initWithType:SKSearchRecognizerType
                                                    detection:SKShortEndOfSpeechDetection
                                                     language:@"en_US"
                                                     delegate:self];
    }
    
    // This will stop existing speech recognizer processes
    else {
        
        if (self.voiceSearch) {
            [self.voiceSearch stopRecording];
            [self.voiceSearch cancel];
        }
        
        if (self.isSpeaking) {
            [self.vocalizer cancel];
            self.isSpeaking = NO;
        }
        
    }
    
}

# pragma mark - SKRecognizer Delegate Methods

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer {
    //self.messageLabel.text = @"Listening..";
}

- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer {
    //self.messageLabel.text = @"Done Listening..";
}


- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results {
    long numOfResults = [results.results count];
    
    if (numOfResults > 0) {
        // update the text of text field with best result from SpeechKit
        _searchLocation.text = [results firstResult];
        
        [self.vocalizer speakString:[NSString stringWithFormat:@"You are looking for %@",
                                    _searchLocation.text]];
        
        [self searchBarSearchButtonClicked:_searchLocation];
    }
    else
    {
        [self.vocalizer speakString:@"I am not able to understand Please say it again"];
    }
    
    self.recordButton.selected = !self.recordButton.isSelected;
    
    
    if (self.voiceSearch) {
        [self.voiceSearch cancel];
    }
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion {
    self.recordButton.selected = NO;
    //self.messageLabel.text = @"Connection error";
    //self.activityIndicator.hidden = YES;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}



# pragma mark - SKVocalizer Delegate Methods


- (void)vocalizer:(SKVocalizer *)vocalizer willBeginSpeakingString:(NSString *)text {
    self.isSpeaking = YES;
}

- (void)vocalizer:(SKVocalizer *)vocalizer didFinishSpeakingString:(NSString *)text withError:(NSError *)error {
    if (error !=nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        if (self.isSpeaking) {
            [self.vocalizer cancel];
        }
    }
    
    self.isSpeaking = NO;
}


@end
