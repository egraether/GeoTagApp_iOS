//
//  GeoTagViewController.m
//  GeoTag
//
//  Created by ebsi on 13.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GeoTagViewController.h"

@implementation GeoTagViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://sbickt.heroku.com/geotags/list.kml?coordinates[x]=47.79&coordinates[y]=13.08"];
    
	NSURLRequest* request = [NSURLRequest requestWithURL:url];
	NSURLResponse *response = nil;
    
	NSData *data = [NSURLConnection	sendSynchronousRequest:request returningResponse:&response error:NULL];
    
	NSLog(@"URL response: %@",[NSString stringWithCString:[data bytes] length:[data length]]);
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
