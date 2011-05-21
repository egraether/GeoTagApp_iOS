//
//  GeoTagContainer.h
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class Vector;

@interface GeoTagContainer : NSObject {
    
    NSMutableArray* geoTags;
    
}

@property (nonatomic, retain) NSMutableArray* geoTags;

- (GeoTagContainer*) init;

- (void) loadGeoTagsByCoordinate: (CLLocationCoordinate2D) coordinate;
- (void) calculateGeoTagWorldDirectionsAtLocation: (CLLocation*)location;
- (void) calculateGeoTagPhoneDirectionsWithHeading: (float)heading andAcceleration: (Vector*)acceleration;

- (void) clearGeoTags;
- (void) removeGeoTagViews;

@end
