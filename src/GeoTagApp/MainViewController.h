

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <CoreLocation/CoreLocation.h>


@class CanvasViewController;
@class GeoLocationDelegate;

@interface GeoTagViewController : UIViewController {
    
    IBOutlet UIImageView *camera;
    
    CanvasViewController *canvasViewController;
    GeoLocationDelegate* geoLocationDelegate;
    
    CMMotionManager* motionManager;
    
    NSMutableArray* geoTags;

}

@property (nonatomic, retain) UIImageView *camera;
@property (nonatomic, retain) CMMotionManager* motionManager;
@property (nonatomic, retain) NSMutableArray* geoTags;

- (void)doGeoTagDraw;

- (void)startMotionUpdates;
- (void)doMotionUpdate;

- (void) loadGeoTagsByLocation: (CLLocation*) location;

- (IBAction) press;

@end

