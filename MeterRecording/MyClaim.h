//
//  MyClaim.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 12/28/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleClaim.h"

@interface MyClaim : NSObject

@property(strong, nonatomic) ScheduleClaim *claim;
+(MyClaim *)sharedContent;
-(void) resetClaim;

@end