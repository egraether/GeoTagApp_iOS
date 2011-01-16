
#import "GeoLocationDelegate.h"

@implementation GeoLocationDelegate

@synthesize locationManager, delegate;

@synthesize location, heading;

- (id)init {
	self = [super init];
    
	return self;
}

- (void)startStandardUpdates {
    
    if (locationManager == nil)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.distanceFilter = 10;
    
    [locationManager startUpdatingLocation];

    if ([CLLocationManager headingAvailable]) {
        locationManager.headingFilter = 5;
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
        NSLog(@"latitude %+.6f, longitude %+.6f, altitude %+.6f\n",
              currentLocation.coordinate.latitude,
              currentLocation.coordinate.longitude,
              currentLocation.altitude);
        
        self.location = currentLocation;
    }
    
    //[locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    if (newHeading.headingAccuracy < 0)
        return;
      
    self.heading = ((newHeading.trueHeading > 0) ? newHeading.trueHeading : newHeading.magneticHeading);
    
    NSLog(@"heading %+.6f", self.heading);
}

- (void)dealloc {
	[self.locationManager release];
	[super dealloc];
}

@end