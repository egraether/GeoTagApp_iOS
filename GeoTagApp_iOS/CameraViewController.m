
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

- (void)calculateGeoTagDirectionsAtLocation: (CLLocation*)location 
                                withHeading: (float)heading
                            andAcceleration: (Vector*)acceleration {
    
    float phi = heading * M_PI / 180;
    
    Vector* right = [[Vector alloc] initWithX: 0 y: sinf(phi) z: -cosf(phi)];
    
    Vector* z = [acceleration mul: -1];
    [z normalize];
    
    Vector* y = [z cross: right];
    [y normalize];
    
    Vector* x = [y cross: z];
    [x normalize];
    
    Matrix* matrix = [[Matrix alloc] initTransposedWithVectorsA: x B: y C: z];
    
//    CLLocation* geoTagLocation = [[CLLocation alloc] initWithLatitude:location.coordinate.latitude 
//                                                            longitude:location.coordinate.longitude + 0.001];
//    
//    Vector* worldDirection = [[Vector alloc] initVectorFromLocation:location toLocation:geoTagLocation];
//    
//    //[worldDirection print];
//        
//    Vector* direction = [matrix transformVector:worldDirection];
//        
//    [direction print];
    
    
    for (GeoTag* geoTag in geoTagContainer.geoTags) {
        
        Vector* worldDirection = [[Vector alloc] initVectorFromLocation:location toLocation:geoTag.location];
        
        geoTag.direction = [matrix transformVector:worldDirection];
        
        [geoTag.direction print];
        
    }
    
//    [self.view setNeedsDisplay];
    
}

@end
