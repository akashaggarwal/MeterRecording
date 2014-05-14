//
//  UINotesViewController.m
//  MeterRecording
//
//  Created by Akash Aggarwal on 5/12/14.
//  Copyright (c) 2014 Akash Aggarwal. All rights reserved.
//

#import "UINotesViewController.h"

@interface UINotesViewController ()

@end

@implementation UINotesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentclaim = [MyClaim sharedContent];
    self.txtNotes.delegate = self;
    
}



-(void)viewDidAppear:(BOOL)animated
{
    if (self.currentclaim != nil)
    {
        self.txtNotes.text = self.currentclaim.claim.note;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"textViewDidBeginEditing:");
    //textView.backgroundColor = [UIColor blackColor];
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"textViewShouldEndEditing:");
   // textView.backgroundColor = [UIColor whiteColor];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSLog(@"textViewDidEndEditing: and text is %@", [textView text]);
    self.currentclaim.claim.note = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return textView.text.length + (text.length - range.length) <= 1000;
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
//    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
//    NSUInteger location = replacementTextRange.location;
//    
//    if (textView.text.length + text.length > 1000){
//        if (location != NSNotFound){
//            [textView resignFirstResponder];
//        }
//        return NO;
//    }
//    else if (location != NSNotFound){
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    [self _showTextViewCaretPosition:textView];
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    [self _showTextViewCaretPosition:textView];
}


- (void)_showTextViewCaretPosition:(UITextView *)textView {
    CGRect caretRect = [textView caretRectForPosition:self.txtNotes.selectedTextRange.end];
    [textView scrollRectToVisible:caretRect animated:NO];
}


#pragma mark - Keyboard notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    BOOL isPortrait = UIDeviceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation);
    CGFloat keyboardHeight = isPortrait ? keyboardFrame.size.height : keyboardFrame.size.width;
    
    UIEdgeInsets contentInset = self.txtNotes.contentInset;
    contentInset.bottom = keyboardHeight;
    
    
    UIEdgeInsets scrollIndicatorInsets = self.txtNotes.scrollIndicatorInsets;
    scrollIndicatorInsets.bottom = keyboardHeight;
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.txtNotes.contentInset = contentInset;
        self.txtNotes.scrollIndicatorInsets = scrollIndicatorInsets;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval animationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    UIEdgeInsets contentInset = self.txtNotes.contentInset;
    contentInset.bottom = 0;
    
    UIEdgeInsets scrollIndicatorInsets = self.txtNotes.scrollIndicatorInsets;
    scrollIndicatorInsets.bottom = 0;
    
    [UIView animateWithDuration:animationDuration animations:^{
        self.txtNotes.contentInset = contentInset;
        self.txtNotes.scrollIndicatorInsets = scrollIndicatorInsets;
    }];
}
@end
