//
//  AppContent.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "AppContent.h"
#import <CoreData/CoreData.h>

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
            
            NSLog(@"recreating the apcontent");
            
        }
        return(singletonInstance);
    }
}

-(Session*) session
{
    if(_session)
    {
        return _session;
    }
    NSString *entityName = @"Session";
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:context];
    request.entity = entity;
    NSArray *listOfObjects = [context executeFetchRequest:request
                                                    error:nil];
    if([listOfObjects count] == 1)
    {
        NSLog(@"Found a session in data store - we'll return that");
        _session = [listOfObjects lastObject];
        return _session;
    }

    NSLog(@"Nothing in data store - so we need a new Notebook");
    _session = (Session *)[NSEntityDescription insertNewObjectForEntityForName:@"Session"
                                                          inManagedObjectContext:context];
   
    _session.installerID = @"1234";
    _session.lastDateTime = [NSDate date];
    [context save:nil];
    return _session;
    
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





-(NSURL *)dataStoreURL {
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [NSURL fileURLWithPath:[docDir stringByAppendingPathComponent:@"DataStore.sql"]];
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

@end
