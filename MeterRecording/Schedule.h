//
//  Schedule.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 12/17/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Schedule : NSManagedObject

@property (nonatomic, retain) NSString * scheduleID;
@property (nonatomic, retain) NSString * accountNumber;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * route;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * altphone;
@property (nonatomic, retain) NSString * scheduleDate;
@property (nonatomic, retain) NSString * scheduleTime;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * orderType;
@property (nonatomic, retain) NSString * oldSerial;
@property (nonatomic, retain) NSString * oldSize;
@property (nonatomic, retain) NSString * prevRead;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * localscheduleStatus;

@end
