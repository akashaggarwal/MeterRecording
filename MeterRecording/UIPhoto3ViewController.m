//
//  UIPhoto3ViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import "UIPhoto3ViewController.h"
#import "ImageStore.h"

@interface UIPhoto3ViewController ()

@end

@implementation UIPhoto3ViewController

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
    
    self.currentclaim = [MyClaim sharedContent];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    
//    UIImage *selectedImage0 = [UIImage imageNamed:@"customIcon0_unpressed.png"];
//    UIImage *unselectedImage0 = [UIImage imageNamed:@"customIcon0_unpressed.png"];
//    
//    UIImage *selectedImage1 = [UIImage imageNamed:@"customIcon1_unpressed.png"];
//    UIImage *unselectedImage1 = [UIImage imageNamed:@"customIcon1_unpressed.png"];
//    
//    UITabBar *tabBar = self.tabBarController.tabBar;
//    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
//    
//    [item0 setFinishedSelectedImage:selectedImage0 withFinishedUnselectedImage:unselectedImage0];
//    [item1 setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:unselectedImage1];
//
//    UIImage *selectedImage0 = [UIImage imageNamed:@"oldmeter.png"];
//    
//    //UIImage *unselectedImage0 = [UIImage imageNamed:@"oldmeter.png"];
//    
//    UIImage *selectedImage1 = [UIImage imageNamed:@"camera.png"];
//    //UIImage *unselectedImage1 = [UIImage imageNamed:@"camera.png"];
//    
//    UIImage *selectedImage2 = [UIImage imageNamed:@"newmeter.png"];
//    //UIImage *unselectedImage2 = [UIImage imageNamed:@"newmeter.png"];
//    
//    UIImage *selectedImage3 = [UIImage imageNamed:@"signature.png"];
//    //UIImage *unselectedImage3 = [UIImage imageNamed:@"signature.png"];
//    
//
//    
//    
//    UITabBar *tabBar = self.tabBarController.tabBar;
//    
//    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
//    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
//    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
//    UITabBarItem *item3 = [tabBar.items objectAtIndex:3];
//    
//    [item0 setImage:selectedImage0];
//     [item1 setImage:selectedImage1];
//     [item2 setImage:selectedImage2];
//     [item3 setImage:selectedImage3];
    
//    [item0 setFinishedSelectedImage:selectedImage0 withFinishedUnselectedImage:selectedImage0];
//    [item1 setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:selectedImage1];
//    [item2 setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:selectedImage2];
//    [item3 setFinishedSelectedImage:selectedImage3 withFinishedUnselectedImage:selectedImage3];
    
    self.tabBarController.tabBar.autoresizesSubviews = NO;
    self.tabBarController.tabBar.clipsToBounds = YES;
}

-(void) viewDidAppear:(BOOL)animated
{
    if (self.currentclaim != nil)
    {
   
        NSString *photo3imageKey = self.currentclaim.claim.photo3filepath;
        NSString *photo4imageKey = self.currentclaim.claim.photo4filepath;
        NSString *photo5imageKey = self.currentclaim.claim.photo5filepath;
        
        if (photo3imageKey) {
            // Get image for image key from image store
            UIImage *imageToDisplay =
            [[ImageStore sharedStore] imageForKey:photo3imageKey];
            
            // Use that image to put on the screen in imageView
            [self.photo3imageView setImage:imageToDisplay];
        }
        if (photo4imageKey) {
            // Get image for image key from image store
            UIImage *imageToDisplay =
            [[ImageStore sharedStore] imageForKey:photo4imageKey];
            
            // Use that image to put on the screen in imageView
            [self.photo4imageView setImage:imageToDisplay];
        }
        if (photo5imageKey) {
            // Get image for image key from image store
            UIImage *imageToDisplay =
            [[ImageStore sharedStore] imageForKey:photo5imageKey];
            
            // Use that image to put on the screen in imageView
            [self.photo5imageView setImage:imageToDisplay];
        }
    }
    
}
-(void) viewWillDisappear:(BOOL)animated
{

    
    
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





- (IBAction)takePicture:(id)sender {
    [super takePic:sender];
    //self.imageView.image = [super imagetaken];
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
    NSLog(@" tag of picker view is %ld",(long)picker.view.tag);
    
    long tag = (long)picker.view.tag;
    NSString *oldKey = nil;
    if (tag ==3 )
        oldKey = self.currentclaim.claim.photo3filepath;
    else if (tag ==4 )
        oldKey = self.currentclaim.claim.photo4filepath;
    else if (tag ==5 )
        oldKey = self.currentclaim.claim.photo5filepath;
    
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
       // self.imagetaken = image;
        // Create a CFUUID object - it knows how to create unique identifier strings
        CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
        // Create a string from unique identifier
        CFStringRef newUniqueIDString =
        CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
        // Use that unique ID to set our item's imageKey
        NSString *key = (__bridge NSString *)newUniqueIDString;
        //[self setImageKey:key];
        
        if (tag ==3 )
            self.currentclaim.claim.photo3filepath = key;
        else if (tag ==4 )
            self.currentclaim.claim.photo4filepath = key;
        else if (tag ==5 )
            self.currentclaim.claim.photo5filepath = key;
        
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
