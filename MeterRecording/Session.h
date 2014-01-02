//
//  Session.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 1/2/14.
//  Copyright (c) 2014 Akash Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ScheduleClaim;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSString * installerID;
@property (nonatomic, retain) NSString * lastDateTime;
@property (nonatomic, retain) NSString * sessionID;
@property (nonatomic, retain) NSOrderedSet *schedules;
@end

@interface Session (CoreDataGeneratedAccessors)

- (void)insertObject:(ScheduleClaim *)value inSchedulesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSchedulesAtIndex:(NSUInteger)idx;
- (void)insertSchedules:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSchedulesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSchedulesAtIndex:(NSUInteger)idx withObject:(ScheduleClaim *)value;
- (void)replaceSchedulesAtIndexes:(NSIndexSet *)indexes withSchedules:(NSArray *)values;
- (void)addSchedulesObject:(ScheduleClaim *)value;
- (void)removeSchedulesObject:(ScheduleClaim *)value;
- (void)addSchedules:(NSOrderedSet *)values;
- (void)removeSchedules:(NSOrderedSet *)values;
@end
