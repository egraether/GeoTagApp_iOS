
#import "Vector.h"

@implementation Vector

@synthesize x, y, z;

- (Vector*) init {

    self = [super init];
    
    x = y = z = 0;
    
    return self;

}

- (Vector*) initWithX: (float)x y: (float)y z: (float)z {
    
    self = [super init];

    self.x = x;
    self.y = y;
    self.z = z;
    
    return self;
    
}

- (Vector*) initWorldVectorAtCoordinate: (CLLocation*)location; {
    
    self = [super init];
    
    float longitude = location.coordinate.longitude * M_PI / 180;
    float latitude = location.coordinate.latitude * M_PI / 180;
    
    x = cos(longitude) * cos(latitude);
    y = sin(longitude) * cos(latitude);
    z = sin(latitude);
    
    [self mul: 6371000.785 + location.altitude];
    
    return self;
    
}

- (Vector*) initVectorFromLocation: (CLLocation*)from toLocation: (CLLocation*)to {
    
    self = [super init];
    
    float radius = 6371000.785;
    
    y = (to.coordinate.longitude - from.coordinate.longitude) * radius * M_PI / 180;
    x = (to.coordinate.latitude - from.coordinate.latitude) * radius * M_PI / 180;
    z = to.altitude - from.altitude;
    
    return self;
    
}

- (Vector*) add: (Vector*)v {

    Vector* a = [[Vector alloc] init];
    
    a.x = x + v.x;
    a.y = y + v.y;
    a.z = z + v.z;
    
    return a;
}

- (Vector*) sub: (Vector*)v {
    
    Vector* a = [[Vector alloc] init];
    
    a.x = x - v.x;
    a.y = y - v.y;
    a.z = z - v.z;
    
    return a;
}

- (Vector*) mul: (float)k {

    Vector* a = [[Vector alloc] init];
    
    a.x = x * k;
    a.y = y * k;
    a.z = z * k;
    
    return a;
}

- (Vector*) div: (float)k {

    Vector* a = [[Vector alloc] init];
    
    if (k != 0) {
        
        a.x = x / k;
        a.y = y / k;
        a.z = z / k;
    }
    
    return a;

}

- (float) normSquared {
    
    return [self dot:self];

}

- (float) norm {

    return sqrt([self normSquared]);
    
}

- (void) normalize {

    [self div: [self norm]];
    
}

- (float) dot: (Vector*)v {
    
    return x * v.x + y * v.y + z * v.z;
    
}

- (Vector*) cross: (Vector*)v {
    
    return [[Vector alloc] initWithX: y * v.z - z * v.y
                                   y: z * v.x - x * v.z 
                                   z: x * v.y - y * v.x];
    
}

- (float) angle: (Vector*)v {
    
    if ([self normSquared] && [v normSquared]) {
        
        return acos([self dot:v] / [self norm] / [v norm]);
        
    } else {
    
        return 0;
        
    }
}

- (float) projectionLengthOn:(Vector *)v {

    return [self dot:v] / [self norm];
    
}

- (Vector*) rotate2D: (float) angle {
    
    Vector* a = [[Vector alloc] init];
    
    a.x = x * cos(angle) - y * sin(angle);
    a.y = x * sin(angle) + y * cos(angle);
    
    return a;
    
}

- (void) print {

    NSLog(@"( %+.2f | %+.2f | %+.2f )", x, y, z);
    
}

@end