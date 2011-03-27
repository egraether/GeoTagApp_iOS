//
//  GeoTag.h
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface GeoTag : NSObject<MKAnnotation> {
    NSString* message;
    NSString* author;
    
    CLLocation* location;
}


@property (nonatomic, retain) NSString* message;
@property (nonatomic, retain) NSString* author;

@property (nonatomic, retain) CLLocation *location;

- (CLLocationCoordinate2D) coordinate;
- (NSString*) title;
- (NSString*) subtitle;

@end
