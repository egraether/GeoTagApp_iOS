
#import "Quaternion.h"
#import "Vector.h"


@implementation Quaternion

@synthesize a, b;

- (Quaternion*) init {

    self = [super init];
    
    b = [[Vector alloc] init];
    
    return self;

}

- (Quaternion*) initWithA: (float)a andB: (Vector*)b {
    
    self = [super init];
    
    self.a = a;
    self.b = b;
    
    return self;
}

- (Quaternion*) initWithA: (float)a x: (float)x y: (float)y z: (float)z {

    self = [super init];
    
    self.a = a;
    
    b = [[Vector alloc] initWithX:x y:y z:z];
    
    return self;
}

- (Quaternion*) add: (Quaternion*)q {

    Quaternion* r = [[Quaternion alloc] init];
    
    r.a = a + q.a;
    r.b = [b add: q.b];
    
    return r;
}


- (Quaternion*) sub: (Quaternion*)q {

    Quaternion* r = [[Quaternion alloc] init];
    
    r.a = a - q.a;
    r.b = [b sub: q.b];
    
    return r;

}

- (Quaternion*) conj {

    return [[Quaternion alloc] initWithA: a andB: [b mul: -1]];
    
}

- (float) normSquared {

    return a * a + [b dot:b];

}

- (float) norm {
    
    return sqrtf([self normSquared]);
    
}

- (Quaternion*) mul: (Quaternion*)q {

    return [[Quaternion alloc] initWithA: a * q.a - b.x * q.b.x - b.y * q.b.y - b.z * q.b.z
                                       x: a * q.b.x + b.x * q.a + b.y * q.b.z - b.z * q.b.y
                                       y: a * q.b.y - b.x * q.b.z + b.y * q.a + b.z * q.b.x
                                       z: a * q.b.z + b.x * q.b.y - b.y * q.b.x + b.z * q.a];
    
}

+ (Vector*) rotate: (Vector*)vector byAngle: (float)phi around: (Vector*)axis {
    
    axis = [[axis div: [axis norm]] mul: sinf(phi / 2)];
    
    Quaternion* q = [[Quaternion alloc] initWithA: cosf(phi / 2) andB: axis];
    Quaternion* p = [[Quaternion alloc] initWithA: 0 andB: vector];
    
    p = [[q mul: p] mul: [q conj]];
    
    return p.b;

}

- (void) print {
    
    NSLog(@"%+.2f - ", a);
    [b print];
    
}

@end
