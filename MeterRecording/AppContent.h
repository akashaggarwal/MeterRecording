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
@property (strong, nonatomic) NSString *installerID;



- (NSManagedObjectContext *)managedObjectContext ;
-(id) getDummySchedule:(int)i;
-(void) showMessage: (NSString *)title message:(NSString *)m ;
+(AppContent *)sharedContent;
//-(NSMutableArray*) schedules;
+ (NSString *)GetUUID;

+ (NSString *)getCurrentDate;
-(void) resetSession;
-(void) purgeOldSessions;

@end
