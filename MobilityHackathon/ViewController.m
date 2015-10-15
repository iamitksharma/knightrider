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

NSString * const kNameKey = @"name";
NSString * const kReferenceKey = @"reference";
NSString * const kAddressKey = @"vicinity";
NSString * const kLatitudeKeypath = @"geometry.location.lat";
NSString * const kLongitudeKeypath = @"geometry.location.lng";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchLocation;
@property (nonatomic,strong) IGBLEManager *bleManagerObj;
@property (nonatomic,strong) IGDataManager *dataManagerObj;
@property (nonatomic,strong) CLBeacon *beaconObj;
@property (strong, nonatomic) CLLocation *accurateLocationInformation;
@property (nonatomic, strong) NSArray *locations;
@end

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

@end
