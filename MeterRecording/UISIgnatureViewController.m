//
//  UISIgnatureViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "UISIgnatureViewController.h"
#import "NISignatureView.h"
#import "ImageStore.h"

@interface UISIgnatureViewController ()

@end

@implementation UISIgnatureViewController

//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentclaim = [MyClaim sharedContent];
//    EAGLContext *context = [EAGLContext currentContext];
//    self.signatureView = [[NISignatureView alloc] initWithFrame:self.view.bounds context:context];
//    self.signatureView.enableSetNeedsDisplay = NO;
//    
//    [self.view addSubview:self.signatureView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.view.backgroundColor = [UIColor colorWithRed:.20 green:.21 blue:.23 alpha:1];
	CGFloat padding = self.view.frame.size.width / 15;
	
	// Make a view for the signature
	UIView *autographView = [[UIView alloc] initWithFrame:CGRectMake(padding, 20, 280, 160)];
	
	autographView.layer.borderColor  = [UIColor blackColor].CGColor;
	autographView.layer.borderWidth  = 3;
	autographView.layer.cornerRadius = 10;
	[autographView setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:autographView];
	
	// Initialize Autograph library
	self.autograph = [T1Autograph autographWithView:autographView delegate:self];
	
	// to remove the watermark, get a license code from Ten One, and enter it here
	[self.autograph setLicenseCode:@"4fabb271f7d93f07346bd02cec7a1ebe10ab7bec"];
	
	
	
#pragma mark - ** START OF Optional Configuration **
	
	// Clips signature UIImage to the bounds of the signature capture UIView.  Default is NO
	//	[self.autograph setClipSignatureToBounds:YES];
	
	// show signature guideline.  Default is YES
	//	[self.autograph setShowGuideline:NO];
	
	// set export color.  Default is blackColor
	//	[self.autograph setStrokeColor:[UIColor darkGrayColor]];
	
	// set stroke width.  Default is 6
	//	[self.autograph setStrokeWidth:3];
	
	// set amount of stroke width reduction from velocity.  Default is 0.85
	//	[autograph setVelocityReduction:0.5];
	
	// set export size.  Default scale is 1.0
	//  [self.autograph setExportScale:0.5f];
	
	// show current date.  Default is NO
	[self.autograph setShowDate:YES];
	
	// show unique signature identifier.  Default is NO
	[self.autograph setShowHash:YES];
	
	// customize signature identifier.  Default is nil.  Use no more than 10 characters.
	//	[autograph setCustomHash:@"DocumentID"];
	
	// enable 3-finger swipe to undo.  Default is YES
	//	[autograph setSwipeToUndoEnabled:NO];
	
	
