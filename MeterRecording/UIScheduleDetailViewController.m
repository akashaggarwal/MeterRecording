//
//  UIScheduleDetailViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "UIScheduleDetailViewController.h"
#import "TestFlight.h"
#import "UIOldMeterViewController.h"

@interface UIScheduleDetailViewController ()

@end

@implementation UIScheduleDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self resetlabels];
     self.currentclaim = [MyClaim sharedContent];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.currentclaim != nil)
    {
        
        [self.name setText:[self.currentclaim.claim name]];
        [self.address setText:[self.currentclaim.claim  address]];
        [self.city setText:[self.currentclaim.claim  city]];
        [self.phone setText:[self.currentclaim.claim  phone]];
        [self.altphone setText:[self.currentclaim.claim  altphone]];
        [self.route setText:[self.currentclaim.claim  route]];
        [self.schdate setText:[self.currentclaim.claim  scheduleDate]];
        [self.schtime setText:[self.currentclaim.claim scheduleTime]];
        [self.oldsize setText:self.currentclaim.claim.oldSerial ];
        [self.oldsize setText:[self.currentclaim.claim  oldSize]];
        [self.ordertype setText:[self.currentclaim.claim  orderType]];
        [self.note setText:[self.currentclaim.claim  note]];
        
        
    }
}

-(void) resetlabels
{
    [self.name setText:@""];
    [self.address setText:@""];
    [self.city setText:@""];
    [self.phone setText:@""];
    [self.altphone setText:@""];
    [self.route setText:@""];
    [self.schdate setText:@""];
    [self.schtime setText:@""];
    [self.oldserial setText:@""];
    [self.oldsize setText:@""];
    [self.ordertype setText:@""];
    [self.note setText:@""];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     if ([[segue identifier] isEqualToString:@"CaptureData"])
     {
         
//         UIOldMeterViewController *oldViewController = (UITabBarController *)[[segue.destinationViewController viewControllers] objectAtIndex:0];
//         oldViewController.currentclaim = self.currentclaim;
     }
}



- (IBAction)JobSkipped:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload to server?" message:@"Do you really want to skip this job?" delegate:self    cancelButtonTitle:@"Cancel"   otherButtonTitles:nil];
     [alert addButtonWithTitle:@"OK"];
    // optional - add more buttons:
       [alert show];
    
    [TestFlight passCheckpoint:@"JOB SKIPPED"];
}

- (IBAction)JobCompleted:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload to server?" message:@"Do you really want to complete this job?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
     [alert addButtonWithTitle:@"Yes"];
    // optional - add more buttons:
    [alert show];
    
    [TestFlight passCheckpoint:@"JOB SUBMITTED"];
}
@end
