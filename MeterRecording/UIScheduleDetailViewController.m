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
#import "ImageStore.h"
#import "MeterApiClient.h"
#import "AFNetworking.h"
#import "BLProgressView.h"
#import "SVProgressHUD.h"


@interface UIScheduleDetailViewController ()

@end

@implementation UIScheduleDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initializationdevelo
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.content = [AppContent sharedContent];
    [self resetlabels];
   
}
-(void) viewDidAppear:(BOOL)animated
{
    
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
        [self.newserial setText:[self.currentclaim.claim newserial]];
        [self.oldserial setText:[self.currentclaim.claim oldSerial]];
        [self.newsize setText:[self.currentclaim.claim newsize]];
        [self.oldsize setText:[self.currentclaim.claim oldSize]];
        NSString *imageKey = self.currentclaim.claim.oldphotofilepath;
        if (imageKey)
        {
            UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
            [self.imgViewOldPhoto setImage:imageToDisplay];
        }
        imageKey = self.currentclaim.claim.newphotofilepath;
        if (imageKey)
        {
            UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
            [self.imgViewNewPhoto setImage:imageToDisplay];
        }
        imageKey = self.currentclaim.claim.signaturefilepath;
        if (imageKey)
        {
            UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
            [self.imgViewSignature setImage:imageToDisplay];
        }
        [self updateClaimStatusLabel];
    }
    
}

-(void) updateClaimStatusLabel
{
    if ([self.currentclaim.claim.localschedulestatus isEqualToString:CLAIM_QUEUED])
        [self.claimStatus setText:@"Your work order is in queued status , you must submit it again when internet connection is available"];
    
    if ([self.currentclaim.claim.localschedulestatus isEqualToString:CLAIM_COMPLETED])
    {
        NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterShortStyle];
        [self.claimStatus setText:[NSString stringWithFormat:@"Your work order was submitted to server at %@",dateString]];
        
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
    [self.claimStatus setText:@""];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


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

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.view endEditing:YES];
    

    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"SKIP"])
    {
       
        NSLog(@"Skipped.");
        [self queueLocal];
        self.currentclaim.submitType = @"S";
          NSLog(@"QUEUED LOCALLY");
        [self uploadtoServer:@"S"];
        
//        [self updateLocal];
//        NSLog(@"UPDATED LOCAL DB AS COMPLETE");

       // [TestFlight passCheckpoint:@"JOB SKIPPED"];
        
        
    }
    else if([title isEqualToString:@"COMPLETE"])
    {
    self.currentclaim.submitType = @"C";
        [self queueLocal];
            NSLog(@"QUEUED LOCALLY");
         [self uploadtoServer:@"C"];
        
//          [self updateLocal];
//          NSLog(@"UPDATED LOCAL DB AS COMPLETE");
       // [TestFlight passCheckpoint:@"JOB COMPLETE"];
        
    }
    else
    {
        NSLog(@"Cancelled");
    }
}

-(void) queueLocal
{
    Schedule *category1 = nil;
    NSManagedObjectContext *context = [self.content managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_SCHEDULE
                                              inManagedObjectContext:context];
    request.entity = entity;
    //self.currentclaim = [MyClaim sharedContent];
    
    // not using and LocalScheduleStatus because they could update completed claim too
    NSPredicate *p = [NSPredicate predicateWithFormat:@"scheduleID == %@ AND installerID == %@ AND localschedulestatus == %@",self.currentclaim.claim.scheduleID, self.currentclaim.claim.installerID, self.currentclaim.claim.localschedulestatus];
    
    
   // NSPredicate *p = [NSPredicate predicateWithFormat:@"scheduleID == %@ AND installerID == %@ AND localschedulestatus == 'Q'",self.currentclaim.claim.scheduleID, self.currentclaim.claim.installerID];
        request.predicate = p;
    NSError *err = nil;
    NSArray *listOfObjects = [context executeFetchRequest:request
                                                    error:&err];
    NSLog(@"errors are %@",[err localizedDescription]);
    // if no records queued or
    if (listOfObjects == nil || [listOfObjects count] == 0 )
    {
        NSLog(@"no queued claims ");
        category1 = (Schedule *)[NSEntityDescription insertNewObjectForEntityForName:ENTITY_SCHEDULE
                                                                   inManagedObjectContext:context];
        category1.accountNumber = self.currentclaim.claim.accountNumber;
        category1.scheduleID= self.currentclaim.claim.scheduleID;
        category1.scheduleDate= self.currentclaim.claim.scheduleDate;
        category1.scheduleTime= self.currentclaim.claim.scheduleTime;
        category1.claiminsertdatetime = [NSDate date];
        category1.claimupdatedatetime = [NSDate date];
        category1.localschedulestatus = CLAIM_QUEUED;
        category1.name = self.currentclaim.claim.name;
        category1.installerID = [self.content installerID];
        bool b = [self.content saveChanges];
        if (b)
            NSLog(@"Schedule has been saved locally");
    }
    else if ( [listOfObjects count] == 1)
    {
        
        category1 = [listOfObjects lastObject];
        NSLog(@" local status of existing claim found is %@", [category1 localschedulestatus]);
        category1.accountNumber = self.currentclaim.claim.accountNumber;
        category1.scheduleID= self.currentclaim.claim.scheduleID;
        category1.scheduleDate= self.currentclaim.claim.scheduleDate;
        category1.scheduleTime= self.currentclaim.claim.scheduleTime;
        category1.claiminsertdatetime = [NSDate date];
        category1.claimupdatedatetime = [NSDate date];
        category1.localschedulestatus = CLAIM_QUEUED;
        category1.name = self.currentclaim.claim.name;
        category1.installerID = [self.content installerID];
        bool b = [self.content saveChanges];
        if (b)
            NSLog(@"Schedule has been saved locally");
        
        
    }
    else
    {
        
        NSLog(@" should not have come here , multiple records found, investigate issue");
        abort();
    }
    
    
    


    
}

