//
//  AppDelegate.m
//  junk
//
//  Created by Akash Aggarwal on 2/5/14.
//  Copyright (c) 2014 Akash Aggarwal. All rights reserved.
//

#import "AppDelegate.h"
#import "AppContent.h"
#import <Crashlytics/Crashlytics.h>
#import "TestFlight.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"inside app delegate");
    
    AppContent *content =[[AppContent alloc] init];
    NSString *adId = [content getDeviceID];
    [self setupTestFlight:adId];

    [content purgeOldSessions];
    [content purgeOldSchedulesNotQueued];
    
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    //documentDirectory = [documentDirectory stringByAppendingPathComponent: @"/images"];
    
    //  NSString *path = [content getImagesPath];
    NSLog(@"path is %@", documentDirectory);
    NSError * err;
    NSArray *imagefiles = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:documentDirectory error:&err];
    NSLog(@"number of local images->%d",[imagefiles count]);
    
    
    
    bool queuedOrCompletedClaimsFound = [content IsCompletedOrQueuedSchedulePresent];
    
    
    
    
    
    if (!queuedOrCompletedClaimsFound)
    {
        NSLog(@"no queued or completed claims found so cleanup local folders");
        //            [[NSFileManager defaultManager] removeItemAtPath:documentDirectory
        //                                           error:NULL];
        
        for(NSString *filename in imagefiles)
        {
            
            NSLog(@"filename->%@", filename);
            
            NSRange rangeValue = [filename rangeOfString:@"neptune" options:NSCaseInsensitiveSearch];
            
            if (rangeValue.length > 0){
                
                NSLog(@"string contains neptune");
                
            }
            
            else {
                
                NSLog(@"string does not contain neptune! so deleting %@", filename);
                [[NSFileManager defaultManager]  removeItemAtPath:filename error:NULL];
                
            }
            
            
        }
        
        
        NSLog(@"local folders cleaned up successfully");
    }
    else{
        NSLog(@"there were  queued or completed claims found so NO cleanup");
    }
    // Override point for customization after application launch.
    return YES;
}

- (void)setupTestFlight:(NSString *) adId
{
   
    [TestFlight setDeviceIdentifier:adId];
    // app token
    [TestFlight takeOff:@"a6c2167c-9607-4844-b58e-72fbd5768af4"];
    [Crashlytics startWithAPIKey:@"0c962dcb4b83942d176450b83cbbc11ae08af07d"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
