//
//  MyClaim.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 12/28/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "MyClaim.h"
#import "ScheduleClaim.h"

@implementation MyClaim

static MyClaim *singletonInstance = nil;
ScheduleClaim *_claim;


+ (MyClaim *)sharedContent{
    @synchronized(self){
        if (singletonInstance == nil)
        {
            singletonInstance = [[self alloc] init];
            //singletonInstance.claim = [[ScheduleClaim alloc] init];
            
            NSLog(@"creating myClaim");
            
        }
        return(singletonInstance);
    }
}

-(void) resetClaim
{
    _claim = [[ScheduleClaim alloc] init];
}


@end
