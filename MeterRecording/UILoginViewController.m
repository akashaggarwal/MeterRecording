//
//  UILoginViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "UILoginViewController.h"
#import "Schedule.h"
#import "UIScheduleViewController.h"
#import "TestFlight.h"
#import "MeterApiClient.h"
#import "SVProgressHUD.h"
#import <AFHTTPRequestOperationLogger.h>



@implementation UILoginViewController


BOOL successful = NO;
-(void) viewDidLoad
{
     [super viewDidLoad];
    [self.imgHeader setUserInteractionEnabled:YES];
   // UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showDeviceID:)];
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showDeviceID:)];
    [recognizer setNumberOfTouchesRequired:1];
   
    [self.imgHeader addGestureRecognizer:recognizer];
    
    
    [[AFHTTPRequestOperationLogger sharedLogger] startLogging];
    NSString *adId = [self.content getDeviceID];
    [TestFlight setDeviceIdentifier:adId];
    [TestFlight takeOff:@"a6c2167c-9607-4844-b58e-72fbd5768af4"];
    [self getDeviceSpecs];
    
    self.content = [AppContent sharedContent];
    
    self.txtInstallerID.delegate = self;
    
//       for( int i=1;i< 10;i++)
//    {
//         Schedule* s = [self getDummySchedule:i];
//        [self.content.session addSchedulesObject:s];
//    }
       // NSLog(@"%d schedules",[self.content.session.schedules count]);
    
  
//    
//    self.content.schedules = [[NSMutableArray init] alloc];
//    [self.content.schedules addObject:[self getDummySchedule:1]];
//    [self.content.schedules addObject:[self getDummySchedule:2]];
//    [self.content.schedules addObject:[self getDummySchedule:3]];
//    [self.content.schedules addObject:[self getDummySchedule:4]];
//
//    NSLog(@"%d schedules",[self.content.schedules count]);

}


