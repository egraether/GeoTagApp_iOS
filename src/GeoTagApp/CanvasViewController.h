
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@class CanvasViewController;

@interface CanvasView : UIView {
    
    CanvasViewController* canvasViewController;
    
}

@property (nonatomic, retain) CanvasViewController* canvasViewController;

- (void)drawRect:(CGRect)rect;
- (void)drawPin:(CGContextRef) context;

@end



@interface CanvasViewController : UIViewController {
    
    CanvasView* canvasView;
    
    NSMutableArray* geoTagDirections;
    
}

@property (nonatomic, retain) CanvasView* canvasView;
@property (nonatomic, retain) NSMutableArray* geoTagDirections;


- (void)changeBackground;
- (void)calculateGeoTagDirections: (NSMutableArray*) geoTags 
                       atLocation: (CLLocation*) location 
                      withHeading: (float) heading;

@end