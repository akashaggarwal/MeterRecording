//
//  UIBaseTableViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/7/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyClaim.h"

@interface UIBaseTableViewController : UITableViewController

//@property(strong, nonatomic) ScheduleClaim *claim;
@property (weak, nonatomic) MyClaim *currentclaim;
- (void)takePicture;
- (void)scan;

@property(weak, nonatomic) NSString *scannedData;
@property(weak, nonatomic) UIImage *imagetaken;
@end
