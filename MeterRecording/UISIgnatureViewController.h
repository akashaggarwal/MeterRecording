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
#import "T1Autograph.h"

@interface UISIgnatureViewController : UIViewController <T1AutographDelegate>
@property (weak, nonatomic) MyClaim *currentclaim;
@property (strong) T1Autograph *autograph;
@property (strong) T1Autograph *autographModal;
@property (strong) UIImageView *outputImage;
//@property (strong, nonatomic)  NISignatureView *signatureView;
- (IBAction)accept:(id)sender ;
- (IBAction)clear:(id)sender;
@end
