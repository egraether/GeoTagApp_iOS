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
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.bounds = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
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

- (IBAction) pressPostButton {
	
	// TODO: post message to server
	
//	CLLocationCoordinate2D coord = [locationDelegate getCoordinate];
	
//	CLLocation *currentLocation = [locationDelegate getCurrentLocation];
//	NSLog(@"latitude %+.6f, longitude %+.6f, altitude %+.6f\n",
//		  currentLocation.coordinate.latitude,
//		  currentLocation.coordinate.longitude,
//		  currentLocation.altitude);
//	NSLog(@"latitude %+.6f, longitude %+.6f\n",
//		  coord.latitude,
//		  coord.longitude);
	NSLog(@"postmessage: %@\n", textField.text);
		
//	NSURL *url = [NSURL URLWithString:@"http://sbickt.heroku.com/geotags"];
//	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//	[request setPostValue:textField.text forKey:@"sbickerl[content]"];
//	[request setPostValue:@"public" forKey:@"sbickerl[visibility]"];
//	[request setPostValue:@"47.79760" forKey:@"geotag[lat]"];
//	[request setPostValue:@"13.06768" forKey:@"geotag[lng]"];
//	[request setPostValue:@"471.0" forKey:@"geotag[alt]"];
//	[request setRequestMethod:@"POST"];
//	
//	[request setDelegate:self];
//	[request startAsynchronous];
	
	
	[self.view removeFromSuperview];
	
}

@end