#pragma mark - ** Demo UI Setup **
	
	
	NSLog(@"Autograph SDK build number %d", [self.autograph buildNumber]);
	
	UIImage *buttonBackgroundImage = [UIImage imageNamed:@"bluebutton.png"];
	UIImage *stretchedBackground = [buttonBackgroundImage stretchableImageWithLeftCapWidth:33 topCapHeight:0];
	
	
	//	Demo buttons
	UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[clearButton setFrame:CGRectMake(padding, 190, 130, 30)];
	[clearButton setTitle:@"Clear" forState:UIControlStateNormal];
	[clearButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[clearButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
	[clearButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	[clearButton setBackgroundImage:stretchedBackground forState:UIControlStateNormal];
	[self.view addSubview:clearButton];
	
	UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[doneButton setFrame:CGRectMake(150 + padding, 190, 130, 30)];
	[doneButton setTitle:@"Done" forState:UIControlStateNormal];
	[doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[doneButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
	[doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
	[doneButton setBackgroundImage:stretchedBackground forState:UIControlStateNormal];
	[self.view addSubview:doneButton];
	
//	UIButton *showModalButton = [UIButton buttonWithType:UIButtonTypeCustom];
//	[showModalButton setFrame:CGRectMake(padding, 230, 130, 30)];
//	[showModalButton setTitle:@"Show Modal" forState:UIControlStateNormal];
//	[showModalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[showModalButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
//	[showModalButton addTarget:self action:@selector(showModalButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//	[showModalButton setBackgroundImage:stretchedBackground forState:UIControlStateNormal];
//	[self.view addSubview:showModalButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillDisappear:(BOOL)animated
{
    //NISignatureView *v = self.signatureView;
    // NISignatureView *v = (NISignatureView *)[self.view viewWithTag:500];
   // UIImage *image = [v imageRepresentation];

    
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

- (IBAction)accept:(id)sender {
    NSLog(@"inside accept");
    NISignatureView *v = (NISignatureView *)[self.view  viewWithTag:500];
   //NISignatureView *v = self.signatureView;
    UIImage *image = [v imageRepresentation];
    //image = [v myimage];
    
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
        self.currentclaim.claim.signaturefilepath = key;
        // Store image in the BNRImageStore with this key
        [[ImageStore sharedStore] setImage:image
                                    forKey:key];
        CFRelease(newUniqueIDString);
        CFRelease(newUniqueID);
        NSLog(@"key is %@", key);

    }

}

- (IBAction)clear:(id)sender {

    NSLog(@"inside clear");
    NISignatureView *v = (NISignatureView *)[self.view viewWithTag:500];
    [v erase];
}


- (IBAction)clearButtonAction:(id)sender {
	[self.autograph reset:self];
}

- (IBAction)doneButtonAction:(id)sender {
	[self.autograph done:self];
	[self.autograph reset:self];
}

- (IBAction)showModalButtonAction:(id)sender {
	// Show modal view with a message above the signature line
	self.autographModal = [T1Autograph autographWithDelegate:self modalDisplayString:@"I hereby grant ReFreshers Inc. permission to recycle the socks in my home for the next 200 years."];
	
	// Show modal view without a message above the signature line
	//	self.autographModal = [T1Autograph autographWithDelegate:self modalDisplayString:nil];
	
	// Remove the watermark
	[self.autographModal setLicenseCode:@"4fabb271f7d93f07346bd02cec7a1ebe10ab7bec"];
	
	// any optional configuration done here
	[self.autographModal setShowDate:YES];
	[self.autographModal setStrokeColor:[UIColor lightGrayColor]];
}

#pragma mark - T1Autograph Delegate Methods


- (void)autographDidCancelModalView:(T1Autograph *)autograph {
	NSLog(@"Autograph modal signature has been cancelled");
}

- (void)autographDidCompleteWithNoSignature:(T1Autograph *)autograph {
	NSLog(@"User pressed the done button without signing");
}

- (void)autograph:(T1Autograph *)autograph didEndLineWithSignaturePointCount:(NSUInteger)count {
	NSLog(@"Line ended with total signature point count of %d", count);
	
	// Note: You can use the 'count' parameter to determine if the line is substantial enough to enable the done or clear button.
}

- (void)autograph:(T1Autograph *)autograph didCompleteWithSignature:(T1Signature *)signature {
	// Log information about the signature
	NSLog(@"-- Autograph signature completed. --");
	NSLog(@"Hash value: %@", signature.hashString);
	
	// display the signature
	[self.outputImage removeFromSuperview];
	
	self.outputImage = [signature imageView];
	
	[self.outputImage setFrame:CGRectMake(self.view.frame.size.width / 15, 270, self.outputImage.frame.size.width, self.outputImage.frame.size.height)];
	
	[self.view addSubview:self.outputImage];
	
	// you can access the raw image data like this:
	 UIImage *image = [UIImage imageWithData:signature.imageData];
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
        self.currentclaim.claim.signaturefilepath = key;
        // Store image in the BNRImageStore with this key
        [[ImageStore sharedStore] setImage:image
                                    forKey:key];
        CFRelease(newUniqueIDString);
        CFRelease(newUniqueID);
        NSLog(@"key is %@", key);
        
    }

	// you can access the raw data points like this:
	// NSArray *rawPoints = signature.rawPoints;
}


@end
