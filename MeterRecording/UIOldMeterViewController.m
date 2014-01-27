//
//  UIOldMeterViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "UIOldMeterViewController.h"
#import "ZBarSDK.h"
#import "ImageStore.h"
@interface UIOldMeterViewController ()

@end

@implementation UIOldMeterViewController

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
     self.currentclaim = [MyClaim sharedContent];
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewDidAppear:(BOOL)animated
{
    if (self.currentclaim != nil)
    {
        [self.txtCorrectSerial setText: self.currentclaim.claim.oldSerial ];
        [self.txtprevReading setText: self.currentclaim.claim.prevRead ];
        [self.txtOldSize setText: self.currentclaim.claim.oldSize];
        
        NSString *imageKey = self.currentclaim.claim.oldphotofilepath;
        
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
    self.currentclaim.claim.oldSerial = [self.txtCorrectSerial text];
    self.currentclaim.claim.prevRead = [self.txtprevReading text];
    self.currentclaim.claim.oldSize = [self.txtOldSize text];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//

- (IBAction)scanSerial:(id)sender {
    [super scan];
   // self.txtCorrectSerial.text = [super scannedData];
}

- (IBAction)takePicture:(id)sender {
    
//    UIImagePickerController *imagePicker =
//    [[UIImagePickerController alloc] init];
//    
//    // If our device has a camera, we want to take a picture, otherwise, we
//    // just pick from photo library
//    if ([UIImagePickerController
//         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
//    } else {
//        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//    }
//    // imagePicker.view.tag = [sender tag];
//    // This line of code will generate a warning right now, ignore it
//    [imagePicker setDelegate:self];
//    // Place image picker on the screen
//    [self presentViewController:imagePicker animated:YES completion:nil];

    [super takePic:sender];
}

//- (IBAction)takePicture:(id)sender {
//    [super takePic:sender];
//    //self.imageView.image = [super imagetaken];
//    self.currentclaim.claim.oldphotofilepath = [super imageKey];
//}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"value scanned is");
//    if(1 == 2)
//    {
    
    if ([picker isKindOfClass:[ZBarReaderViewController class]])
    {
    
    //        // ADD: get the decode results
            id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
            ZBarSymbol *symbol = nil;
            for(symbol in results)
                // EXAMPLE: just grab the first barcode
                break;
            NSLog(@"value scanned is %@", symbol.data);
            self.currentclaim.claim.oldSerial= symbol.data;
    }
    else
    {
        //Get picked image from info dictionary
    
        NSString *oldKey = self.currentclaim.claim.oldphotofilepath;
    
        // Did the item already have an image?
        if (oldKey)
        {
        
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
         key = [NSString stringWithFormat:@"%@_%@",self.currentclaim.claim.scheduleID , key];
        self.currentclaim.claim.oldphotofilepath = key;
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
