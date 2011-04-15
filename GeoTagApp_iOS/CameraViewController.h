
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@class GeoTagContainer;
@class Vector;

@interface CameraViewController : UIViewController { //UIImagePickerController {
    
}

@property (nonatomic, retain) GeoTagContainer* geoTagContainer;

- (void)calculateGeoTagDirectionsAtLocation: (CLLocation*)location 
                                withHeading: (float)heading
                                andRotation: (Vector*)rotation;

@end
