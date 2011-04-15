
#import "CameraViewController.h"

#import "GeoTag.h"
#import "GeoTagContainer.h"

#import "Vector.h"
#import "Quaternion.h"


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
    
    Vector* gravity = [[Vector alloc] initWithX: 0 y: 0 z: 1];
    Vector* rotation = [[Vector alloc] initWithX: 1 y: 0 z: 0];
    
    Quaternion* q = [[Quaternion alloc] initWithAngle: [gravity angle: rotation] 
                                              andAxis: [gravity cross: rotation]];
    
    [q print];
    
    
    Vector* v = [[Vector alloc] initWithX: -1 y: 0 z: 0];
    
    v = [Quaternion rotate: v withQuaternion: q];
    
    [v print];
    
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
                                andRotation: (Vector*)rotation {
    
    
    Vector* gravity = [[Vector alloc] initWithX: 0 y: 0 z: -1];
    
    Quaternion* q = [[Quaternion alloc] initWithAngle: [gravity angle: rotation] 
                                              andAxis: [gravity cross: rotation]];
    
    Vector* position = [[Vector alloc] init];
    [position setWorldVectorAtCoordinate: location.coordinate];
    
    
    for (GeoTag* geoTag in geoTagContainer.geoTags) {
        
        Vector* v = [[Vector alloc] init];
        [v setWorldVectorAtCoordinate: geoTag.coordinate];
        
        v = [v sub: position];
//        v = [v rotate2D: (heading + 90) * M_PI / 180];
        
        
        geoTag.direction = [Quaternion rotate: v withQuaternion: q];
        
        
        
    }
    
    [self.view setNeedsDisplay];
    
}

@end
