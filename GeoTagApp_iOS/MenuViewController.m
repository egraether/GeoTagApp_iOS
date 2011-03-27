//
//  MenuViewController.m
//  GeoTagApp_iOS
//
//  Created by ebsi on 27.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"

@implementation TouchView

@synthesize delegate;

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    return [delegate hitTest: point withEvent: event];
}

@end


@implementation MenuViewController

@synthesize touchView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    touchView = [[TouchView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void) toggleViewIcon {
    
    cameraViewButton.hidden = mapViewButton.hidden;
    mapViewButton.hidden = !mapViewButton.hidden;
    
    [touchView.delegate switchViews];

}

- (void) toggleMenu {
    
    menuClosedButton.hidden = menuOpenButton.hidden;
    menuOpenButton.hidden = !menuOpenButton.hidden;

}

@end
