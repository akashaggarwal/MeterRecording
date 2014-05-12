//
//  UIBaseTableViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/7/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "UIBaseTableViewController.h"
#import "ZBarSDK.h"
#import "ImageStore.h"

@interface UIBaseTableViewController ()

@end

@implementation UIBaseTableViewController

//- (void)imagePickerController:(UIImagePickerController *)picker
//didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//     NSLog(@"value scanned is");
//    
////    if ([picker isKindOfClass:[ZBarReaderViewController class]])
////    {
////      
////        // ADD: get the decode results
////        id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
////        ZBarSymbol *symbol = nil;
////        for(symbol in results)
////            // EXAMPLE: just grab the first barcode
////            break;
////        NSLog(@"value scanned is %s", symbol.data);
////        // EXAMPLE: do something useful with the barcode data
////        //_txtSerial.text = symbol.data;
////
////    }
////    else
////    {
//        // Get picked image from info dictionary
//    
//        NSString *oldKey = [self imageKey];
//    
//        // Did the item already have an image?
//        if (oldKey) {
//        
//            // Delete the old image
//            [[ImageStore sharedStore] deleteImageForKey:oldKey];
//        }
//    NSLog(@" tag is %@", picker.view.tag)
//    
//        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        if (image != nil)
//        {
//            // Put that image onto the screen in our image view
//           // [self.imageView setImage:image];
//            self.imagetaken = image;
//            // Create a CFUUID object - it knows how to create unique identifier strings
//            CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
//            // Create a string from unique identifier
//            CFStringRef newUniqueIDString =
//            CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
//            // Use that unique ID to set our item's imageKey
//            NSString *key = (__bridge NSString *)newUniqueIDString;
//            [self setImageKey:key];
//            self.currentclaim.claim.oldphotofilepath = key;
//            // Store image in the BNRImageStore with this key
//            [[ImageStore sharedStore] setImage:image
//                                           forKey:key];
//            CFRelease(newUniqueIDString);
//            CFRelease(newUniqueID);
//        }
////    }
//    // Take image picker off the screen -
//    // you must call this dismiss method
//    [self dismissViewControllerAnimated:YES completion:nil];
//}




- (IBAction)takePic:(id)sender {
    
    UIImagePickerController *imagePicker =
    [[UIImagePickerController alloc] init];
  
    // If our device has a camera, we want to take a picture, otherwise, we
    // just pick from photo library
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    imagePicker.view.tag = [sender tag];
    // This line of code will generate a warning right now, ignore it
    [imagePicker setDelegate:self];
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}



- (void)scan
{
    
//    // ADD: present a barcode reader that scans from the camera feed
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
//    
    ZBarImageScanner *scanner = reader.scanner;
//    // TODO: (optional) additional reader configuration here
//    
//    // EXAMPLE: disable rarely used I2/5 to improve performance
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
//    
//    // present and release the controller
    [self presentModalViewController: reader
                            animated: YES];
    
    
}

-(void) adjustforiOS7
{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        // For insetting with a navigation bar
        UIEdgeInsets insets = UIEdgeInsetsMake(64, 0, 0, 0);
        self.tableView.contentInset = insets;
        self.tableView.scrollIndicatorInsets = insets;
    }
}
//
//- (void) imagePickerController: (UIImagePickerController*) reader
// didFinishPickingMediaWithInfo: (NSDictionary*) info
//{
//    // ADD: get the decode results
//    id<NSFastEnumeration> results =
//    [info objectForKey: ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for(symbol in results)
//        // EXAMPLE: just grab the first barcode
//        break;
//    
//    // EXAMPLE: do something useful with the barcode data
//    _txtSerial.text = symbol.data;
//    
//    // EXAMPLE: do something useful with the barcode image
//    //resultImage.image =
//    // [info objectForKey: UIImagePickerControllerOriginalImage];
//    
//    // ADD: dismiss the controller (NB dismiss from the *reader*!)
//    [reader dismissModalViewControllerAnimated: YES];
//}
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(navigationBarTap:)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
//    tapRecon.numberOfTapsRequired = 1;
//    [self.navigationController.navigationBar addGestureRecognizer:tapRecon];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)navigationBarTap:(UIGestureRecognizer*)recognizer {
    
           [self.view endEditing:YES];
  
//    for (id view in self.view.subviews) {
//        if ([view isKindOfClass:[UITextView class]] || [view isKindOfClass:[UITextField class]]) {
//            [view resignFirstResponder];
//        }
//    }
}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

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

//
//-(UIImage *) getImage:(NSString *)key
//{
//    
//    if (imageKey) {
//        // Get image for image key from image store
//        UIImage *imageToDisplay =
//        [[ImageStore sharedStore] imageForKey:imageKey];
//        
//        // Use that image to put on the screen in imageView
//        [self.imageView setImage:imageToDisplay];
//    } else {
//        // Clear the imageView
//        //[self.imageView setImage:nil];
//    }
//
//}
@end
