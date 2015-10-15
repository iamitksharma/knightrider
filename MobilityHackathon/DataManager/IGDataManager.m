//
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//

#import "IGDataManager.h"
#import "BeaconInfoModel.h"

@implementation IGDataManager

-(NSMutableArray *)getBeaconData
{
    NSMutableArray *beaconDataArrayObj = [[NSMutableArray alloc]init];
    
    BeaconInfoModel *beaconInfoModelObj1 = [[BeaconInfoModel alloc]initWithUUID:@"b9407f30-f5f8-466e-aff9-25556b57fe6d" withMajor:55957 withMinor:34167 withProximity:@"-1" withDate:@"" withStatus:@"N" withExpireTime:30];
    
    //BeaconInfoModel *beaconInfoModelObj2 = [[BeaconInfoModel alloc]initWithUUID:@"1341bef5-56f1-4f75-8972-fe35a422aecc" withMajor:1 withMinor:1 withProximity:@"-1" withDate:@"" withStatus:@"N" withExpireTime:1];
    
    BeaconInfoModel *beaconInfoModelObj2 = [[BeaconInfoModel alloc]initWithUUID:@"b9407f30-f5f8-466e-aff9-25556b57fe6d" withMajor:1 withMinor:7803 withProximity:@"-1" withDate:@"" withStatus:@"N" withExpireTime:30];
    
    BeaconInfoModel *beaconInfoModelObj3 = [[BeaconInfoModel alloc]initWithUUID:@"b9407f30-f5f8-466e-aff9-25556b57fe6d" withMajor:11531 withMinor:39 withProximity:@"-1" withDate:@"" withStatus:@"N" withExpireTime:30];
    
    [beaconDataArrayObj addObject:beaconInfoModelObj1];
    [beaconDataArrayObj addObject:beaconInfoModelObj2];
    [beaconDataArrayObj addObject:beaconInfoModelObj3];

    return beaconDataArrayObj;
}

@end
