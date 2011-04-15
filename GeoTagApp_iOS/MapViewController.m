//
//  MapViewController.m
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

#import "GeoTag.h"
#import "GeoTagContainer.h"


@implementation MapViewController

@synthesize mapView;

@synthesize delegate;
@synthesize geoTagContainer;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect mapBounds = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);

    mapView = [[MKMapView alloc] initWithFrame: mapBounds];
    [self.view insertSubview:mapView atIndex:0];
    
    mapView.mapType = MKMapTypeStandard;
    
    mapView.zoomEnabled = YES;
    mapView.scrollEnabled = YES;
    mapView.showsUserLocation = YES;
   
    MKCoordinateSpan span;
    span.latitudeDelta = 0.05;
    span.longitudeDelta = 0.05;
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = [delegate getCoordinate];
    
    [mapView setRegion:region animated:TRUE];
    
    mapView.delegate = self;
    
    [self addGeoTagAnnotations];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void) addGeoTagAnnotations {
    
    [mapView addAnnotations: (NSArray*) geoTagContainer.geoTags];
    
//    for (GeoTag* geoTag in geoTagContainer.geoTags) {
//    
//        [mapView addAnnotation: geoTag];
//        
//        NSLog(@"%f, %f", geoTag.coordinate.latitude, geoTag.coordinate.longitude);
//    
//    }

}

- (void) removeGeoTagAnnotations {
    
    [mapView removeAnnotations: (NSArray*) geoTagContainer.geoTags];
    
}

#pragma mark MKMapViewDelegate

- (MKAnnotationView *)mapView: (MKMapView *)mapView viewForAnnotation: (id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:MKUserLocation.class]) {
        return nil;
    }
    
    MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier: @"GeoTag"];
    
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"GeoTag"];
        annotationView.image = [UIImage imageNamed:@"map_item.png"];
    }
    
    return annotationView;
}

@end
