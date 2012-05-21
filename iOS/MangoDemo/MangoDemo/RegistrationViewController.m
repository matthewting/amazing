//
//  RegistrationViewController.m
//  MangoDemo
//
//  Created by Matthew Ting on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RegistrationViewController.h"

@implementation RegistrationViewController
@synthesize emailField;
@synthesize usernameField;
@synthesize passwordField;
@synthesize passwordConfField;
@synthesize userdataField;

-(IBAction)textFieldReturn:(id)sender
{
	[sender resignFirstResponder];
}
-(IBAction)backgroundTouched:(id)sender
{
	[usernameField resignFirstResponder];
	[passwordField resignFirstResponder];
	[passwordConfField resignFirstResponder];
	[userdataField resignFirstResponder];
	[emailField resignFirstResponder];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    	isViewLoadedUp = NO;
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [self setPasswordConfField:nil];
    [self setUserdataField:nil];
    [self setEmailField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)registerAction:(id)sender {
    
    
    //    NSHTTPURLResponse * response;
    //    NSError * error;
    //    NSMutableURLRequest *request;
    //    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://127.0.0.1:8000/accounts/login/"]
    //                                           cachePolicy:NSURLRequestReloadIgnoringCacheData 
    //                                       timeoutInterval:60];
    //    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];	
    //    
    //    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
    //    NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:[NSURL URLWithString:@"http://127.0.0.1:8000/accounts/login/"]];
    //    NSLog(@"%d", all.count);
    //    
    //    NSString * csrftoken = NULL;
    //    
    //    for (NSHTTPCookie *cookie in all) {
    //        if(cookie.name == @"csrftoken") {
    //            csrftoken = cookie.value;
    //        }
    //        NSLog(@"Name: %@ : Value: %@", cookie.name, cookie.value); 
    //    }
    
    // Create the URL from a string.
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8000/api/v2/mangouser/"];
    NSMutableURLRequest *requestLogin = [NSMutableURLRequest requestWithURL:url
                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    // Create a request object using the URL.
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [requestLogin setHTTPMethod:@"POST"];
    
    //[requestLogin addValue:csrftoken forHTTPHeaderField:@"X-CSRFToken"];
    //[requestLogin addValue:[NSString stringWithFormat:@"csrftoken=%@", csrftoken] forHTTPHeaderField:@"Cookie"];
    [requestLogin setValue:@"application/json" forHTTPHeaderField:@"Accept"];
	[requestLogin setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[requestLogin setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
NSString *myRequestString =  [NSString stringWithFormat:@"{\"username\":\"%@\",\"email\":\"%@\",\"password\":\"%@\",\"userdata\":\"%@\"}", usernameField.text, emailField.text ,passwordField.text, userdataField.text];
    
//  Hard-coded for testing Use    
//    NSString *myRequestString = @"{\"username\":\"mting923e\",\"email\":\"mting923c@gmail.com\", \"password\":\"12345\"}"; 
    
    
    //NSData *requestData = [myRequestString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //NSData* requestData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    NSData *myRequestData = [ NSData dataWithBytes: [ myRequestString UTF8String ] length: [ myRequestString length ] ];

    
    [requestLogin setHTTPBody:myRequestData];
    
    // Prepare for the response back from the server    
    NSHTTPURLResponse *responseLogin = nil;
    NSError *errorLogin = nil;
    
    // Send a synchronous request to the server (i.e. sit and wait for the response)
    NSData *responseData = [NSURLConnection sendSynchronousRequest:requestLogin returningResponse:&responseLogin error:&errorLogin];
    
    // Check if an error occurred    
    if (errorLogin != nil) {
        NSLog(@"%@", [errorLogin localizedDescription]);
        // Do something to handle/advise user.
    }
    
    // Convert the response data to a string.
    NSString *responseString = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
    
    // View the data returned - should be ready for parsing.
    NSLog(@"%@", responseString);
    
    NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[responseLogin allHeaderFields] forURL:[NSURL URLWithString:@"http://127.0.0.1:8000/api/v2/mangouser/"]];
    NSLog(@"%d", all.count);
    for (NSHTTPCookie *cookie in all) {
        NSLog(@"Name: %@ : Value: %@", cookie.name, cookie.value); 
    }
    
}

- (IBAction)userDataTouch:(id)sender{
    
}

//
//- (void) animateTextField: (UITextField*) textField up: (BOOL) up
//{
//    const int movementDistance = 110; // tweak as needed
//    const float movementDuration = 0.3f; // tweak as needed
//	
//	int movement = (up ? -movementDistance : movementDistance);
//    
//    
//	if ((isViewLoadedUp == YES && movement > 0) ||
//        (isViewLoadedUp == NO && movement < 0)) {
//		[UIView beginAnimations: @"anim" context: nil];
//		[UIView setAnimationBeginsFromCurrentState: YES];
//		[UIView setAnimationDuration: movementDuration];
//		self.view.frame = CGRectOffset(self.view.frame, 0, movement);
//		[UIView commitAnimations];
//		
//		if (movement > 0) {
//			isViewLoadedUp = NO;
//		} else {
//			isViewLoadedUp = YES;
//		}		
//		
//	}
//	
//}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField{
    
//    	[self animateTextField: textField up: YES];
}


@end
