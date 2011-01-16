
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface GeoLocationDelegate : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
    
    CLLocation* location;
    CLLocationDirection heading;
    
	id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

@property (nonatomic, retain) CLLocation *location;
@property (nonatomic) CLLocationDirection heading;

@property (nonatomic, assign) id delegate;

- (void)startStandardUpdates;

- (void)locationManager:(CLLocationManager*) manager 
    didUpdateToLocation:(CLLocation*) currentPosition 
           fromLocation:(CLLocation*) previousPosition;

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading;

@end