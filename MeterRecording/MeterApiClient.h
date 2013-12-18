//
//  MeterApiClient.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 12/17/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "AFHTTPClient.h"

@interface MeterApiClient : AFHTTPClient

+ (id)sharedInstance;

@end
