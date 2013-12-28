//
//  AppContent.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"
#import "ScheduleClaim.h"


@interface AppContent : NSObject

@property(strong, readonly) Session *session;
@property (strong, nonatomic) NSString *installerID;
//@property(strong, nonatomic) ScheduleClaim *currentClaim;


- (NSManagedObjectContext *)managedObjectContext ;
-(id) getDummySchedule:(int)i;
-(void) showMessage: (NSString *)title message:(NSString *)m ;
+(AppContent *)sharedContent;
//-(NSMutableArray*) schedules;
+ (NSString *)GetUUID;

+ (NSString *)getCurrentDate;
-(void) resetSession;
-(void) purgeOldSessions;
- (BOOL)saveChanges;
@end
