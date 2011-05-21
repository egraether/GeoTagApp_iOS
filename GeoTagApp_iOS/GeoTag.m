
#import "GeoTag.h"
#import "Vector.h"


@implementation GeoTag


@synthesize message, author;
@synthesize location;

@synthesize worldDirection, phoneDirection;
@synthesize screenPosition;

@synthesize button;

- (GeoTag*) init {

    self = [super init];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];        
    button.frame = CGRectMake(0, 0, 30, 29);
    
    [button setImage: [UIImage imageNamed:@"map_item.png"] forState:UIControlStateNormal];
    
    [button retain];
    
    return self;

}


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
