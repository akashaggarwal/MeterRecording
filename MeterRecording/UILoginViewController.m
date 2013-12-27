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

@implementation UILoginViewController


BOOL successful = NO;
-(void) viewDidLoad
{
     [super viewDidLoad];
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
    [SVProgressHUD show];
    [self performLogon];

    
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

-(BOOL) performLogon
{
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
                                             //NSLog(@"Response: %@", [operation.response statusCode]);
                                             NSLog(@"SUCCESS IN FETCH");
                                             NSMutableArray *results = [NSMutableArray array];
                                             
                                             
                                             NSManagedObjectContext *context = [self.content managedObjectContext];
                                             Session *currentSession = self.content.session;;
                                             
                                             currentSession = (Session *)[NSEntityDescription insertNewObjectForEntityForName:@"Session"
                                                                                                       inManagedObjectContext:context];
                                             
                                             currentSession.installerID = [self.content installerID];
                                             currentSession.lastDateTime = [AppContent getCurrentDate];
                                             currentSession.sessionID = [AppContent GetUUID];
                                             
                                             for (id schedule in response) {
                                                 Schedule *s = (Schedule *)[NSEntityDescription insertNewObjectForEntityForName:@"Schedule"
                                                                                                         inManagedObjectContext:context];
                                                 s.address =  [schedule valueForKey:@"address"];
                                                 s.altphone =  [schedule valueForKey:@"altphone"];
                                                 s.city =  [schedule valueForKey:@"city"];
                                                 s.latitude =   [schedule valueForKey:@"latitude"];
                                                 s.longitude =   [schedule valueForKey:@"longitude"];
                                                 s.name =   [schedule valueForKey:@"name"];
                                                 s.note =  [schedule valueForKey:@"note"];
                                                 s.oldSerial =   [schedule valueForKey:@"oldSerial"];
                                                 s.oldSize =  [schedule valueForKey:@"oldSize"];
                                                 s.orderType =   [schedule valueForKey:@"orderType"];
                                                 s.phone =   [schedule valueForKey:@"phone"];
                                                 s.prevRead   = [schedule valueForKey:@"prevRead"];
                                                 s.route =   [schedule valueForKey:@"route"];
                                                 s.scheduleDate  = [schedule valueForKey:@"scheduleDate"];
                                                 s.scheduleID   = [schedule valueForKey:@"scheduleID"];
                                                 s.scheduleTime   = [schedule valueForKey:@"scheduleTime"];
                                                 s.accountNumber   = [schedule valueForKey:@"accountNumber"];
                                                 
                                                 [currentSession addSchedulesObject:s];
                                                 
                                             }
                                             
                                             NSError *error = nil;
                                             if ([context save:&error])
                                             {
                                                 successful = YES;
                                                 [SVProgressHUD dismiss];
                                                 NSLog(@" saved successfullly %@", error);
                                                 [self performSegueWithIdentifier:@"Login" sender:self];
                                             }
                                             else
                                             {
                                                 [SVProgressHUD dismiss];
                                                 [self.content showMessage:@"saveerror:" message:[error localizedDescription]];
                                              NSLog(@" saved with error object %@", error);
                                             }
                                  
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
