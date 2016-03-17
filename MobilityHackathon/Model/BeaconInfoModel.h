//
//  BeaconInfoModel.h
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeaconInfoModel : NSObject

@property (nonatomic,strong)NSString *uuid;
@property (assign)int major;
@property (assign)int minor;
@property (nonatomic,strong)NSString *proximity;
@property (nonatomic,strong)NSString *date;
@property (nonatomic,strong) NSString *status;
@property (assign) int beaconExpireTime;

-(id) initWithUUID:(NSString *)uuid withMajor:(int)major withMinor:(int)minor withProximity:(NSString *)proximity withDate:(NSString *)date withStatus:(NSString *)status withExpireTime:(int)time;

@end
