//
//  SpeechConstant.m
//  MobilityHackathon
//
//  Created by Sandeep Kharbanda on 16/10/15.
//  Copyright © 2015 Intelligrape. All rights reserved.
//

#import "SpeechConstant.h"
#import <SpeechKit/SpeechKit.h>

@implementation SpeechConstant

+ (void)setupSpeechKitConnection {
    
    [SpeechKit setupWithID:@"NMDPTRIAL_sandeep_kharbanda_tothenew_com20151006135713"
                      host:@"sandbox.nmdp.nuancemobility.net"
                      port:443
                    useSSL:NO
                  delegate:nil];
    
    // Set earcons to play
    //SKEarcon* earconStart	= [SKEarcon earconWithName:@"earcon_listening.wav"];
    //SKEarcon* earconStop	= [SKEarcon earconWithName:@"earcon_done_listening.wav"];
    SKEarcon* earconCancel	= [SKEarcon earconWithName:@"earcon_cancel.wav"];
    
    //[SpeechKit setEarcon:earconStart forType:SKStartRecordingEarconType];
    //[SpeechKit setEarcon:earconStop forType:SKStopRecordingEarconType];
    [SpeechKit setEarcon:earconCancel forType:SKCancelRecordingEarconType];
}

@end
