
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

- (Vector*) add: (Vector*)v {

    Vector* a = [[Vector alloc] init];
    
    a.x = x + v.x;
    a.y = y + v.y;
    a.z = z + v.z;
    
    return a;
}

- (Vector*) subtract: (Vector*)v {
    
    Vector* a = [[Vector alloc] init];
    
    a.x = x - v.x;
    a.y = y - v.y;
    a.z = z - v.z;
    
    return a;
}

- (Vector*) multiply: (float)k {

    Vector* a = [[Vector alloc] init];
    
    a.x = x * k;
    a.y = y * k;
    a.z = z * k;
    
    return a;
}

- (Vector*) divide: (float)k {

    Vector* a = [[Vector alloc] init];
    
    a.x = x / k;
    a.y = y / k;
    a.z = z / k;
    
    return a;

}

- (float) norm {

    return sqrt(x * x + y * y + z * z);
}

- (float) dot: (Vector*)v {
    
    return x * v.x + y * v.y + z * v.z;
    
}

- (float) angle: (Vector*)v {

    return acos([self dot:v] / [self norm] / [v norm]);

}

- (void) setWorldVectorAtCoordinate: (CLLocationCoordinate2D) coordinate {
    
    float longitude = coordinate.longitude * M_PI / 180;
    float latitude = coordinate.latitude * M_PI / 180;
    
    x = cos(longitude) * cos(latitude) * 6371000.785;
    y = sin(longitude) * cos(latitude) * 6371000.785;
    z = sin(latitude) * 6371000.785;
    
}

- (Vector*) rotate2D: (float) angle {
    
    Vector* a = [[Vector alloc] init];
    
    angle *= M_PI / 180;
    
    a.x = x * cos(angle) - y * sin(angle);
    a.y = x * sin(angle) + y * cos(angle);
    
    return a;
    
    
}

- (void) print {

    NSLog(@"( %+.2f | %+.2f | %+.2f )", x, y, z);
    
}

@end