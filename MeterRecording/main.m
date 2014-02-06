//
//  main.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "AppContent.h"
int main(int argc, char * argv[])
{
    @autoreleasepool {
       
        NSLog(@"inside main");
        AppContent *content =[[AppContent alloc] init];
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
        
//        Session *s = content.session;
//        s.installerID = @"1";
//        NSLog(@"session.installer id = %@ and datetime is %@", s.installerID, s.lastDateTime);
//
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
