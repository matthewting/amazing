//
//  LoginViewControlller.h
//  MangoDemo
//
//  Created by Matthew Ting on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewControlller : UIViewController {
    bool		isViewLoadedUp;

}
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *indicatorMsgLabel;

- (IBAction)loginAction:(id)sender;
- (void) animateTextField: (UITextField*) textField up: (BOOL) up;

@end
