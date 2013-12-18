//
//  AppContent.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"

@interface AppContent : NSObject

@property(strong, readonly) Session *session;


-(id) getDummySchedule:(int)i;

+(AppContent *)sharedContent;
//-(NSMutableArray*) schedules;


@end
