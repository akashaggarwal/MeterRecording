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
        NSLog(@"%d schedules",[self.content.session.schedules count]);
    
  
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
       
       [[MeterApiClient sharedInstance] getPath:@"beers.json" parameters:nil
                                        success:^(AFHTTPRequestOperation *operation, id response) {
                                            NSLog(@"Response: %@", response);
//                                            NSMutableArray *results = [NSMutableArray array];
//                                            for (id beerDictionary in response) {
//                                                Beer *beer = [[Beer alloc] initWithDictionary:beerDictionary];
//                                                [results addObject:beer];
//                                                [beer release];
//                                            }
//                                            self.results = results;
//                                            [self.tableView reloadData];
                                        }
                                        failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                            NSLog(@"Error fetching schedules!");
                                            NSLog(@"%@", error);
                                            
                                        }];
       
       
       
       
       
       
       [TestFlight addCustomEnvironmentInformation:self.content.session.installerID forKey:@"instllerid"];

   }
}


@end
