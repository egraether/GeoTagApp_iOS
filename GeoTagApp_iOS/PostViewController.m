//
//  PostViewController.m
//  GeoTagApp_iOS
//
//  Created by thomas.probook on 13.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PostViewController.h"
#import "ASIFormDataRequest.h"


@implementation PostViewController

@synthesize locationDelegate;
@synthesize textField;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		self.wantsFullScreenLayout = YES;
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	CGFloat screenScale = [[UIScreen mainScreen] scale];
	self.view.frame = CGRectMake(0.0, 0.0, screenBounds.size.height * screenScale, screenBounds.size.width * screenScale);
	
	[textField becomeFirstResponder];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction) onHitKeyboardReturn: (id)sender {
	[sender resignFirstResponder];
}
- (IBAction) onTouchOutsideTextField: (id)sender {
	[textField resignFirstResponder];
}


- (IBAction) pressBackButton {
	
	[self.view removeFromSuperview];
	
}

- (IBAction) pressPostButton {
	
	// [textField resignFirstResponder];
	// TODO: post message to server
		
	CLLocation *currentLocation = [locationDelegate getCurrentLocation];
	NSLog(@"latitude %+.6f, longitude %+.6f, altitude %+.6f\n",
		  currentLocation.coordinate.latitude,
		  currentLocation.coordinate.longitude,
		  currentLocation.altitude);

	NSLog(@"postmessage: %@\n", textField.text);
	
	NSURL *url = [NSURL URLWithString:@"http://sbickt.heroku.com/geotags"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:textField.text forKey:@"sbickerl[content]"];
	[request setPostValue:@"public" forKey:@"sbickerl[visibility]"];
	[request setPostValue:[NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude] 
				   forKey:@"geotag[lat]"];
	[request setPostValue:[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude] 
				   forKey:@"geotag[lng]"];
	[request setPostValue:[NSString stringWithFormat:@"%f", currentLocation.altitude] 
				   forKey:@"geotag[alt]"];

	[request setRequestMethod:@"POST"];
	request.shouldRedirect = NO;
	
	[request startSynchronous];
	NSError *error = [request error];
	if (!error) {
		NSLog(@"success!\n");
		NSString *response = [request responseString];
		NSLog(@"%@", response);
	}
	
	
	[self.view removeFromSuperview];	
}

@end
