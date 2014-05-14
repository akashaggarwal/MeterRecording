//
//  MyClaim.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 12/28/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "MyClaim.h"
#import "Schedule.h"
#import "ImageStore.h"
#import "MeterApiClient.h"
#import "AFNetworking.h"
#import "AppContent.h"
#import "MyNotification.h"
@implementation MyClaim

static MyClaim *singletonInstance = nil;
Schedule *_claim;


+ (MyClaim *)sharedContent{
    @synchronized(self){
        if (singletonInstance == nil)
        {
            singletonInstance = [[self alloc] init];
            //singletonInstance.claim = [[ScheduleClaim alloc] init];
            
            NSLog(@"creating myClaim");
            
        }
        return(singletonInstance);
    }
}

//-(void) resetClaim
//{
//    singletonInstance = nil;
//    _claim = [[ScheduleClaim alloc] init];
//}
- (void)saveWithCompletion:(void (^)(BOOL success, NSError *error))completionBlock {
    [self saveWithProgress:nil completion:completionBlock];
}

- (void)saveWithProgress:(void (^)(CGFloat progress))progressBlock completion:(void (^)(BOOL success, NSError *error))completionBlock {
    
    //make sure none of the parameters are nil, otherwise it will mess up our dictionary
    if (!self.claim.accountNumber) self.claim.accountNumber = @"";
    
    
    if (!self.claim.address) self.claim.address = @"";
    if (!self.claim.altphone ) self.claim.altphone = @"";
    if (!self.claim.city) self.claim.city = @"";
    
    //if (!self.currentclaim.claim.latitude) self.currentclaim.claim.latitude = @"";
    //if (!self.currentclaim.claim.longitude) self.currentclaim.claim.longitude = @"";
    if (!self.claim.name) self.claim.name = @"";
    if (!self.claim.newreading) self.claim.newreading = @"";
    if (!self.claim.newremoteid) self.claim.newremoteid = @"";
    if (!self.claim.newserial) self.claim.newserial = @"";
    if (!self.claim.newsize) self.claim.newsize = @"";
    if (!self.claim.note) self.claim.note = @"";
    if (!self.claim.oldSerial) self.claim.oldSerial = @"";
    if (!self.claim.oldSize) self.claim.oldSize = @"";
    if (!self.claim.orderType) self.claim.orderType = @"";
    if (!self.claim.phone) self.claim.phone = @"";
    
    if (!self.claim.plumbingtime) self.claim.plumbingtime = @"";
     if (!self.claim.wiringtime) self.claim.wiringtime = @"";
    if (!self.claim.prevRead) self.claim.prevRead = @"";
    if (!self.claim.route) self.claim.route = @"";
    
      NSString *deviceID = [[AppContent sharedContent] getDeviceID];
    
    NSLog(@"**** Logging the data STARTS**** ");
    NSLog(@"new serial ->%@",self.claim.newserial);
     NSLog(@"old serial ->%@",self.claim.oldSerial);
    NSLog(@"new size ->%@",self.claim.newsize);
  
   
    NSLog(@"old size ->%@",self.claim.oldSize);
      NSLog(@"plumbing time->%@",self.claim.plumbingtime);
     NSLog(@"wiring time->%@",self.claim.wiringtime);
  
    
    NSLog(@"prev reading  ->%@",self.claim.prevRead);
    NSLog(@"new reading->%@",self.claim.newreading);


    
    NSLog(@"old photo ->%@",self.claim.oldphotofilepath);
    NSLog(@"new photo ->%@",self.claim.newphotofilepath);
    NSLog(@"photo 3 ->%@",self.claim.photo3filepath);
    NSLog(@"photo 4 ->%@",self.claim.photo4filepath);

    NSLog(@"photo 5 ->%@",self.claim.photo5filepath);

    NSLog(@"signature ->%@",self.claim.signaturefilepath);
     NSLog(@"notes ->%@",self.claim.note);
    NSLog(@"device id ->%@",deviceID);
    NSLog(@"**** Logging the data ENDS**** ");
    

    
    NSData *oldphotodata = nil;
    NSData *newphotodata = nil;
    NSData *photo3photodata = nil;
    NSData *photo4photodata = nil;
    NSData *photo5photodata = nil;
    NSData *signaturedata = nil;
    
    NSString *imageKey = self.claim.oldphotofilepath;
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
        oldphotodata = UIImageJPEGRepresentation(imageToDisplay, 0.2);
    }
    imageKey = self.claim.newphotofilepath;
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
        newphotodata = UIImageJPEGRepresentation(imageToDisplay, 0.2);
    }
    imageKey = self.claim.photo3filepath;
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
        photo3photodata = UIImageJPEGRepresentation(imageToDisplay, 0.2);
    }
    imageKey = self.claim.photo4filepath;
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
        photo4photodata = UIImageJPEGRepresentation(imageToDisplay, 0.2);
    }
    imageKey = self.claim.photo5filepath;
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
        photo5photodata = UIImageJPEGRepresentation(imageToDisplay, 0.2);
    }
    imageKey = self.claim.signaturefilepath;
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
        signaturedata = UIImageJPEGRepresentation(imageToDisplay, 0.2);
    }
    
  
    NSURLRequest *postRequest = [[MeterApiClient sharedInstance] multipartFormRequestWithMethod:@"post"
                                                                                           path:@"WorkOrder"
                                                                                     parameters:nil
                                                                      constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                          
                                                                          if (self.claim.oldphotofilepath)
                                                                              [formData appendPartWithFileData:oldphotodata name:@"OldPhoto" fileName:self.claim.oldphotofilepath mimeType:@"image/jpeg"];
                                                                          if (self.claim.newphotofilepath)
                                                                              [formData appendPartWithFileData:newphotodata name:@"NewPhoto" fileName:self.claim.newphotofilepath mimeType:@"image/jpeg"];
                                                                          if (self.claim.photo3filepath)
                                                                              [formData appendPartWithFileData:photo3photodata name:@"Photo3" fileName:self.claim.photo3filepath mimeType:@"image/jpeg"];
                                                                          if (self.claim.photo4filepath)
                                                                              [formData appendPartWithFileData:photo4photodata name:@"Photo4" fileName:self.claim.photo4filepath mimeType:@"image/jpeg"];
                                                                          if (self.claim.photo5filepath)
                                                                              [formData appendPartWithFileData:photo5photodata name:@"Photo5" fileName:self.claim.photo5filepath mimeType:@"image/jpeg"];
                                                                          if (self.claim.signaturefilepath)
                                                                              [formData appendPartWithFileData:signaturedata name:@"Sig1" fileName:self.claim.signaturefilepath mimeType:@"image/jpeg"];
                                                                          
                                                                          
                                                                          [formData appendPartWithFormData:[deviceID dataUsingEncoding:NSUTF8StringEncoding] name:@"DeviceID"];
                                                                          [formData appendPartWithFormData:[self.claim.scheduleID dataUsingEncoding:NSUTF8StringEncoding] name:@"ScheduleID"];
                                                                         
                                                                          [formData appendPartWithFormData:[self.claim.installerID dataUsingEncoding:NSUTF8StringEncoding] name:@"installerID"];
                                                                          [formData appendPartWithFormData:[self.claim.newserial dataUsingEncoding:NSUTF8StringEncoding] name:@"NewSerial"];
                                                                          [formData appendPartWithFormData:[self.claim.oldSerial dataUsingEncoding:NSUTF8StringEncoding] name:@"CorrectSerial"];
                                                                          [formData appendPartWithFormData:[self.claim.prevRead dataUsingEncoding:NSUTF8StringEncoding] name:@"PrevRead"];
                                                                          //[formData appendPartWithFormData:[self.currentclaim.claim.o dataUsingEncoding:NSUTF8StringEncoding] name:@"OldRead"];
                                                                          [formData appendPartWithFormData:[self.claim.newreading dataUsingEncoding:NSUTF8StringEncoding] name:@"NewRead"];
                                                                          //[formData appendPartWithFormData:[self.currentclaim.claim dataUsingEncoding:NSUTF8StringEncoding] name:@"AltRead"];
                                                                          [formData appendPartWithFormData:[self.claim.plumbingtime dataUsingEncoding:NSUTF8StringEncoding] name:@"PlumbingTime"];
                                                                          [formData appendPartWithFormData:[self.claim.wiringtime dataUsingEncoding:NSUTF8StringEncoding] name:@"WiringTime"];
                                                                          [formData appendPartWithFormData:[self.claim.oldSize dataUsingEncoding:NSUTF8StringEncoding] name:@"OldSize"];
                                                                          [formData appendPartWithFormData:[self.claim.newsize dataUsingEncoding:NSUTF8StringEncoding] name:@"NewSize"];
                                                                          //[formData appendPartWithFormData:[@"1234" dataUsingEncoding:NSUTF8StringEncoding] name:@"SkipReason"];
                                                                          [formData appendPartWithFormData:[self.claim.newremoteid dataUsingEncoding:NSUTF8StringEncoding] name:@"NewRemoteID"];
                                                                           [formData appendPartWithFormData:[self.claim.note dataUsingEncoding:NSUTF8StringEncoding] name:@"Notes"];
                                                                          NSLog(@"submission type was %@", self.submitType);
                                                                          if ([self.submitType isEqualToString:@"S"])
                                                                          {
                                                                              [formData appendPartWithFormData:[@"0" dataUsingEncoding:NSUTF8StringEncoding] name:@"JobComplete"];
                                                                              [formData appendPartWithFormData:[@"1" dataUsingEncoding:NSUTF8StringEncoding] name:@"JobSkipped"];
                                                                              
                                                                          }
                                                                          
                                                                          if ([self.submitType  isEqualToString:@"C"])
                                                                          {
                                                                              [formData appendPartWithFormData:[@"1" dataUsingEncoding:NSUTF8StringEncoding] name:@"JobComplete"];
                                                                              [formData appendPartWithFormData:[@"0" dataUsingEncoding:NSUTF8StringEncoding] name:@"JobSkipped"];
                                                                          }
                                                                          //[formData appendPartWithFormData:[@"1234" dataUsingEncoding:NSUTF8StringEncoding] name:@"CompoundMeter"];
                                                                          //[formData appendPartWithFormData:[@"1234" dataUsingEncoding:NSUTF8StringEncoding] name:@"DeviceID"];
                                                                          
                                                                          
                                                                          
                                                                          
                                                                      }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:postRequest];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat progress = ((CGFloat)totalBytesWritten) / totalBytesExpectedToWrite;
        progressBlock(progress);
        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Created, %@", responseObject);
        if (operation.response.statusCode == 200 || operation.response.statusCode == 201) {
            NSLog(@"Created, %@", responseObject);
            // NSDictionary *updatedLatte = [responseObject objectForKey:@"latte"];
            //[self updateFromJSON:updatedLatte];
            [self notifyCreated];
            completionBlock(YES, nil);
        } else {
             completionBlock(NO, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Created, %@", error);
        NSLog(@"Created, %@", [error userInfo]);
        completionBlock(NO, error);
      
    }];
    // operation.SSLPinningMode = AFSSLPinningModeNone;
    
    //operation.securityPolicy.allowInvalidCertificates = YES;
    // [operation start];
    [[MeterApiClient sharedInstance] enqueueHTTPRequestOperation:operation];
    
    
  
};

- (void)notifyCreated {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyCreatedNotification
                                                        object:self];
}


@end
