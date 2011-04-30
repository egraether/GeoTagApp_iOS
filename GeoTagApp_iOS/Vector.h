
#import <Foundation/NSObject.h>
#import <CoreLocation/CoreLocation.h>

@interface Vector : NSObject {

}

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float z;

- (Vector*) init;
- (Vector*) initWithX: (float)x y: (float)y z: (float)z;
- (Vector*) initWorldVectorAtCoordinate: (CLLocation*)location;
- (Vector*) initVectorFromLocation: (CLLocation*)from toLocation: (CLLocation*)to;

- (Vector*) add: (Vector*)v;
- (Vector*) sub: (Vector*)v;

- (Vector*) mul: (float)k;
- (Vector*) div: (float)k; 

- (float) normSquared;
- (float) norm;
- (void) normalize;

- (float) dot: (Vector*)v;
- (Vector*) cross: (Vector*)v;

- (float) angle: (Vector*)v;
- (float) projectionLengthOn: (Vector*)v;

- (Vector*) rotate2D: (float) angle;

- (void) print;

@end