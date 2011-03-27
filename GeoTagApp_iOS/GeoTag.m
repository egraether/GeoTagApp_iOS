//
//  GeoTag.m
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GeoTag.h"


@implementation GeoTag

@synthesize message;
@synthesize author;
@synthesize location;

- (CLLocationCoordinate2D) coordinate {
    return location.coordinate;
}

- (NSString*) title {
    return author;
}

- (NSString*) subtitle {
    return message;
}

@end
