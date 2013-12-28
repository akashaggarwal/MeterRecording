//
//  UIOldMeterViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseTableViewController.h"
#import "ZBarSDK.h"
#import "ScheduleClaim.h"

@interface UIOldMeterViewController : UIBaseTableViewController <ZBarReaderDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *txtCorrectSerial;
@property (weak, nonatomic) IBOutlet UITextField *txtprevReading;
@property (weak, nonatomic) IBOutlet UITextField *txtOldSize;


@end
