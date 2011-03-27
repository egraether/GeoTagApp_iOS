//
//  GeoTagContainer.h
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface GeoTagContainer : NSObject {
    
    NSMutableArray* geoTags;
    
}

@property (nonatomic, retain) NSMutableArray* geoTags;

- (void) loadGeoTagsByCoordinate: (CLLocationCoordinate2D) coordinate;

@end
