//
//  ScheduleClaim.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 1/2/14.
//  Copyright (c) 2014 Akash Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ScheduleClaim : NSManagedObject

@property (nonatomic, retain) NSString * accountNumber;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * altphone;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * installerID;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * localschedulestatus;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * newphotofilepath;
@property (nonatomic, retain) NSString * newreading;
@property (nonatomic, retain) NSString * newremoteid;
@property (nonatomic, retain) NSString * newserial;
@property (nonatomic, retain) NSString * newsize;
@property (nonatomic, retain) NSString * note;
@property (nonatomic, retain) NSString * oldphotofilepath;
@property (nonatomic, retain) NSString * oldSerial;
@property (nonatomic, retain) NSString * oldSize;
@property (nonatomic, retain) NSString * orderType;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * photo3filepath;
@property (nonatomic, retain) NSString * plumbingtime;
@property (nonatomic, retain) NSString * prevRead;
@property (nonatomic, retain) NSString * route;
@property (nonatomic, retain) NSString * scheduleDate;
@property (nonatomic, retain) NSString * scheduleID;
@property (nonatomic, retain) NSString * scheduleTime;
@property (nonatomic, retain) NSString * signaturefilepath;

@end
