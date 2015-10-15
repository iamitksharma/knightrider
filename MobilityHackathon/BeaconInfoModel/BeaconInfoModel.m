//
//  BeaconInfoModel.m
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//


#import "BeaconInfoModel.h"

@implementation BeaconInfoModel

#pragma mark - Model initilazation method
/*This method used to intilize the BeaconInfoModel with uuid,major,minor,proximity and date*/
-(id) initWithUUID:(NSString *)uuid withMajor:(int)major withMinor:(int)minor withProximity:(NSString *)proximity withDate:(NSString *)date withStatus:(NSString *)status withExpireTime:(int)time
{
    self = [super init];
    if (self)
    {
        self.uuid = uuid;
        self.major = major;
        self.minor = minor;
        self.proximity = proximity;
        self.date = date;
        self.status = status;
        self.beaconExpireTime = time;
    }
    return self;
}

@end
