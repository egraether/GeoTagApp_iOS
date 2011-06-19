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
@class GeoTag;

@interface GeoTagContainer : NSObject {

    float focalLength;
    
}

@property (nonatomic, retain) UIView* view;
@property (nonatomic, retain) NSMutableArray* geoTags;
@property (nonatomic) CGSize screenSize;

- (GeoTagContainer*) init;

- (void) loadGeoTagsByCoordinate: (CLLocationCoordinate2D) coordinate;
- (void) calculateGeoTagWorldDirectionsAtLocation: (CLLocation*)location;
- (void) calculateGeoTagPhoneDirectionsWithHeading: (float)heading andAcceleration: (Vector*)acceleration;

- (void) clearGeoTags;
- (void) addGeoTagViews;
- (void) removeGeoTagViews;

@end

NSComparisonResult sortByDistance(GeoTag* firstItem, GeoTag* secondItem, void *context);
