
#import "GeoTagApp_iOSAppDelegate.h"

#import "CameraViewController.h"
#import "MapViewController.h"

#import "MenuViewController.h"

#import "PostViewController.h"

#import "GeoTag.h"
#import "GeoTagContainer.h"

#import "Vector.h"

@implementation GeoTagApp_iOSAppDelegate


@synthesize window = _window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    cameraViewController = [[UIImagePickerController alloc] init];
    
    cameraViewController.sourceType =  UIImagePickerControllerSourceTypeCamera;
    
    cameraViewController.allowsEditing = NO;
    
    cameraViewController.showsCameraControls = NO;
    cameraViewController.navigationBarHidden = YES;
    
    cameraViewController.toolbarHidden = YES;
    cameraViewController.wantsFullScreenLayout = YES;
    
    cameraViewController.cameraOverlayView.transform = CGAffineTransformMakeRotation(M_PI_2);
    [cameraViewController.cameraOverlayView addSubview: menuViewController.view];
    
    cameraViewController.cameraViewTransform = CGAffineTransformMakeScale(1.254, 1.254);

    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    activeViewController = cameraViewController;
    [self.window.rootViewController presentModalViewController:cameraViewController animated:NO];
    
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
    
    geoTagContainer = [[GeoTagContainer alloc] init];
    
    mapViewController.geoTagContainer = geoTagContainer;
    mapViewController.delegate = self;
    
    menuViewController.touchView.delegate = self;
	menuViewController.postViewController.locationDelegate = self;
    
    [self startLocationUpdates];
    // [self startMotionUpdates];
    
    return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [mapViewController release];
    [cameraViewController release];
    [menuViewController release];
    [super dealloc];
}


#pragma mark - Location

- (void)startLocationUpdates {
    
    if (locationManager == nil) {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 10;
    
    [locationManager startUpdatingLocation];
    
    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 1;
        [locationManager startUpdatingHeading];
    }
    
    // CLLocation* currentPosition = locationManager.location;
    // NSLog(@"currentPosition:: %f - %f - %f", currentPosition.coordinate.latitude, currentPosition.coordinate.longitude, currentPosition.altitude);
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)currentLocation
           fromLocation:(CLLocation *)previousLocation {
    
    NSDate* eventDate = currentLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    if (abs(howRecent) < 15.0) {
        
        location = currentLocation;
        [location retain];
        
        [mapViewController removeGeoTagAnnotations];
        
        [geoTagContainer loadGeoTagsByCoordinate: location.coordinate];
        [geoTagContainer calculateGeoTagWorldDirectionsAtLocation: location];
        
        [mapViewController addGeoTagAnnotations];
        
        if (activeViewController == cameraViewController) {
            
            [geoTagContainer calculateGeoTagPhoneDirectionsWithHeading: heading 
                                                       andAcceleration: rotation];
            
        }
        
        NSLog(@"latitude %+.6f, longitude %+.6f, altitude %+.6f\n",
              currentLocation.coordinate.latitude,
              currentLocation.coordinate.longitude,
              currentLocation.altitude);
    }
    
    //[locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
	NSLog(@"locationError %@", error);
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    if (newHeading.headingAccuracy < 0) {
        
        return;
    
    }
    
    heading = ((newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading);
    
    if (activeViewController == cameraViewController) {
        
        [geoTagContainer calculateGeoTagPhoneDirectionsWithHeading: heading 
                                                   andAcceleration: rotation];
        
    }
    
    NSLog(@"heading: %+.2f", heading);
}

- (CLLocationCoordinate2D) getCoordinate {
    
    if (location) {
        
        return location.coordinate;
        
    } else {
        
        return CLLocationCoordinate2DMake(47.8, 13.08);
        
    }    
}

- (CLLocation*) getCurrentLocation {
	NSLog(@"getCurrentLocation");
	
    if (location) {
        return location;
    } else {
        return [[CLLocation alloc] initWithCoordinate: CLLocationCoordinate2DMake(47.8, 13.08) altitude: 480.0 horizontalAccuracy: 10.0 verticalAccuracy: 10.0];
    }    
}


- (void)startMotionUpdates {
    motionManager = [[CMMotionManager alloc] init];
    [motionManager startAccelerometerUpdates];
    
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                      target:self 
                                                    selector:@selector(doMotionUpdate)
                                                    userInfo:nil 
                                                     repeats:YES];
    
//    [motionManager stopAccelerometerUpdates];
//    [timer invalidate];
}

-(void)doMotionUpdate {
    
    CMAcceleration a = motionManager.accelerometerData.acceleration;
    rotation = [[Vector alloc] initWithX: a.x y: a.y z: a.z];
    
    if (activeViewController == cameraViewController) {
        
        [geoTagContainer calculateGeoTagPhoneDirectionsWithHeading: heading 
                                                   andAcceleration: rotation];
        
    }
    
    NSLog(@"acceleration: %+.2f | %+.2f | %+.2f", a.x, a.y, a.z);
    
}


// TouchDelegate

- (void) switchViews {
    
    [menuViewController.view removeFromSuperview];
    
    if (activeViewController == mapViewController) {
        
        [cameraViewController.cameraOverlayView addSubview: menuViewController.view];
        activeViewController = cameraViewController;
        
    } else {
        
        [mapViewController.view addSubview: menuViewController.view];
        activeViewController = mapViewController;
        
    }
    
    [self.window.rootViewController dismissModalViewControllerAnimated:NO];
    [self.window.rootViewController presentModalViewController: activeViewController animated:NO];
    
}


- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (mapViewController == activeViewController) {
        
        return [mapViewController.mapView hitTest: point withEvent: event];
        
    }
    
    return nil;
}

@end
