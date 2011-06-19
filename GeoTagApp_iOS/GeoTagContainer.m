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
@synthesize screenSize;
@synthesize view;

- (GeoTagContainer*) init {

    self = [super init];

    geoTags = [[NSMutableArray alloc] initWithCapacity:100];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    
    screenSize = CGSizeMake(screenBounds.size.height * screenScale, 
                            screenBounds.size.width * screenScale);
                            
    float angularFOV = 47.5 * M_PI / 180;
    focalLength = screenSize.width / 2 / tanf(angularFOV / 2);
    
    view = [[UIView alloc] init];
    
    return self;

}

- (void) loadGeoTagsByCoordinate: (CLLocationCoordinate2D) coordinate {
    
    NSError* error = NULL;
    
    //SimpleKML *kml = [SimpleKML KMLWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"list" ofType:@"kml"] error:&error];
    
    NSString* url = [NSString stringWithFormat:@"http://sbickt.heroku.com/geotags/list.kml?lat=%f&lng=%f", coordinate.latitude, coordinate.longitude];
    
    SimpleKML *kml = [SimpleKML KMLWithContentsOfURL:[NSURL URLWithString: url] error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
    
    if (kml.feature && [kml.feature isKindOfClass:[SimpleKMLDocument class]]) {
        
        for (SimpleKMLFeature *feature in ((SimpleKMLContainer *)kml.feature).features) {
            
            if ([feature isKindOfClass:[SimpleKMLPlacemark class]] && ((SimpleKMLPlacemark *)feature).point) {
                
                SimpleKMLPoint *point = ((SimpleKMLPlacemark *)feature).point;
                
                GeoTag* geoTag = [[GeoTag alloc] initAtLocation: point.location 
                                                withMessage: feature.featureDescription
                                                andAuthor: feature.name];
                
                [geoTags addObject:geoTag];
                
            }
        }
    }
}

- (void)calculateGeoTagWorldDirectionsAtLocation: (CLLocation*)location {
    
    for (GeoTag* geoTag in geoTags) {
        
        geoTag.worldDirection = [[Vector alloc] initVectorFromLocation:location toLocation:geoTag.location];
        geoTag.worldDirection.z = 0;
        
    }
    
    [geoTags sortUsingFunction:sortByDistance context:@"dist"];
    
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
    
    for (GeoTag* geoTag in geoTags) {
        
        geoTag.phoneDirection = [matrix transformVector: geoTag.worldDirection];
        
        geoTag.screenPosition = [[Vector alloc] init];
        
        geoTag.screenPosition.x = screenSize.width / 2 + geoTag.phoneDirection.y / geoTag.phoneDirection.z * focalLength;
        geoTag.screenPosition.y = screenSize.height / 2 + geoTag.phoneDirection.x / geoTag.phoneDirection.z * focalLength;
        geoTag.screenPosition.z = -geoTag.phoneDirection.z;
        
    }

}

- (void) clearGeoTags {

    [self removeGeoTagViews];

    [geoTags removeAllObjects];

}

- (void) addGeoTagViews {
    
    for (GeoTag* geoTag in geoTags) {
    
        if (geoTag.screenPosition.z > 0.0 && 
            geoTag.screenPosition.x > 0.0 && geoTag.screenPosition.x < screenSize.width &&
            geoTag.screenPosition.y > 0.0 && geoTag.screenPosition.y < screenSize.height) {
    
            geoTag.buttonView.frame = CGRectMake(geoTag.screenPosition.x - 15, geoTag.screenPosition.y - 15, 
                                    geoTag.buttonView.frame.size.width, geoTag.buttonView.frame.size.height);
                                    
//            float scale = 1.5 * (1.0 - geoTag.screenPosition.z / 1000.0);
//            geoTag.buttonView.transform = CGAffineTransformMakeScale(scale, scale);
                                    
            [view addSubview:geoTag.buttonView];
            
        }
    
    }

}

- (void) removeGeoTagViews {
    
    for (GeoTag* geoTag in geoTags) {
        
        [geoTag.buttonView removeFromSuperview];
    
    }

}

@end

NSComparisonResult sortByDistance(GeoTag* firstItem, GeoTag* secondItem, void *context) {
    
    return [[NSNumber numberWithFloat:[secondItem.worldDirection normSquared]] compare: [NSNumber numberWithFloat:[firstItem.worldDirection normSquared]]];
}
