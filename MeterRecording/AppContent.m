//
//  AppContent.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "AppContent.h"
#import <CoreData/CoreData.h>
#import <AdSupport/ASIdentifierManager.h>
#import "MBProgressHUD.h"

@interface AppContent() {
    
    //NSMutableArray* schedules ;
   // NSString* lastDateTimeScheduleFetched;
   // NSString* installerID;
}


-(NSURL *)dataStoreURL;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;

@end



@implementation AppContent


static AppContent *singletonInstance = nil;
NSManagedObjectModel *_managedObjectModel;
NSPersistentStoreCoordinator *_persistentStoreCoordinator;
NSManagedObjectContext *_managedObjectContext;
Session *_session;


+ (AppContent *)sharedContent{
    @synchronized(self){
        if (singletonInstance == nil)
        {
            singletonInstance = [[self alloc] init];
            //singletonInstance.schedules = [[NSMutableArray init] alloc];
            
            NSLog(@"creating the apcontent");
            
        }
        return(singletonInstance);
    }
}

-(void) resetSession
{
    _session =  nil;
}
+ (NSString *)getCurrentDate
{
    NSDate *date         = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString  = [df stringFromDate:date];
    return dateString;
    
}
+ (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

-(void) showMessage:(NSString *)title message:(NSString *)m
{
    
    UIAlertView *alert = [[UIAlertView alloc]  initWithTitle:title message:m delegate:nil cancelButtonTitle:nil otherButtonTitles:nil ];
    [alert addButtonWithTitle:@"OK"];
    [alert show];

}

-(void) showHUDMessage: (NSString *)s view:(UIView *) v
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:v animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    //hud.detailsLabelFont = [UIFont smallSystemFontSize];
    hud.detailsLabelText = s;
    hud.margin = 10.f;
    hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:5];
    
}
-(Session*) session
{
    NSLog(@"inside session fetch");
    if(_session)
    {
          NSLog(@"returning session already in memory for  installerid->%@",[self installerID]);
        return _session;
    }

    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_SESSION
                                              inManagedObjectContext:context];
    request.entity = entity;
    NSDate *currentDate = [AppContent getCurrentDate];
    NSLog(@"installerid->%@ , session id ->%@", self.installerID, [AppContent getCurrentDate]);
    
    NSString *attributeName = @"installerID";
    NSString *attributeValue = self.installerID;
    NSPredicate *p = [NSPredicate predicateWithFormat:@"(installerID == %@) AND (lastDateTime == %@)",
                             self.installerID, currentDate];
    
   // NSPredicate *p = [NSPredicate predicateWithFormat:@"installerID contains %@ AND lastDateTime contains '%@'", self.installerID, currentDate];
    //A
    request.predicate = p;
    NSError *err = nil;
    NSArray *listOfObjects = [context executeFetchRequest:request
                                                    error:&err];
    NSLog(@"errors are %@",[err localizedDescription]);
    if (listOfObjects == nil)
    {
          NSLog(@"nil session ");
         return nil;
    }
    if([listOfObjects count] == 1)
    {
          NSLog(@"found exactly session ");
        _session = [listOfObjects lastObject];
        return _session;
    }
    if([listOfObjects count] > 1)
    {
        NSLog(@" count->%lu", (unsigned long)[listOfObjects count]);
        NSLog(@"more than one session in data store - should not have happened");
        return nil;
    }

    NSLog(@"Nothing in data store - so we need a new session");
       return _session;
    
}

-(void) purgeOldSessions
{
    
 
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_SESSION
                                              inManagedObjectContext:context];
    request.entity = entity;
    NSDate *currentDate = [AppContent getCurrentDate];
   
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"lastDateTime != %@",currentDate];
    
    // NSPredicate *p = [NSPredicate predicateWithFormat:@"installerID contains %@ AND lastDateTime contains '%@'", self.installerID, currentDate];
    //A
    request.predicate = p;
    NSError *err = nil;
    NSArray *listOfObjects = [context executeFetchRequest:request
                                                    error:&err];
    NSLog(@"errors are %@",[err localizedDescription]);
    if (listOfObjects == nil)
    {
        NSLog(@"no old sessions ");
        
    }
    for(Session *s in listOfObjects)
    {
        NSLog(@"deleting session with id->%@ ", s.sessionID);
        
        [context deleteObject:s];
   
    }
    [context save:nil];
}


