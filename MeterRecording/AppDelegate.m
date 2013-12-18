//
//  AppDelegate.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "AppDelegate.h"
//#import "TestFlight.h"
#import "AFNetworking.h"

@implementation AppDelegate
-(BOOL)application:(UIApplication *)applicationdidFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
   
    // start of your application:didFinishLaunchingWithOptions
    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] identifierForVendor]];
    [TestFlight takeOff:@"a6c2167c-9607-4844-b58e-72fbd5768af4"];
    return TRUE;
}

@end
