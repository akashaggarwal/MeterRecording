//
//  UISIgnatureViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseTableViewController.h"
#import "NISignatureView.h"

@interface UISIgnatureViewController : UIViewController
@property (weak, nonatomic) MyClaim *currentclaim;
//@property (strong, nonatomic)  NISignatureView *signatureView;
- (IBAction)accept:(id)sender ;
- (IBAction)clear:(id)sender;
@end
