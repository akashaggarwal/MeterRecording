//
//  UINewMeterViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "UINewMeterViewController.h"
#import "ImageStore.h"
#import "ZBarSDK.h"
#import <Crashlytics/Crashlytics.h>
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

    [super adjustforiOS7];
    // Check to see if we are running on iOS 6
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.currentclaim = [MyClaim sharedContent];
    NSLog(@" claim name->%@", self.currentclaim.claim.name );
       NSLog(@" claim size->%@", self.currentclaim.claim.oldSize );
    //[[Crashlytics sharedInstance] crash];
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
        self.txtWiringTime.text = self.currentclaim.claim.wiringtime;
        
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
    self.currentclaim.claim.wiringtime = self.txtWiringTime.text;
    
    
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
    
        if ([picker isKindOfClass:[ZBarReaderViewController class]])
        {
    //
    //        // ADD: get the decode results
            id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
            ZBarSymbol *symbol = nil;
            for(symbol in results)
    //            // EXAMPLE: just grab the first barcode
                break;
            NSLog(@"value scanned is %@", symbol.data);
            self.currentclaim.claim.newserial = symbol.data;
    //        // EXAMPLE: do something useful with the barcode data
            //_txtSerial.text = symbol.data;
    //
        }
        else
        {
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
       }
    // Take image picker off the screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
