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

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"SKIP"])
    {
        NSLog(@"Skipped.");
        
        [self queueLocal];
        [self uploadtoServer];
        [TestFlight passCheckpoint:@"JOB SKIPPED"];
        
        
    }
    else if([title isEqualToString:@"COMPLETE"])
    {
        NSLog(@"COMPLETE");
        [self queueLocal];
        
        [TestFlight passCheckpoint:@"JOB COMPLETE"];
        
    }
    else
    {
        NSLog(@"Cancelled");
    }
}

-(void) queueLocal
{
    ScheduleClaim *category1 = nil;
    NSManagedObjectContext *context = [self.content managedObjectContext];
    category1 = (ScheduleClaim *)[NSEntityDescription insertNewObjectForEntityForName:@"ScheduleClaim"
                                                               inManagedObjectContext:context];
    category1.accountNumber = self.currentclaim.claim.accountNumber;
    category1.scheduleID= self.currentclaim.claim.scheduleID;
    category1.scheduleDate= self.currentclaim.claim.scheduleDate;
    category1.scheduleTime= self.currentclaim.claim.scheduleTime;
    category1.claiminsertdatetime = [NSDate date];
    category1.localschedulestatus = @"Q";
    category1.name = self.currentclaim.claim.name;
    category1.installerID = [self.content installerID];
    bool b = [self.content saveChanges];
    if (b)
        NSLog(@"ScheduleClaim has been saved locally");

    
}

-(void) uploadtoServer
{
    //make sure none of the parameters are nil, otherwise it will mess up our dictionary
//    if (!self.currentclaim.claim.accountNumber) self.currentclaim.claim.accountNumber = @"";
//    
//   
//    if (!self.currentclaim.claim.address) self.currentclaim.claim.address = @"";
//    if (!self.currentclaim.claim.altphone ) self.currentclaim.claim.altphone = @"";
//    if (!self.currentclaim.claim.city) self.currentclaim.claim.city = @"";
// 
//    if (!self.currentclaim.claim.latitude) self.currentclaim.claim.latitude = @"";
//    if (!self.currentclaim.claim.longitude) self.currentclaim.claim.longitude = @"";
//    if (!self.currentclaim.claim.name) self.currentclaim.claim.name = @"";
//    if (!self.currentclaim.claim.newreading) self.currentclaim.claim.newreading = @"";
//    if (!self.currentclaim.claim.newremoteid) self.currentclaim.claim.newremoteid = @"";
//    if (!self.currentclaim.claim.newserial) self.currentclaim.claim.newserial = @"";
//    if (!self.currentclaim.claim.newsize) self.currentclaim.claim.newsize = @"";
//    if (!self.currentclaim.claim.note) self.currentclaim.claim.note = @"";
//    if (!self.currentclaim.claim.oldSerial) self.currentclaim.claim.oldSerial = @"";
//    if (!self.currentclaim.claim.oldSize) self.currentclaim.claim.oldSize = @"";
//    if (!self.currentclaim.claim.orderType) self.currentclaim.claim.orderType = @"";
//    if (!self.currentclaim.claim.phone) self.currentclaim.claim.phone = @"";
//  
//    if (!self.currentclaim.claim.plumbingtime) self.currentclaim.claim.plumbingtime = @"";
//    if (!self.currentclaim.claim.prevRead) self.currentclaim.claim.prevRead = @"";
//    if (!self.currentclaim.claim.route) self.currentclaim.claim.route = @"";
//   
    
    
//    NSDictionary *params = @{
//                             @"deviceid" : @"1234"
//                             };
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"1234",        @"deviceid", nil];

    NSData *oldphotodata = nil;
    NSData *newphotodata = nil;
    NSData *photo3photodata = nil;
    NSData *signaturedata = nil;

    NSString *imageKey = self.currentclaim.claim.oldphotofilepath;
        if (imageKey) {
            UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
            oldphotodata = UIImageJPEGRepresentation(imageToDisplay, 1);
    }
    imageKey = self.currentclaim.claim.newphotofilepath;
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
        newphotodata = UIImageJPEGRepresentation(imageToDisplay, 1);
    }
    imageKey = self.currentclaim.claim.photo3filepath;
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
        photo3photodata = UIImageJPEGRepresentation(imageToDisplay, 1);
    }
    imageKey = self.currentclaim.claim.signaturefilepath;
    if (imageKey) {
        UIImage *imageToDisplay = [[ImageStore sharedStore] imageForKey:imageKey];
        signaturedata = UIImageJPEGRepresentation(imageToDisplay, 1);
    }
    
    NSURLRequest *postRequest = [[MeterApiClient sharedInstance] multipartFormRequestWithMethod:@"post"
                                                                                      path:@"WorkOrder"
                                                                                parameters:params
                                                                 constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
   
               // [formData appendPartWithFileData:oldphotodata name:@"OldPhoto" fileName:@"oldphoto.jpg" mimeType:@"image/jpeg"];
            //    [formData appendPartWithFileData:oldphotodata name:@"NewPhoto" fileName:@"newphoto.jpg" mimeType:@"image/jpeg"];
              //  [formData appendPartWithFileData:oldphotodata name:@"Photo3" fileName:@"photo3.jpg" mimeType:@"image/jpeg"];
              //  [formData appendPartWithFileData:oldphotodata name:@"Signature" fileName:@"signature.jpg" mimeType:@"image/jpeg"];
                [formData appendPartWithFormData:[@"1234" dataUsingEncoding:NSUTF8StringEncoding] name:@"DeviceID"];
              //  [formData appendPartWithFormData:self.currentclaim.claim.installerID name:@"InstallerID"];
                                                                     
                                                                     
                                                                 }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:postRequest];
     [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        //CGFloat progress = ((CGFloat)totalBytesWritten) / totalBytesExpectedToWrite;
        //progressBlock(progress);
          NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSLog(@"Created, %@", responseObject);
        if (operation.response.statusCode == 200 || operation.response.statusCode == 201) {
            NSLog(@"Created, %@", responseObject);
           // NSDictionary *updatedLatte = [responseObject objectForKey:@"latte"];
            //[self updateFromJSON:updatedLatte];
            //[self notifyCreated];
            //completionBlock(YES, nil);
        } else {
           // completionBlock(NO, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //completionBlock(NO, error);
         NSLog(@"Created, %@", error);
         NSLog(@"Created, %@", [error userInfo]);
    }];
   // operation.SSLPinningMode = AFSSLPinningModeNone;
    
    //operation.securityPolicy.allowInvalidCertificates = YES;
   // [operation start];
    [[MeterApiClient sharedInstance] enqueueHTTPRequestOperation:operation];
    
    
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
    
    [TestFlight passCheckpoint:@"JOB SUBMITTED"];
}
@end
