//
//  IGDataManager.h
//  MobilityHackathon
//
//  Created by Intelligrape on 16/10/15.
//  Copyright (c) 2015 Intelligrape. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface IGDataManager : NSObject

-(NSMutableArray *)getBeaconData;
-(NSMutableArray *)getSeatInfo;
-(NSMutableArray *)getPlayersImageArray;
@end
