
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
    
    float phi = 270* - heading;
    
    Vector* right = [[Vector alloc] initWithX: cosf(phi) y: sinf(phi) z: 0];
    
    Vector* z = [acceleration mul: -1];
    [z normalize];
    
    Vector* y = [z cross: right];
    [y normalize];
    
    Vector* x = [y cross: z];
    [x normalize];
    
    Matrix* matrix = [[Matrix alloc] initTransposedWithVectorsA: x B: y C: z];
    
    
    for (GeoTag* geoTag in geoTagContainer.geoTags) {
        
        Vector* worldDirection = [[Vector alloc] initVectorFromLocation:location toLocation:geoTag.location];
        
        geoTag.direction = [matrix transformVector:worldDirection];
        
    }
    
    [self.view setNeedsDisplay];
    
}

@end
