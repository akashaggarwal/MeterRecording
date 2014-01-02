//
//  UINewMeterViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "UINewMeterViewController.h"
#import "ImageStore.h"
@interface UINewMeterViewController ()

@end

@implementation UINewMeterViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.currentclaim = [MyClaim sharedContent];
    NSLog(@" claim name->%@", self.currentclaim.claim.name );
       NSLog(@" claim size->%@", self.currentclaim.claim.oldSize );
    if (self.currentclaim != nil)
        [self.txtNewSize setText:self.currentclaim.claim.oldSize];
}


-(void) viewDidAppear:(BOOL)animated
{
    if (self.currentclaim != nil)
    {
        self.txtNewSerial.text = self.currentclaim.claim.newserial;
        self.txtNewReading.text = self.currentclaim.claim.newreading;
        self.txtPlumbingTime.text = self.currentclaim.claim.plumbingtime;
        self.txtNewRemoteID.text = self.currentclaim.claim.newremoteid;
        self.txtNewSize.text = self.currentclaim.claim.newsize;
        
        
        NSString *imageKey = self.currentclaim.claim.newphotofilepath;
        
        if (imageKey) {
            // Get image for image key from image store
            UIImage *imageToDisplay =
            [[ImageStore sharedStore] imageForKey:imageKey];
            
            // Use that image to put on the screen in imageView
            [self.imageView setImage:imageToDisplay];
        } else {
            // Clear the imageView
            //[self.imageView setImage:nil];
        }
    }
    
}
-(void) viewWillDisappear:(BOOL)animated
{
    self.currentclaim.claim.newserial =  self.txtNewSerial.text ;
    self.currentclaim.claim.newreading= self.txtNewReading.text ;
    self.currentclaim.claim.plumbingtime=  self.txtPlumbingTime.text ;
    self.currentclaim.claim.newremoteid=  self.txtNewRemoteID.text ;
    self.currentclaim.claim.newsize =  self.txtNewSize.text ;

    
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//(void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)scanSerial:(id)sender {
    [super scan];
   // self.txtNewSerial.text = [super scannedData];
}

- (IBAction)takePicture:(id)sender {
  //  [super takePicture];
   // self.imageView.image = [super imagetaken];
    [super takePic:sender];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"value scanned is");
    
    //    if ([picker isKindOfClass:[ZBarReaderViewController class]])
    //    {
    //
    //        // ADD: get the decode results
    //        id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    //        ZBarSymbol *symbol = nil;
    //        for(symbol in results)
    //            // EXAMPLE: just grab the first barcode
    //            break;
    //        NSLog(@"value scanned is %s", symbol.data);
    //        // EXAMPLE: do something useful with the barcode data
    //        //_txtSerial.text = symbol.data;
    //
    //    }
    //    else
    //    {
    // Get picked image from info dictionary
    
    NSString *oldKey = self.currentclaim.claim.newphotofilepath;
    
    // Did the item already have an image?
    if (oldKey) {
        
        // Delete the old image
        [[ImageStore sharedStore] deleteImageForKey:oldKey];
    }
    //NSLog(@" tag is %@", picker.view.tag);
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image != nil)
    {
        // Put that image onto the screen in our image view
        // [self.imageView setImage:image];
        //self.imagetaken = image;
        // Create a CFUUID object - it knows how to create unique identifier strings
        CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
        // Create a string from unique identifier
        CFStringRef newUniqueIDString =
        CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
        // Use that unique ID to set our item's imageKey
        NSString *key = (__bridge NSString *)newUniqueIDString;
        //[self setImageKey:key];
        self.currentclaim.claim.newphotofilepath = key;
        // Store image in the BNRImageStore with this key
        [[ImageStore sharedStore] setImage:image
                                    forKey:key];
        CFRelease(newUniqueIDString);
        CFRelease(newUniqueID);
    }
    //    }
    // Take image picker off the screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
