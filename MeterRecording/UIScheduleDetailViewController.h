//
//  UIScheduleDetailViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "MyClaim.h"
#import "AppContent.h"


@interface UIScheduleDetailViewController : UITableViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnCapture;
@property (weak, nonatomic) IBOutlet UIButton *btnSkip;
@property (weak, nonatomic) IBOutlet UIButton *btnComplete;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *altphone;
@property (weak, nonatomic) IBOutlet UILabel *route;
@property (weak, nonatomic) IBOutlet UILabel *schdate;
@property (weak, nonatomic) IBOutlet UILabel *schtime;
@property (weak, nonatomic) IBOutlet UILabel *oldserial;
@property (weak, nonatomic) IBOutlet UILabel *oldsize;
@property (weak, nonatomic) IBOutlet UILabel *ordertype;
@property (weak, nonatomic) IBOutlet UILabel *note;
@property (weak, nonatomic) IBOutlet UILabel *newserial;
@property (weak, nonatomic) IBOutlet UILabel *newsize;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewOldPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewNewPhoto;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewSignature;
@property (strong, nonatomic) AppContent *content;
@property (weak, nonatomic) MyClaim *currentclaim;
@property (weak, nonatomic) IBOutlet UILabel *claimStatus;

- (IBAction)JobSkipped:(id)sender;
- (IBAction)JobCompleted:(id)sender;

@end
