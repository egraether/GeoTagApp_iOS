
#import "CameraViewController.h"

#import "GeoTag.h"
#import "GeoTagContainer.h"

#import "Vector.h"
#import "Quaternion.h"
#import "Matrix.h"


@implementation CameraViewController


@synthesize geoTagContainer;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//		imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
//		// imagePickerController.delegate = self;
//		
//		imagePickerController.allowsEditing = NO;
//		
//		imagePickerController.showsCameraControls = NO;
//		imagePickerController.navigationBarHidden = YES;
//		
//		imagePickerController.toolbarHidden = YES;
//		imagePickerController.wantsFullScreenLayout = YES;
//		
//		imagePickerController.cameraViewTransform = CGAffineTransformScale(imagePickerController.cameraViewTransform, 1.0, 1.0);
//		
//		
//		[self presentModalViewController:imagePickerController animated:NO];
//		// [self dismissModalViewControllerAnimated:YES];
		
	
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

@end
