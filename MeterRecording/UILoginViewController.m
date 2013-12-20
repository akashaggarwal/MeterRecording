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

@implementation UILoginViewController

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

-(IBAction)closeKeyboard:(id)sender
{
    
    [self.txtInstallerID resignFirstResponder];
    
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   if ([[segue identifier] isEqualToString:@"Login"]) {
       NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"1234", @"deviceid",
                               @"1", @"installerid",
                               nil];
       if (self.content.session == nil)
       {
           NSLog(@" null session so fetching data ");
           

       [[MeterApiClient sharedInstance] getPath:@"schedule" parameters:params
                                        success:^(AFHTTPRequestOperation *operation, id response) {
                                            NSLog(@"Response: %@", response);
                                            NSMutableArray *results = [NSMutableArray array];
                                            
                                            
                                            NSManagedObjectContext *context = [[AppContent  sharedContent] managedObjectContext];
                                            Session *currentSession = self.content.session;

                                            currentSession = (Session *)[NSEntityDescription insertNewObjectForEntityForName:@"Session"
                                                                                                inManagedObjectContext:context];
                                            
                                            currentSession.installerID = @"1";
                                            currentSession.lastDateTime = [NSDate date];
//                                            NSError *error = nil;
//                                            if ([context save:&error])
//                                                NSLog(@" saved successfullly %@", error);
//                                            else
//                                                NSLog(@" saved with error object %@", error);
//

                                            
                                            
                                            for (id schedule in response) {
                                                Schedule *s = (Schedule *)[NSEntityDescription insertNewObjectForEntityForName:@"Schedule"
                                                                                                inManagedObjectContext:context];
                                                s.accountNumber = [schedule valueForKey:@"accountnumber"];
                                                NSLog(@" acct # %@", s.accountNumber);

                                                [currentSession addSchedulesObject:s];
//                                                [results addObject:beer];
//                                                [beer release];
                                            }
                                            NSError *error = nil;
                                            if ([context save:&error])
                                              NSLog(@" saved successfullly %@", error);
                                            else
                                                NSLog(@" saved with error object %@", error);
                                            
//                                            self.results = results;
//                                            [self.tableView reloadData];
                                        }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            NSLog(@"Error fetching schedules!");
                                            NSLog(@"%@", error);
                                            
                                        }];
       
       
       }
       
       else
       {
             NSLog(@"  session already there so fetching data ",[[self.content.session schedules] count]);
       }
       
       [TestFlight addCustomEnvironmentInformation:self.content.session.installerID forKey:@"instllerid"];

   }
}


@end