-(void) getDeviceSpecs
{
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *model = [currentDevice model];
    NSString *systemVersion = [currentDevice systemVersion];
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    NSString *appVersion = [[NSBundle mainBundle]
                            objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSString *vendor = [[currentDevice identifierForVendor] UUIDString];
    NSString *adId = [self.content getDeviceID];
    NSString *deviceSpecs =
    [NSString stringWithFormat:@"%@ - %@ - %@ - %@ - %@ - %@ - %@" ,
     model, systemVersion, language, country, appVersion, vendor, adId];
    NSLog(@"Device Specs --> %@",deviceSpecs);
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//(void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (Schedule*)getDummySchedule:(int)i
{
    NSLog(@"inside getdummy schedule");
    Schedule* s1 = [[Schedule alloc]init];
    s1.name = [NSString stringWithFormat:@"John Smith %d",i];
    s1.address = [NSString stringWithFormat:@"%d Cornell Park Dr",i];
    s1.city = @"Mason";
    s1.phone = @"513550000";
    s1.scheduleDate = @"01/01/2013";
    s1.scheduleTime =  @"09:00 AM";
    return s1;
}

- (IBAction)showSchedule:(id)sender {
    NSString *installerID = [self.txtInstallerID text];
    NSLog(@"installerid is %@", installerID);
    if ([installerID length] == 0 )
    {
        [self.content  showMessage:@"error" message:@"enter id"];
        return ;
    }
    [self.content setInstallerID:installerID];
    [self.content resetSession];
    [SVProgressHUD  showWithStatus:@"Fetching Schedule"];
    [self performLogon];

    
}

- (void)showDeviceID: (UISwipeGestureRecognizer*)gestureRecognizer {
    NSLog(@"device id shown->%@", [self.content getDeviceID]);
    [self.content showHUDMessage:[self.content getDeviceID] view:self.navigationController.view];

//    MBProgressHUD *hud = [[MBProgressHUD alloc] init];
//    [hud setLabelText:[self.content getDeviceID]];
//    [hud show:true];
}

-(IBAction)closeKeyboard:(id)sender
{
    
    [self.txtInstallerID resignFirstResponder];
    
}

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
//{
//    NSString *installerID = [self.txtInstallerID text];
//    NSLog(@"installerid is %@", installerID);
//    if ([installerID length] == 0 )
//    {
//        [self.content  showMessage:@"error" message:@"enter id"];
//        return false;
//    }
//    self.content.installerID = installerID;
//    [SVProgressHUD show];
//     [self performLogon];
//    //NSLog(@"logon return value ->%@",logon);
//    // returning false since seque will be performed manually by code
//    return false;
//}
#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

-(BOOL) performLogon
{
    NSString * deviceID = [self.content getDeviceID];
    NSLog(@"your device id is %@", deviceID);
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"1234", @"deviceid",
                            [self.txtInstallerID text], @"installerid",
                            nil];
     [TestFlight addCustomEnvironmentInformation:self.content.session.installerID forKey:@"instllerid"];
    if (self.content.session == nil)
    {
        NSLog(@" null session so fetching data ");
        
        
        [[MeterApiClient sharedInstance] getPath:@"schedule" parameters:params
                                         success:^(AFHTTPRequestOperation *operation, id response) {
                                             //NSLog(@"Response: %@", response);
                                             NSLog(@"SUCCESS IN FETCH");
                                             [SVProgressHUD  showWithStatus:@"Parsing and Loading Data"];
                                             NSMutableArray *results = [NSMutableArray array];
                                             
                                             
                                             NSManagedObjectContext *context = [self.content managedObjectContext];
                                             Session *currentSession = self.content.session;;
                                             
                                             currentSession = (Session *)[NSEntityDescription insertNewObjectForEntityForName:@"Session"
                                                                                                       inManagedObjectContext:context];
                                             
                                             currentSession.installerID = [self.content installerID];
                                             currentSession.lastDateTime = [AppContent getCurrentDate];
                                             currentSession.sessionID = [AppContent GetUUID];
                                             bool bSessionFound = false;
                                             for (id schedule in response) {
                                                 Schedule *s = (Schedule *)[NSEntityDescription insertNewObjectForEntityForName:@"Schedule"
                                                      
                                                                                                         inManagedObjectContext:context];
                                                s.address =  NULL_TO_NIL([schedule valueForKey:@"Address"]) ;
                                                 s.name =   NULL_TO_NIL([schedule valueForKey:@"Name"]) ;
                                                // NSLog(@" name is %@, addres is %@", s.name, s.address);
                                                 

                                                 s.altphone =  NULL_TO_NIL([schedule valueForKey:@"AltPhone"]) ;
                                                 s.city =  NULL_TO_NIL([schedule valueForKey:@"City"]) ;
                                                 s.latitude =   NULL_TO_NIL([schedule valueForKey:@"Latitude"]) ;
                                                 s.longitude =   NULL_TO_NIL([schedule valueForKey:@"Longitude"]) ;
                                                 s.note =  NULL_TO_NIL([schedule valueForKey:@"Note"]) ;
                                                 s.oldSerial =   [NULL_TO_NIL([schedule valueForKey:@"OldSerial"]) stringValue];
                                                 s.oldSize = NULL_TO_NIL([schedule valueForKey:@"OldSize"]) ;
                                                 s.orderType =   NULL_TO_NIL([schedule valueForKey:@"OrderType"]) ;
                                                 s.phone =   NULL_TO_NIL([schedule valueForKey:@"Phone"]) ;
                                                 s.prevRead   = NULL_TO_NIL([schedule valueForKey:@"PrevRead"]);
                                                 s.route =   NULL_TO_NIL([schedule valueForKey:@"Route"]) ;
                                                 s.scheduleDate =   NULL_TO_NIL([schedule valueForKey:@"ScheduleDate"]);
                                                 s.scheduleID   = [NULL_TO_NIL([schedule valueForKey:@"ScheduleID"])  stringValue];
                                                 s.scheduleTime   = NULL_TO_NIL([schedule valueForKey:@"ScheduleTime"]) ;
                                                 s.accountNumber   = NULL_TO_NIL([schedule valueForKey:@"accountNumber"]) ;
                                                 s.installerID = [self.content installerID];
                                                 bSessionFound = true;
                                                 [currentSession addSchedulesObject:s];
                                                
                                                 
                                             }
                                             
                                             if (!bSessionFound)
                                             {
                                                 [context rollback];
                                                 [self.content showMessage:@"No Schedules Found" message:@"There are no schedules"];

                                             }
                                             else
                                             {
                                                 if ([self.content saveChanges])
                                                 {
                                                     [self performSegueWithIdentifier:@"Login" sender:self];
                                                 }
                                             }
                                             [SVProgressHUD dismiss];
                                             
                                             
//                                             NSError *error = nil;
//                                             if ([context save:&error])
//                                             {
//                                                 successful = YES;
//                                                 [SVProgressHUD dismiss];
//                                                 NSLog(@" saved successfullly %@", error);
//                                                 [self performSegueWithIdentifier:@"Login" sender:self];
//                                             }
//                                             else
//                                             {
//                                                 [SVProgressHUD dismiss];
//                                                 [self.content showMessage:@"saveerror:" message:[error localizedDescription]];
//                                              NSLog(@" saved with error object %@", error);
//                                             }
                                  
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             NSLog(@"Error fetching schedules!");
                                            NSLog(@"%@", error);
                                          [SVProgressHUD dismiss];
                                              [self.content showMessage:@"network error:" message:[error localizedDescription]];
                                             
                                         }];
        
        
    }
    
    else
    {
        successful = true;
        
        NSLog(@"  session already there so fetching data ");
          [SVProgressHUD dismiss];
        [self performSegueWithIdentifier:@"Login" sender:self];
    }
    
   
    return successful;
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"Login"]) {
      
   }
}


@end
