
#import "GeoTagViewController.h"


@implementation GeoTagView

- (id) init {
    self = [super initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    NSString* path = @"map_item.png";
    [image initWithImage: [[UIImage alloc] initWithContentsOfFile: path]];
    
    [self addSubview: image];
    
    self.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    
    return self;
}

// The designated initializer. Override to perform setup that is required before the view is loaded.
//- (id)initWithNibName:[[NSString alloc] initWithString:@"MainViewController.xib"] 
//                bundle:[NSBundle initWithPath:@"./Resources"] {
//    
//    self = [super initWithNibName:[NSString initWithString:@"MainViewController.xib"] bundle:[NSBundle initWithPath:@"./Resources"]];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}


/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
//- (void)viewDidLoad {
//    [super viewDidLoad];
//}
//
//
//// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//// Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
//}
//
//- (void)didReceiveMemoryWarning {
//	// Releases the view if it doesn't have a superview.
//    [super didReceiveMemoryWarning];
//	
//	// Release any cached data, images, etc that aren't in use.
//}
//
//- (void)viewDidUnload {
//	// Release any retained subviews of the main view.
//	// e.g. self.myOutlet = nil;
//}
//
//- (void)dealloc {
//    [super dealloc];
//}



@end