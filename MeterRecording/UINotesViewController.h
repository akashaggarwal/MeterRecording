//
//  UINotesViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 5/12/14.
//  Copyright (c) 2014 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyClaim.h"

@interface UINotesViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) MyClaim *currentclaim;
@property (weak, nonatomic) IBOutlet UITextView *txtNotes;
@end
