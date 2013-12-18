//
//  UIScheduleDetailViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScheduleDetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIButton *btnCapture;
@property (weak, nonatomic) IBOutlet UIButton *btnSkip;
@property (weak, nonatomic) IBOutlet UIButton *btnComplete;
- (IBAction)JobSkipped:(id)sender;
- (IBAction)JobCompleted:(id)sender;

@end
