//
//  GeoTagApp_iOSAppDelegate.h
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>

#import "LocationDelegate.h"
#import "MenuViewController.h"


@class GeoTagContainer;
@class Vector;

@class MapViewController;


@interface GeoTagApp_iOSAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate, LocationDelegate, TouchDelegate> {
    
    IBOutlet MapViewController* mapViewController;
    IBOutlet MenuViewController* menuViewController;
    
    UIImagePickerController* cameraViewController;
    UIViewController* activeViewController;
    
    CMMotionManager* motionManager;
    
    GeoTagContainer* geoTagContainer;
    
    CLLocationManager *locationManager;
    
    CLLocation *location;
    CLLocationDirection heading;
    Vector* rotation;
    
//    NSMutableArray* headingDeque;
    NSMutableArray* rotationDeque;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void) initCameraView;

- (void) locationChanged;
- (void) rotationChanged;

// Location

- (void)startLocationUpdates;

- (void)locationManager:(CLLocationManager*) manager 
    didUpdateToLocation:(CLLocation*) currentPosition 
           fromLocation:(CLLocation*) previousPosition;

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading;

- (CLLocationCoordinate2D)getCoordinate;
- (CLLocation*)getCurrentLocation;

// Motion

- (void)startMotionUpdates;
- (void)doMotionUpdate;


// TouchDelegate

- (void) switchViews;
- (UIView*) hitTest: (CGPoint)point withEvent: (UIEvent *)event;

@end
