//
//  PlaceLoader.h
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CLLocation;

typedef void (^SuccessHandler) (NSDictionary *responseDic);
typedef void (^ErrorHandler)(NSError *error);

@interface PlaceLoader : NSObject




+( PlaceLoader *)sharedInstance;
- (void)loadPOIsForLocation:(CLLocation *)location radius:(int)radius searchKey:(NSString *)keyword successHandler:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler;
@end
