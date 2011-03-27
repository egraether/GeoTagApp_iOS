//
//  GeoTagContainer.m
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GeoTagContainer.h"
#import "GeoTag.h"

#import "SimpleKML.h"
#import "SimpleKMLDocument.h"
#import "SimpleKMLContainer.h"
#import "SimpleKMLPlacemark.h"
#import "SimpleKMLPoint.h"


@implementation GeoTagContainer


@synthesize geoTags;

- (void) loadGeoTagsByCoordinate: (CLLocationCoordinate2D) coordinate {
    
    NSError* error = NULL;
    
    //SimpleKML *kml = [SimpleKML KMLWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list" ofType:@"kml"] error:&error];
    
    NSString* url = [NSString stringWithFormat:@"http://sbickt.heroku.com/geotags/list.kml?lat=%f&lng=%f", coordinate.latitude, coordinate.longitude];
    
    SimpleKML *kml = [SimpleKML KMLWithContentsOfURL:[NSURL URLWithString: url] error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    geoTags = [[NSMutableArray alloc] initWithCapacity:100];
    
    if (kml.feature && [kml.feature isKindOfClass:[SimpleKMLDocument class]]) {
        
        for (SimpleKMLFeature *feature in ((SimpleKMLContainer *)kml.feature).features) {
            
            if ([feature isKindOfClass:[SimpleKMLPlacemark class]] && ((SimpleKMLPlacemark *)feature).point) {
                
                SimpleKMLPoint *point = ((SimpleKMLPlacemark *)feature).point;
                
                GeoTag* geoTag = [[GeoTag alloc] init];
                
                geoTag.message = ((SimpleKMLPlacemark *)feature).featureDescription;
                geoTag.author = ((SimpleKMLPlacemark *)feature).name;
                geoTag.location = point.location;
                
                [geoTags addObject:geoTag];
                
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
}

@end
