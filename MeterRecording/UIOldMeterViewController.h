//
//  UIOldMeterViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseTableViewController.h"

#import "Schedule.h"

@interface UIOldMeterViewController : UIBaseTableViewController <ZBarReaderDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *txtCorrectSerial;
@property (weak, nonatomic) IBOutlet UITextField *txtprevReading;
@property (weak, nonatomic) IBOutlet UITextField *txtOldSize;
@property (weak, nonatomic) IBOutlet UIButton *btnScan;

- (IBAction)scanSerial:(id)sender;

- (IBAction)takePicture:(id)sender;



@end
