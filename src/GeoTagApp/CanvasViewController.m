
#import "CanvasViewController.h"
#import "Vector.h"

#import "SimpleKML.h"
#import "SimpleKMLPlacemark.h"
#import "SimpleKMLPoint.h"

@implementation CanvasView

@synthesize canvasViewController;

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    Vector* v = [[Vector alloc] initWithX:0 y:1 z:0];
    
    float screenAngle = 0.4297663;
    
    
    CGContextTranslateCTM(context, self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    if (canvasViewController.geoTagDirections != nil) {
        
        for (int i = 0; i < [canvasViewController.geoTagDirections count]; i++) {

            float angle = [[canvasViewController.geoTagDirections objectAtIndex:i] angle: v];
            
            if (abs(angle) <= screenAngle) {
            
                CGContextSaveGState(context);
                
                CGContextTranslateCTM(context, 0, angle / screenAngle * self.bounds.size.height / 2);
                [self drawPin: context];
                
                CGContextRestoreGState(context);
                
            }
        
        }
        
    }
}

- (void) drawPin:(CGContextRef) context {
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 10, 0);
    CGContextAddLineToPoint(context, 0, 10);
    CGContextAddLineToPoint(context, -10, 0);
    CGContextAddLineToPoint(context, 0, -10);
    CGContextClosePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
}

@end


@implementation CanvasViewController

@synthesize canvasView, geoTagDirections;

- (id)init {
    
    return [super init];

}

- (void)loadView {
    [super loadView];
    
    self.wantsFullScreenLayout = YES;
    
    CanvasView* canvas = [[CanvasView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    [self.view addSubview:canvas];
    
    self.canvasView = canvas;
    canvas.canvasViewController = self;
    
    [canvas release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeBackground];
}

- (void)changeBackground {

    canvasView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
}

- (void)dealloc {
    
    canvasView = nil;
    
    [super dealloc];
    
}

- (void)calculateGeoTagDirections: (NSMutableArray*) geoTags 
                       atLocation: (CLLocation*) location 
                      withHeading: (float) heading {
    
    
    Vector* p = [[Vector alloc] init];
    [p setWorldVectorAtCoordinate:location.coordinate];
    
    geoTagDirections = [[NSMutableArray alloc] initWithCapacity:100];
    
    for (int i = 0; i < [geoTags count]; i++) {
        
        Vector* v = [[Vector alloc] init];
        [v setWorldVectorAtCoordinate:((SimpleKMLPlacemark *)[geoTags objectAtIndex:i]).point.coordinate];
        
        v = [v subtract:p];
        v = [v rotate2D:heading + 90];
        
        [geoTagDirections addObject:v];
        
    }
    
    [canvasView setNeedsDisplay];

}

@end



//    CGContextRef context = CGLayerGetContext(canvas.layer);
//    CGLayerRef layer = CGLayerCreateWithContext(context, CGLayerGetSize(canvas.layer), NULL);
//    
//    CGContextRef ctx = CGLayerGetContext(layer);
//    
//    float blue[4] = {0, 0, 1, 1};
//	CGContextSetFillColor(ctx, blue);
//    
//    
//    
//    CGContextDrawLayerAtPoint(context, CGPointZero, layer); 
//    CGLayerRelease(layer);

//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(context, 100, 100);
//    CGContextAddLineToPoint(context, 150, 150);
//    CGContextAddLineToPoint(context, 100, 200);
//    CGContextAddLineToPoint(context, 50, 150);
//    CGContextAddLineToPoint(context, 100, 100);
//    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//    CGContextFillPath(context);
//    
//    CGContextFillRect(context, CGRectMake(0, 0, 10, 20));


//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSaveGState(context);
//    
//    CGAffineTransform t0 = CGContextGetCTM(context); 
//    t0 = CGAffineTransformInvert(t0);
//    CGContextConcatCTM(context, t0);
//    
//    CGContextBeginPath(context);
//    
//    CGContextSetRGBFillColor(context, 0,1,0,1);
//    
//    CGContextAddRect(context, CGRectMake(0,0,100,200)); 
//    
//    CGContextClosePath(context); 
//    
//    CGContextDrawPath(context,kCGPathFill);
//    
//    CGContextRestoreGState(context);