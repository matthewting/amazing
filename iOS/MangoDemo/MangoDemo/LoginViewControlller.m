//
//  LoginViewControlller.m
//  MangoDemo
//
//  Created by Matthew Ting on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewControlller.h"

@implementation LoginViewControlller
@synthesize indicatorMsgLabel;
@synthesize userNameField;
@synthesize passwordField;



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
}

- (void)viewDidUnload
{
    [self setUserNameField:nil];
    [self setPasswordField:nil];
    [self setIndicatorMsgLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)loginAction:(id)sender {
    
    // Create the URL from a string.
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8000/api/v2/mangologin/"];
    NSMutableURLRequest *requestLogin = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    // Create a request object using the URL.
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [requestLogin setHTTPMethod:@"POST"];
    
    //[requestLogin addValue:csrftoken forHTTPHeaderField:@"X-CSRFToken"];
    //[requestLogin addValue:[NSString stringWithFormat:@"csrftoken=%@", csrftoken] forHTTPHeaderField:@"Cookie"];
    [requestLogin setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [requestLogin setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    
    NSString *myRequestString =  [NSString stringWithFormat:@"{\"username\":\"%@\",\"password\":\"%@\"}", userNameField.text, passwordField.text];
    NSLog(@"%@", myRequestString);
    
//    Hard-coded for Testing USe
//    NSString *myRequestString = @"username=mting923e&password=12345";
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
    NSLog(@"response:%@", responseString);
    
//    NSArray * all = [NSHTTPCookie cookiesWithResponseHeaderFields:[responseLogin allHeaderFields] forURL:[NSURL URLWithString:@"http://127.0.0.1:8000/api/v2/mangouser/"]];
//    NSLog(@"%d", all.count);
//    for (NSHTTPCookie *cookie in all) {
//        NSLog(@"Name: %@ : Value: %@", cookie.name, cookie.value); 
//    }
    
    
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 110; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
	
	int movement = (up ? -movementDistance : movementDistance);
    
    
	if ((isViewLoadedUp == YES && movement > 0) ||
        (isViewLoadedUp == NO && movement < 0)) {
		[UIView beginAnimations: @"anim" context: nil];
		[UIView setAnimationBeginsFromCurrentState: YES];
		[UIView setAnimationDuration: movementDuration];
		self.view.frame = CGRectOffset(self.view.frame, 0, movement);
		[UIView commitAnimations];
		
		if (movement > 0) {
			isViewLoadedUp = NO;
		} else {
			isViewLoadedUp = YES;
		}		
		
	}
	
}

-(IBAction)textFieldReturn:(id)sender
{
	[sender resignFirstResponder];
}
-(IBAction)backgroundTouched:(id)sender
{
	[userNameField resignFirstResponder];
	[passwordField resignFirstResponder];
}


@end
