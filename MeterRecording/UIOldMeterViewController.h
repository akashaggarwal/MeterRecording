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

@interface UIOldMeterViewController : UIBaseTableViewController <ZBarReaderDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnImage;



@end
