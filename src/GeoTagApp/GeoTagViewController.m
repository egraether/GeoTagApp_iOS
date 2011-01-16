
#import "GeoTagViewController.h"
#import "CanvasViewController.h"
#import "GeoLocationDelegate.h"

#import "SimpleKML.h"
#import "SimpleKMLDocument.h"
#import "SimpleKMLContainer.h"
#import "SimpleKMLPlacemark.h"
#import "SimpleKMLPoint.h"


@implementation GeoTagViewController

@synthesize camera;
@synthesize motionManager;
@synthesize geoTags;


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
    
    canvasViewController = [[CanvasViewController alloc] init];
    [self.view insertSubview:canvasViewController.view atIndex:0];
    
    geoLocationDelegate = [[GeoLocationDelegate alloc] init];
    [geoLocationDelegate startStandardUpdates];
    
    [self startMotionUpdates];
}

- (void)press {
//    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
//    
//	imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
//	//imagePicker.delegate = self;
//    
//	imagePicker.allowsEditing = NO;
//    
//    imagePicker.showsCameraControls = NO;
//    imagePicker.navigationBarHidden = YES;
//    
//    imagePicker.toolbarHidden = YES;
//    imagePicker.wantsFullScreenLayout = YES;
//    
////    CGFloat cameraTransformX = 1.0;
////    CGFloat cameraTransformY = 1.12412;
////    
////    imagePicker.cameraViewTransform = CGAffineTransformScale(imagePicker.cameraViewTransform, cameraTransformX, cameraTransformY);
//    
//	[self presentModalViewController:imagePicker animated:YES];
    
    [self loadGeoTagsByLocation:geoLocationDelegate.location];
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:.1
                                                      target:self 
                                                    selector:@selector(doGeoTagDraw)
                                                    userInfo:nil 
                                                     repeats:YES];
    
}

-(void)doGeoTagDraw {
    
    [canvasViewController calculateGeoTagDirections:geoTags atLocation:geoLocationDelegate.location withHeading:geoLocationDelegate.heading];
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

- (void)startMotionUpdates {
    motionManager = [[CMMotionManager alloc] init];
    [motionManager startAccelerometerUpdates];
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                      target:self 
                                                    selector:@selector(doMotionUpdate)
                                                    userInfo:nil 
                                                     repeats:YES];
    
    
//    [motionManager stopGyroUpdates];
//    [timer invalidate];
}

-(void)doMotionUpdate {
    CMAcceleration a = self.motionManager.accelerometerData.acceleration;
    
    //NSLog(@"acceleration: %+.2f | %+.2f | %+.2f", a.x, a.y, a.z);
}

- (void)dealloc {
    [super dealloc];
}

- (void) loadGeoTagsByLocation:(CLLocation*)location {

    NSError* error = NULL;
    
    //SimpleKML *kml = [SimpleKML KMLWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list" ofType:@"kml"] error:&error];
    //SimpleKML *myKML = [SimpleKML KMLWithContentsOfURL:[NSURL URLWithString:@"http://sbickt.heroku.com/geotags/list.kml?coordinates[x]=47.79&coordinates[y]=13.08"] error:&error];
    
    SimpleKML *kml = [SimpleKML KMLWithContentsOfURL:[NSURL URLWithString:@"http://egraether.multimediatechnology.at/list.kml"] error:&error];    
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    geoTags = [[NSMutableArray alloc] initWithCapacity:100];
    
    if (kml.feature && [kml.feature isKindOfClass:[SimpleKMLDocument class]]) {

        for (SimpleKMLFeature *feature in ((SimpleKMLContainer *)kml.feature).features) {

            if ([feature isKindOfClass:[SimpleKMLPlacemark class]] && ((SimpleKMLPlacemark *)feature).point) {
                
                SimpleKMLPoint *point = ((SimpleKMLPlacemark *)feature).point;
                
                [geoTags addObject:((SimpleKMLPlacemark *)feature)];
                
//                MKPointAnnotation *annotation = [[[MKPointAnnotation alloc] init] autorelease];
//                
//                annotation.coordinate = point.coordinate;
//                annotation.title      = feature.name;
//                
//                [mapView addAnnotation:annotation];
                
                NSLog(@"coordinates: %f - %f - %f", point.coordinate.latitude, point.coordinate.longitude, point.altitude);
            }
            
            if (((SimpleKMLPlacemark *)feature).name) {
            
                NSLog(@"name: %@", ((SimpleKMLPlacemark *)feature).name);
                
            }
            
            if (((SimpleKMLPlacemark *)feature).featureDescription) {
                
                NSLog(@"description: %@", ((SimpleKMLPlacemark *)feature).featureDescription);
                
            }
        }
    }
    
    //    NSURL *url = [NSURL URLWithString:@"http://sbickt.heroku.com/geotags/list.kml?coordinates[x]=47.79&coordinates[y]=13.08"];
    //    
    //	NSURLRequest* request = [NSURLRequest requestWithURL:url];
    //	NSURLResponse *response = nil;
    //    
    //	NSData *data = [NSURLConnection	sendSynchronousRequest:request returningResponse:&response error:NULL];
    //    
    //	NSLog(@"URL response: %@",[NSString stringWithCString:[data bytes] length:[data length]]);
}

@end
