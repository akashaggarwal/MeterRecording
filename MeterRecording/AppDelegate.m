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
//#import "PonyDebugger.h"
#import "AppContent.h"

@implementation AppDelegate
-(BOOL)application:(UIApplication *)applicationdidFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
//    [s.schedules enumerateObjectsUsingBlock:^(id obj, BOOL *stop)
//    {
//        NSLog(@"  %@: %@", [obj accountNumber], [obj address]);
//     }];
    
    //[[PDDebugger defaultInstance] connectToURL:[NSURL URLWithString:@"ws://localhost:9000/device"]];
    //[[PDDebugger defaultInstance] enableNetworkTrafficDebugging];
   // [[PDDebugger defaultInstance] forwardAllNetworkTraffic];
    // start of your application:didFinishLaunchingWithOptions
    [TestFlight setDeviceIdentifier:[[UIDevice currentDevice] identifierForVendor]];
    [TestFlight takeOff:@"a6c2167c-9607-4844-b58e-72fbd5768af4"];
    return TRUE;
}

@end
