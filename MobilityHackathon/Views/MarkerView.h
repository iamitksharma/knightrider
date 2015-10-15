//
//  MarkerView.h
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ARGeoCoordinate;
@protocol MarkerViewDelegate;

@interface MarkerView : UIView


@property (nonatomic, strong) ARGeoCoordinate *coordinate;

@property (nonatomic, weak) id <MarkerViewDelegate> delegate;

-(id)initWithCoordinate:(ARGeoCoordinate *)coordinate delegate:(id<MarkerViewDelegate>)delegate ;

@end

@protocol MarkerViewDelegate <NSObject>

-(void)didTouchMarkerView:(MarkerView *)markerView;

@end