-(void) updateLocal
{
    Schedule *category1 = nil;
    NSManagedObjectContext *context = [self.content managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:ENTITY_SCHEDULE
                                              inManagedObjectContext:context];
    request.entity = entity;
    //self.currentclaim = [MyClaim sharedContent];
    NSPredicate *p = [NSPredicate predicateWithFormat:@"scheduleID == %@ AND installerID == %@ AND localschedulestatus == %@",self.currentclaim.claim.scheduleID, self.currentclaim.claim.installerID, CLAIM_QUEUED];
    
    // NSPredicate *p = [NSPredicate predicateWithFormat:@"installerID contains %@ AND lastDateTime contains '%@'", self.installerID, currentDate];
    //A
    request.predicate = p;
    NSError *err = nil;
    NSArray *listOfObjects = [context executeFetchRequest:request
                                                    error:&err];
    NSLog(@"errors are %@",[err localizedDescription]);
    if (listOfObjects == nil)
    {
        NSLog(@"no queued work orders this should not have happened because local record should have been created");
        abort();
    }
    else
    {
        category1 = [listOfObjects lastObject];
        category1.localschedulestatus = CLAIM_COMPLETED;
        category1.claimupdatedatetime = [NSDate date];
        bool b = [self.content saveChanges];
        if (b)
            NSLog(@"Schedule has been saved locally");
        
    }

    
    
}
-(void) uploadtoServer: (NSString *) submitType
{
    
    [SVProgressHUD  showWithStatus:@"Uploading data to server, Please wait depending on size of images and network connectivity this might take a minute or two"];
      BLProgressView *progressView = [BLProgressView presentInWindow:self.view.window];
   // self.currentclaim.claim.submittype = submitType;
    
    // save it
    [self.currentclaim saveWithProgress:^(CGFloat progress) {
        [progressView setProgress:progress];
    } completion:^(BOOL success, NSError *error) {
        [progressView dismiss];
        [SVProgressHUD  dismiss];
        if (success) {
            [self updateLocal];
            [self.content showMessage:@"Success" message:@"Your data has been successfully uploaded"];
            [TestFlight passCheckpoint:@"JOB SUBMITTED"];
                       //[self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"ERROR: %@", error);
            NSString *message = [NSString stringWithFormat:@"Your data could not be uploaded to server because of the error->\n %@ \n The data has been QUEUED locally and please try at later time. You can go back to Schedules and resubmit the QUEUED data at later time.",[error localizedDescription]];
            [self.content showMessage:@"Error" message:message];

        }
        [self updateClaimStatusLabel];
    }];

    
}
- (IBAction)JobSkipped:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload to server?" message:@"Do you really want to skip this job?" delegate:self    cancelButtonTitle:@"Cancel"   otherButtonTitles:nil];
     [alert addButtonWithTitle:@"SKIP"];
    // optional - add more buttons:
       [alert show];
    
    
}

- (IBAction)JobCompleted:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload to server?" message:@"Do you really want to complete this job?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
     [alert addButtonWithTitle:@"COMPLETE"];
    // optional - add more buttons:
    [alert show];
    
    //[TestFlight passCheckpoint:@"JOB SUBMITTED"];
}
@end