-(void) purgeOldSchedulesNotQueued
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_SCHEDULE
                                              inManagedObjectContext:context];
    request.entity = entity;
    NSDate *currentDate = [AppContent getCurrentDate];
    
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"sessionStartDate != %@ ",currentDate];
    
    request.predicate = p;
    NSError *err = nil;
    NSArray *listOfObjects = [context executeFetchRequest:request
                                                    error:&err];
    NSLog(@"errors are %@",[err localizedDescription]);
    if (listOfObjects == nil)
    {
        NSLog(@"no old schedules ");
        
    }
  
    for(Schedule *s in listOfObjects)
    {
        NSLog(@"local schedule status->%@",[s localschedulestatus]);
        if ([s.localschedulestatus isEqualToString:CLAIM_QUEUED])
        {
            NSLog(@"Found queued claim with schedule with id->%@ ", s.scheduleID);
        }
        else
        {
            NSLog(@"deleting schedule with id->%@ ", s.scheduleID);
            [context deleteObject:s];
        }
    }
    [context save:nil];
    
   }


-(bool) IsCompletedOrQueuedSchedulePresent
{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_SCHEDULE
                                              inManagedObjectContext:context];
    request.entity = entity;
 
    NSPredicate *p = [NSPredicate predicateWithFormat:@"localschedulestatus != '0' "];
    
    request.predicate = p;
    NSError *err = nil;
    NSArray *listOfObjects = [context executeFetchRequest:request
                                                    error:&err];
    NSLog(@"errors are %@",[err localizedDescription]);
    if (listOfObjects == nil)
    {
        NSLog(@"no old queued or completed claims ");
        return false;
        
    }
    NSLog(@" old queued or completed claims count->%d",[listOfObjects count]);
    if ([listOfObjects count] > 0)
    {
     return true;
    }
    else
        return false;
    
   
}


//
//- (NSMutableArray*)schedules
//{
//    if (_schedules == nil)
//    {
//        _schedules = [[NSMutableArray alloc] init];
//    }
//    return _schedules;
//}


//+ (AppContent*)sharedContent
//{
//    static AppContent *_sharedContent = nil;
//    static dispatch_once_t oncePredicate;
//    dispatch_once(&oncePredicate, ^{
//        _sharedContent = [[AppContent alloc] init];
//    });
//    return _sharedContent;
//}



- (id)init
{
    self = [super init];
    if (self) {
       // self.schedules = [[NSMutableArray init] alloc];
        
//        [self.schedules addObject:[self getDummySchedule:1]];
//        
//        [self.schedules addObject:[self getDummySchedule:2]];
//        
//        [self.schedules addObject:[self getDummySchedule:3]];
//        
//        [self.schedules addObject:[self getDummySchedule:4]];
//        
    }
    return self;
}


-(NSString *) getImagesPath
{
        NSArray *documentDirectories =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                            NSUserDomainMask,
                                            YES);
        
        NSString *documentDirectory = [documentDirectories objectAtIndex:0];
        return [documentDirectory stringByAppendingString:@"/images"];
}


-(NSURL *)dataStoreURL {
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@" doc dir is %@",docDir);
    return [NSURL fileURLWithPath:[docDir stringByAppendingPathComponent:@"Neptune.sql"]];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:[self dataStoreURL]
                                                         options:nil
                                                           error:&error]) {
        NSLog(@"Unresolved Core Data error with persistentStoreCoordinator: %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    if ([self persistentStoreCoordinator]) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    }
    
    return _managedObjectContext;
}

- (BOOL)saveChanges {
    
    NSError *error = nil;
    BOOL saveSuccessful = [_managedObjectContext save:&error];
    if (!saveSuccessful) {
        NSLog(@"An error occurred while saving data. Error: %@", [error localizedDescription]);
         NSLog(@"An error occurred while saving data. Error: %@", [error userInfo]);
        [self showMessage:@"Error while saving" message:[error localizedDescription]];
    }
    return saveSuccessful;
}


-(NSString *) getDeviceID
{
    NSString *deviceID =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] ;
    NSString *versionNumber = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *info = [NSString stringWithFormat:@"DeviceID:%@\n\nVersion:%@",deviceID,versionNumber ];
    return info;
}



@end
