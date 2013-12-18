//
//  UIPhoto3ViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseTableViewController.h"

@interface UIPhoto3ViewController : UIBaseTableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>




@property (weak, nonatomic) IBOutlet UIButton *btnImage;
- (IBAction)takePicture:(id)sender;

@end
