//
//  StartupViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 3/20/14.
//  Copyright (c) 2014 Akash Aggarwal. All rights reserved.
//

#import "StartupViewController.h"

#import "AppContent.h"
#import <Crashlytics/Crashlytics.h>
#import "TestFlight.h"
#import "UILoginViewController.h"

@interface UIStartupViewController ()

@end

@implementation UIStartupViewController

//@synthesize pView;
//@synthesize pLabel;

- (void)viewDidLoad
{
    //self.pView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    [super viewDidLoad];
//    self.pView.progress = 0.0;
//    self.pView.alpha = 0;
//    self.pLabel.text = @"";


    //UILoginViewController
}
-(void) viewDidAppear:(BOOL)animated
{
    NSLog(@"inside startup");
    
        // Do any additional setup after loading the view.
    
    
    
    AppContent *content =[[AppContent alloc] init];
    //NSString *adId = [content getDeviceID];
    
   
    //[self setupTestFlight:adId];
//    [self simulateSleep];
//    [self updateProgress:@"Purging old schedules" withPercent:0.2];
//   
    [content purgeOldSessions];
//     [self updateProgress:@"old schedules Purged" withPercent:0.3];
//   [self simulateSleep];

   // [self updateProgress:@"Purging old schedules not queued" withPercent:0.8];
    [content purgeOldSchedulesNotQueued];
   // [self updateProgress:@" old schedules not queued purged" withPercent:0.85];
    
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
//        [self simulateSleep];
//
//        [self updateProgress:@"cleaning local folders" withPercent:0.9];
//        
        for(NSString *filename in imagefiles)
        {
            
            NSLog(@"filename->%@", filename);
            
            NSRange rangeValue = [filename rangeOfString:@"neptune" options:NSCaseInsensitiveSearch];
            
            if (rangeValue.length > 0){
                
                NSLog(@"string contains neptune");
                
            }
            
            else {
                
                NSLog(@"string does not contain neptune! so deleting %@", filename);
                NSString *fullfilename = [documentDirectory stringByAppendingPathComponent:filename];
                
                //NSString *fullfilename = [NSString stringWithFormat:@"%@/%@",documentDirectory,filename];
                NSLog(@"full file path %@", fullfilename);
                NSError *err= nil;
                BOOL success = [[NSFileManager defaultManager]  removeItemAtPath:fullfilename error:&err];
                if (success)
                {
                    NSLog(@"deleted file successfully");
                }
                else
                {
                    NSLog(@"%@", [err localizedDescription]);
                }
                
            }
            
            
        }
        
        
        NSLog(@"local folders cleaned up successfully");
//        [self simulateSleep];
//
//        [self updateProgress:@"local folders cleaned up successfully" withPercent:0.9];
//        
    }
    else
    {
        NSLog(@"there were  queued or completed claims found so NO cleanup");
    }
//    [self simulateSleep];
//
//    [self updateProgress:@"cleanup done" withPercent:1.0];
    
    [self performSegueWithIdentifier:@"startuptologon" sender:self];
    
  

}

//-(void) simulateSleep
//{
//    //NSLog(@"before sleep");
//    //sleep(2);
//     // NSLog(@"after sleep");
//}
//-(void) updateProgress:(NSString *)t withPercent:(float)f
//{
////    NSLog(@"%f and text is %@",f,t);
////    
////           self.pView.alpha = 1;
////        //self.pView.progress = f;
////        
////        self.pLabel.text = t;
//    
//   
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
