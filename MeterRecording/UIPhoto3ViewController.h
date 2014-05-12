//
//  UIPhoto3ViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/6/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseTableViewController.h"

@interface UIPhoto3ViewController : UIBaseTableViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *photo3imageView;

@property (weak, nonatomic) IBOutlet UIImageView *photo4imageView;
@property (weak, nonatomic) IBOutlet UIImageView *photo5imageView;

@property (weak, nonatomic) IBOutlet UIButton *btnPhoto3;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto4;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto5;

//
//@property (weak, nonatomic) IBOutlet UIButton *btnImage;
//- (IBAction)takePicture:(id)sender;
- (IBAction)takePicture:(id)sender;

@end
