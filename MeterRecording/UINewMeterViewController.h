//
//  UINewMeterViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseTableViewController.h"

@interface UINewMeterViewController : UIBaseTableViewController
@property (weak, nonatomic) IBOutlet UIButton *btnImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *txtNewSerial;
@property (weak, nonatomic) IBOutlet UITextField *txtNewReading;
@property (weak, nonatomic) IBOutlet UITextField *txtPlumbingTime;
@property (weak, nonatomic) IBOutlet UITextField *txtNewSize;
@property (weak, nonatomic) IBOutlet UITextField *txtNewRemoteID;
@property (weak, nonatomic) IBOutlet UIButton *btnScan;

- (IBAction)takePicture:(id)sender;
- (IBAction)scan:(id)sender;

@end
