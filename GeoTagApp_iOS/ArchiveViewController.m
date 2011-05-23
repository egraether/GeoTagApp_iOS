//
//  ArchiveViewController.m
//  GeoTagApp_iOS
//
//  Created by thomas.probook on 21.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArchiveViewController.h"
#import "ArchiveTableViewCell.h"

#import "SimpleKML.h"
#import "SimpleKMLDocument.h"
#import "SimpleKMLPlacemark.h"
#import "SimpleKMLPoint.h"
#import "GeoTag.h"


@implementation ArchiveViewController

@synthesize geoTags;

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

- (void)viewDidLoad {
    
	[super viewDidLoad];
	CGRect screenBounds = [[UIScreen mainScreen] bounds];
	CGFloat screenScale = [[UIScreen mainScreen] scale];
	self.view.frame = CGRectMake(0.0, 0.0, screenBounds.size.height * screenScale, screenBounds.size.width * screenScale);
	
	// NSArray *array = [[NSArray alloc] initWithObjects:@"Apple",@"Microsoft",@"Samsung",@"Motorola", @"Nokia",nil];
	
	// [self updateGeoTags];
	geoTags = [[NSArray alloc] init];
	[self updateGeoTags];
	
//	NSArray *array = [[NSArray alloc] initWithArray: (NSArray*) [self updateGeoTags]];
//	self.geoTags = array;
//	
//	[array release];
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

// sends a message to the datasource asking for the number of rows that will appear in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [geoTags count];
}

// will get called every time we need a new cell in the table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	ArchiveTableViewCell *cell = (ArchiveTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ArchiveTableViewCell"];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"ArchiveTableViewCell" owner:self options:nil];
		cell = archiveTableViewCell;
	}

	[cell setMessage:[[geoTags objectAtIndex:indexPath.row] subtitle]];
	NSLog(@"count: @%i", [geoTags count]);
	
	return cell;
}

//  gets called when a cell in the table view gets tapped
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//	
//	NSString *message = [NSString stringWithFormat:@"You selected %@",[geoTags objectAtIndex:indexPath.row]];
//	
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
//													message: message
//												   delegate:self
//										  cancelButtonTitle:@"Close"
//										  otherButtonTitles:nil];
//	[alert show];
//	[alert release];
//}


- (void) updateGeoTags {
	
	NSMutableArray* array = [NSMutableArray arrayWithCapacity:1];
    NSError* error = NULL;
	NSString* url = [NSString stringWithFormat:@"http://sbickt.heroku.com/geotags/list.kml?lat=47.724239&lng=13.086592"];
    
    SimpleKML *kml = [SimpleKML KMLWithContentsOfURL:[NSURL URLWithString: url] error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    if (kml.feature && [kml.feature isKindOfClass:[SimpleKMLDocument class]]) {
        
        for (SimpleKMLFeature *feature in ((SimpleKMLContainer *)kml.feature).features) {
            
            if ([feature isKindOfClass:[SimpleKMLPlacemark class]] && ((SimpleKMLPlacemark *)feature).point) {
                
                SimpleKMLPoint *point = ((SimpleKMLPlacemark *)feature).point;
                
                GeoTag* geoTag = [[GeoTag alloc] initAtLocation: point.location 
													withMessage: feature.featureDescription
													  andAuthor: feature.name];
                
                [array addObject: geoTag];
            }
        }
    }
	self.geoTags = (NSArray *) array;
}


- (IBAction) pressBackButton {
	
	[self.view removeFromSuperview];
	
}


@end
