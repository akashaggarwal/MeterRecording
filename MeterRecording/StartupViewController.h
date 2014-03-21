//
//  StartupViewController.h
//  MeterRecording
//
//  Created by Akash Aggarwal on 3/20/14.
//  Copyright (c) 2014 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIStartupViewController : UIViewController


//
//@property (weak, nonatomic) IBOutlet UIProgressView *pView;
//
//@property (weak, nonatomic) IBOutlet UILabel *pLabel;


-(void) simulateSleep;
-(void) updateProgress:(NSString *)text ;
@end
