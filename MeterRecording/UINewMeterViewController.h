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


- (IBAction)takePicture:(id)sender;
- (IBAction)scan:(id)sender;

@end
