//
//  MeterApiClient.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 12/17/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "MeterApiClient.h"
#import "AFNetworking.h"

//#define MetersAPIBaseURLString @"http://cincywebmobilesolutions.cloudapp.net/api"
#define MetersAPIBaseURLString @"https://workorders.neptuneequipment.com/api"

#define MetersAPIToken @"1234abcd"

@implementation MeterApiClient

+ (id)sharedInstance {
    static MeterApiClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[MeterApiClient alloc] initWithBaseURL:[NSURL URLWithString:MetersAPIBaseURLString]];
    });
    
    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        //custom settings
        [self setDefaultHeader:@"x-api-token" value:MetersAPIToken];
     //   #ifdef DEBUG
           self.allowsInvalidSSLCertificate = true ;
     //   #endif
        [self setDefaultHeader:@"Accept" value:@"application/json"];
         [self setDefaultHeader:@"Accept-Charset" value:@"utf-8"];
       // [self setDefaultHeader:@"Accept-Encoding" value:nil];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
    }
    
    return self;
}

@end