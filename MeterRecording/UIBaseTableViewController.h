//
//  UIBaseTableViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/7/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBaseTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *txtSerial;
- (IBAction)takePicture:(id)sender;
- (IBAction)scan:(id)sender;
@end
