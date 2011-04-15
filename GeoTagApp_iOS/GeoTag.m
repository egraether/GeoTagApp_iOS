
#import "GeoTag.h"
#import "Vector.h"


@implementation GeoTag


@synthesize message, author;
@synthesize location;

@synthesize direction;


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
