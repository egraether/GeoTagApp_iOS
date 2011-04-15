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

#import "MapViewController.h"
#import "CameraViewController.h"
#import "MenuViewController.h"

@class GeoTagContainer;


@interface GeoTagApp_iOSAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate, LocationDelegate, TouchDelegate> {
    
    IBOutlet CameraViewController* cameraViewController;
    IBOutlet MapViewController* mapViewController;
    IBOutlet MenuViewController* menuViewController;
    
    UIViewController* activeViewController;
    
    CMMotionManager* motionManager;
    
    GeoTagContainer* geoTagContainer;
    
    CLLocationManager *locationManager;
    
    CLLocation *location;
    CLLocationDirection heading;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

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

- (void)switchViews;
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end
