//
//  UIBaseTableViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/7/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyClaim.h"

@interface UIBaseTableViewController : UITableViewController<UITextFieldDelegate>

//@property(strong, nonatomic) ScheduleClaim *claim;
@property (weak, nonatomic) MyClaim *currentclaim;

- (void)scan;

- (IBAction)takePic:(id)sender;
//-(UIImage *) getImage: (NSString *) key;
//-(void) setImageView: (NSString *) key;
//@property(weak, nonatomic) NSString *scannedData;
//@property(weak, nonatomic) UIImage *imagetaken;
//@property (nonatomic, copy) NSString *imageKey;
@end
