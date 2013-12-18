//
//  UILoginViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppContent.h"
@interface UILoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;

@property (weak, nonatomic) IBOutlet UITextField *txtInstallerID;
@property (weak, nonatomic) IBOutlet UIButton *btnShowSchedules;

@property (weak, nonatomic) AppContent *content;

-(IBAction)closeKeyboard:(id)sender;
@end
