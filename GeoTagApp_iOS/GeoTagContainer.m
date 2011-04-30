//
//  GeoTagContainer.m
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GeoTagContainer.h"
#import "GeoTag.h"

#import "Vector.h"
#import "Matrix.h"

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
                
//                NSLog(@"coordinates: %f - %f - %f", point.coordinate.latitude, point.coordinate.longitude, point.altitude);
            }
            
//            if (((SimpleKMLPlacemark *)feature).name) {
//                
//                NSLog(@"name: %@", ((SimpleKMLPlacemark *)feature).name);
//                
//            }
//            
//            if (((SimpleKMLPlacemark *)feature).featureDescription) {
//                
//                NSLog(@"description: %@", ((SimpleKMLPlacemark *)feature).featureDescription);
//                
//            }
        }
    }
    
    NSLog(@"geotags loaded");
}

- (void)calculateGeoTagWorldDirectionsAtLocation: (CLLocation*)location {
    
    for (GeoTag* geoTag in geoTags) {
        
        geoTag.worldDirection = [[Vector alloc] initVectorFromLocation:location toLocation:geoTag.location];
        
    }
    
    NSLog(@"geotags worldDirections calculated");
    
}

- (void) calculateGeoTagPhoneDirectionsWithHeading: (float)heading 
                                   andAcceleration: (Vector*)acceleration {
    
    float phi = heading * M_PI / 180;
    
    Vector* right = [[Vector alloc] initWithX: 0 y: sinf(phi) z: -cosf(phi)];
    
    Vector* z = [acceleration mul: -1];
    [z normalize];
    
    Vector* y = [z cross: right];
    [y normalize];
    
    Vector* x = [y cross: z];
    [x normalize];
    
    Matrix* matrix = [[Matrix alloc] initTransposedWithVectorsA: x B: y C: z];
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    
    CGSize screenSize = CGSizeMake(screenBounds.size.height * screenScale, 
                                   screenBounds.size.width * screenScale);
    
    float angularFOV = 47.5 * M_PI / 180;
    float focalLength = screenSize.width / 2 / tanf(angularFOV / 2);
    
    Vector* worldDirection = [[Vector alloc] initWithX: 100 y: 0 z: 0];
    Vector* phoneDirection = [matrix transformVector: worldDirection];
    
    [phoneDirection print];
    
    Vector* screenPosition = [[Vector alloc] init];
    
    screenPosition.y = screenSize.height / 2 - phoneDirection.x / (-phoneDirection.z) * focalLength;
    screenPosition.x = screenSize.width / 2 - phoneDirection.y / (-phoneDirection.z) * focalLength;
    screenPosition.z = -phoneDirection.z;
    
    [screenPosition print];
    
//    for (GeoTag* geoTag in geoTags) {
//        
//        geoTag.phoneDirection = [[matrix transformVector: geoTag.worldDirection] rotate2D: M_PI / 2];
//        geoTag.phoneDirection.x *= -1;
//        
//        [geoTag.phoneDirection print];
//        
//        geoTag.screenPosition = [[Vector alloc] init];
//        geoTag.screenPosition.x = geoTag.phoneDirection.x / -geoTag.phoneDirection.z * focalLength - screenSize.width / 2;
//        geoTag.screenPosition.y = geoTag.phoneDirection.y / -geoTag.phoneDirection.z * focalLength - screenSize.height / 2;
//        geoTag.screenPosition.z = -geoTag.phoneDirection.z;
//        
//        [geoTag.screenPosition print];
//        
//        break;
//        
//    }
    
    //    [self.view setNeedsDisplay];
    
    NSLog(@"geotags phoneDirections calculated");
}

@end
