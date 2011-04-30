//
//  LocationDelegate.h
//  GeoTagApp_iOS
//
//  Created by thomas.probook on 15.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@protocol LocationDelegate

- (CLLocationCoordinate2D)getCoordinate;

- (CLLocation*) getCurrentLocation;

@end
