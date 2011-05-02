//
//  AuthorizationViewController.m
//  GeoTagApp_iOS
//
//  Created by thomas.probook on 30.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AuthorizationViewController.h"


@implementation AuthorizationViewController

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
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
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

- (IBAction) pressBackButton {
	
	[self.view removeFromSuperview];
	
}

- (IBAction) pressLoginButton {
	
} 

- (void) loginWithUsername:(NSString *) username password:(NSString *) password {
	
}

@end
