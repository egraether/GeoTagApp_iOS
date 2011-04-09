
#import <Foundation/NSObject.h>
#import <CoreLocation/CoreLocation.h>

@interface Vector : NSObject {

}

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float z;

- (Vector*) init;
- (Vector*) initWithX: (float)x y: (float)y z: (float)z;

- (Vector*) add: (Vector*)v;
- (Vector*) sub: (Vector*)v;

- (Vector*) mul: (float)k;
- (Vector*) div: (float)k;

- (float) normSquared;
- (float) norm;

- (float) dot: (Vector*)v;
- (float) angle: (Vector*)v;

- (void) setWorldVectorAtCoordinate: (CLLocationCoordinate2D) coordinate;
- (Vector*) rotate2D: (float) angle;

- (void) print;

@end