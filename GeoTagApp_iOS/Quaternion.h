
#import <Foundation/Foundation.h>

@class Vector;

@interface Quaternion : NSObject {
    
}

@property (nonatomic) float a;
@property (nonatomic, retain) Vector* b;

- (Quaternion*) init;
- (Quaternion*) initWithA: (float)a andB: (Vector*)b;
- (Quaternion*) initWithA: (float)a x: (float)x y: (float)y z: (float)z;

- (Quaternion*) add: (Quaternion*)q;
- (Quaternion*) sub: (Quaternion*)q;

- (Quaternion*) conj;

- (float) normSquared;
- (float) norm;

- (Quaternion*) mul: (Quaternion*) q;
+ (Vector*) rotate: (Vector*)vector byAngle: (float)phi around: (Vector*)axis;

- (void) print;

@end
