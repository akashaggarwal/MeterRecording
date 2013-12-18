//
//  main.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 11/3/13.
//  Copyright (c) 2013 Akash Aggarwal. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "AppContent.h"
int main(int argc, char * argv[])
{
    @autoreleasepool {
         AppContent *content =[[AppContent alloc] init];
        Session *s = content.session;
        NSLog(@"session.installer id = %@ and datetime is %@", s.installerID, s.lastDateTime);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
