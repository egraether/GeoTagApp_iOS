//
//  MenuViewController.m
//  GeoTagApp_iOS
//
//  Created by ebsi on 27.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "PostViewController.h"
#import "AuthorizationViewController.h"

@implementation TouchView

@synthesize delegate;

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
	if(self.userInteractionEnabled) {
		return [delegate hitTest: point withEvent: event];
	}
	else {
		return self;
	}
}
@end


@implementation MenuViewController

@synthesize touchView;
@synthesize postViewController;
@synthesize authorizationViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.wantsFullScreenLayout = YES;
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
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
    
    touchView = [[TouchView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
	touchView.backgroundColor = [UIColor whiteColor];
	touchView.alpha = 0.0;
    
    [self.view insertSubview:touchView atIndex:0];
    
    menuOpenButton.hidden = YES;
    cameraViewButton.hidden = YES;
    
    postButton.hidden = YES;
    profileButton.hidden = YES;
    friendsButton.hidden = YES;
    archiveButton.hidden = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void) toggleViewIcon {
    
    cameraViewButton.hidden = mapViewButton.hidden;
    mapViewButton.hidden = !mapViewButton.hidden;
    
    [touchView.delegate switchViews];

}

- (void) toggleMenu {
    
    menuClosedButton.hidden = menuOpenButton.hidden;
    menuOpenButton.hidden = !menuOpenButton.hidden;
	
	// fade out
	if(postButton.hidden == NO) {		
		postButton.alpha = profileButton.alpha = friendsButton.alpha = archiveButton.alpha = 1.0;
		
		[UIView beginAnimations:@"fade" context:nil];
		[UIView setAnimationDuration:0.8];
		touchView.alpha = 0.0;
		postButton.alpha = profileButton.alpha = friendsButton.alpha = archiveButton.alpha = 0.0;
		[UIView commitAnimations];
		touchView.userInteractionEnabled = YES;
	}
	
	postButton.hidden = !postButton.hidden;
    profileButton.hidden = !profileButton.hidden;
    friendsButton.hidden = !friendsButton.hidden;
    archiveButton.hidden = !archiveButton.hidden;
	
	// fade in
	if(postButton.hidden == NO) {		
		postButton.alpha = profileButton.alpha = friendsButton.alpha = archiveButton.alpha = 0.0;
		
		[UIView beginAnimations:@"fade" context:nil];
		[UIView setAnimationDuration:0.8];
		touchView.alpha = 0.8;
		postButton.alpha = profileButton.alpha = friendsButton.alpha = archiveButton.alpha = 1.0;
		[UIView commitAnimations];
		touchView.userInteractionEnabled = NO;
	}
}

- (IBAction) pressPostButton {
	NSLog(@"show post formular");
	[self.view addSubview: postViewController.view];
	[self toggleMenu];
}

- (IBAction) pressProfileButton {
	NSLog(@"show authorization");
	[self.view addSubview: authorizationViewController.view];
	[self toggleMenu];
}

- (IBAction) pressArchiveButton {
	NSLog(@"show archive");
	[self toggleMenu];
}

- (IBAction) pressFriendsButton {
	NSLog(@"show friends");
	[self toggleMenu];
}

@end
