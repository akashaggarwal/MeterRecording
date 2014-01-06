//
//  Session.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 1/6/14.
//  Copyright (c) 2014 Akash Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Schedule;

@interface Session : NSManagedObject

@property (nonatomic, retain) NSString * installerID;
@property (nonatomic, retain) NSString * lastDateTime;
@property (nonatomic, retain) NSString * sessionID;
@property (nonatomic, retain) NSOrderedSet *schedules;
@end

@interface Session (CoreDataGeneratedAccessors)

- (void)insertObject:(Schedule *)value inSchedulesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSchedulesAtIndex:(NSUInteger)idx;
- (void)insertSchedules:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSchedulesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSchedulesAtIndex:(NSUInteger)idx withObject:(Schedule *)value;
- (void)replaceSchedulesAtIndexes:(NSIndexSet *)indexes withSchedules:(NSArray *)values;
- (void)addSchedulesObject:(Schedule *)value;
- (void)removeSchedulesObject:(Schedule *)value;
- (void)addSchedules:(NSOrderedSet *)values;
- (void)removeSchedules:(NSOrderedSet *)values;
@end
