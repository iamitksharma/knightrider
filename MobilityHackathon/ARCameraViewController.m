//
//  ARCameraViewController.m
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import "ARCameraViewController.h"
#import "MarkerView.h"
#import "Place.h"

@interface ARCameraViewController ()

    @property (nonatomic, strong) AugmentedRealityController *arController;
    @property (nonatomic, strong) NSMutableArray *geoLocations;

@end

@implementation ARCameraViewController

- (IBAction)doneBtnClicked:(id)sender {
    [[self delegate] ARCameraViewControllerDidFinish:self];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(!_arController){
        _arController = [[AugmentedRealityController alloc] initWithView:[self view] parentViewController:self withDelgate:self];
    }
    _arController.minimumScaleFactor = 0.5;
    _arController.scaleViewsBasedOnDistance = YES;
    _arController.rotateViewsBasedOnPerspective = YES;
    _arController.debugMode = YES;
}

- (NSMutableArray *)geoLocations {
    if(!_geoLocations) {
        [self generateGeoLocations];
    }
    return _geoLocations;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self geoLocations];
}


-(void) generateGeoLocations{
    [self setGeoLocations:[NSMutableArray arrayWithCapacity:[_locations count]]];
    
    for (Place *place in _locations) {

        ARGeoCoordinate *coordinate = [ARGeoCoordinate coordinateWithLocation:[place location] locationTitle:[place placeName]];
        [coordinate calibrateUsingOrigin:[_userLocation location]];
        
        MarkerView *markerView = [[MarkerView alloc] initWithCoordinate:coordinate delegate:self];
        [coordinate setDisplayView:markerView];
        
        [_arController addCoordinate:coordinate];
        [_geoLocations addObject:coordinate];
        
    }
}

#pragma mark - ARKit Delegate - Required

-(void)didUpdateHeading:(CLHeading *)newHeading {
    
}

-(void)didUpdateLocation:(CLLocation *)newLocation {
    
}

-(void)didUpdateOrientation:(UIDeviceOrientation)orientation {
    
}

#pragma mark - ARLocationDelegate

- (void)didTapMarker:(ARGeoCoordinate *)coordinate {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
