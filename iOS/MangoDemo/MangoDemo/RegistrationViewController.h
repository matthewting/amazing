//
//  RegistrationViewController.h
//  MangoDemo
//
//  Created by Matthew Ting on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController {
        bool		isViewLoadedUp;

}

@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *passwordConfField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *userdataField;
- (IBAction)registerAction:(id)sender;
- (IBAction)userDataTouch:(id)sender;

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField;

//- (void) animateTextField: (UITextField*) textField up: (BOOL) up;

- (IBAction)textFieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

@end
