
#import <Foundation/Foundation.h>

@class Vector;

@interface Quaternion : NSObject {
    
}

@property (nonatomic) float a;
@property (nonatomic, retain) Vector* b;

- (Quaternion*) init;
- (Quaternion*) initWithA: (float)a andB: (Vector*)b;
- (Quaternion*) initWithA: (float)a x: (float)x y: (float)y z: (float)z;
- (Quaternion*) initWithAngle: (float)phi andAxis: (Vector*)axis;

- (Quaternion*) add: (Quaternion*)q;
- (Quaternion*) sub: (Quaternion*)q;

- (Quaternion*) conj;

- (float) normSquared;
- (float) norm;

- (Quaternion*) mul: (Quaternion*) q;
+ (Quaternion*) slerpFrom: (Vector*)from to: (Vector*) to;

+ (Vector*) rotate: (Vector*)v withQuaternion: (Quaternion*)q;
+ (Vector*) rotate: (Vector*)v byAngle: (float)phi around: (Vector*)axis;

- (void) print;

@end
