//
//  PlaceLoader.m
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import "PlaceLoader.h"
#import <Foundation/NSJSONSerialization.h>
#import <CoreLocation/CoreLocation.h>



//NSString * const apiURL = @"https://maps.googleapis.com/maps/api/place/";

NSString * const apiURL = @"https://maps.googleapis.com/maps/api/place/";
NSString * const apiKey = @"AIzaSyDAxbozyQVhJFTD6eMaH8MQUAXOBVVHt2U";

@interface PlaceLoader()

    @property (nonatomic, strong) SuccessHandler successHandler;
    @property (nonatomic, strong) ErrorHandler errorHandler;
    @property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation PlaceLoader



+(PlaceLoader *)sharedInstance{
    static PlaceLoader *instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^ {
        instance = [[PlaceLoader alloc]init];
    });
    return instance;
}


- (void)loadPOIsForLocation:(CLLocation *)location radius:(int)radius  searchKey:(NSString *)keyword successHandler:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler {
    
    _responseData = nil;
    [self setSuccessHandler:handler];
    [self setErrorHandler:errorHandler];
    

    CLLocationDegrees latitude = [location coordinate].latitude;
    CLLocationDegrees longitude = [location coordinate].longitude;
    

    NSMutableString *uri = [NSMutableString stringWithString:apiURL];
    [uri appendFormat:@"textsearch/json?location=%f,%f&radius=%d&query=%@&sensor=true&types=establishment&key=%@", latitude, longitude, radius, keyword, apiKey];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[uri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    

    [request setHTTPShouldHandleCookies:YES];
    [request setHTTPMethod:@"GET"];
    

    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSLog(@"Starting connection: %@ for request: %@", connection, request);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(!_responseData) {
        _responseData = [NSMutableData dataWithData:data];
    } else {
        [_responseData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    id object = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingAllowFragments error:nil];
    
    if(_successHandler) {
        _successHandler(object);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if(_errorHandler) {
        _errorHandler(error);
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
