//
//  MapViewController.h
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationDelegate.h"

@class GeoTagContainer;


@interface MapViewController : UIViewController<MKMapViewDelegate> {
    
    GeoTagContainer* geoTagContainer;
    
    IBOutlet MKMapView* mapView;
    
    id<LocationDelegate> delegate;
    
}

@property (nonatomic, assign) MKMapView* mapView;

@property (nonatomic, assign) id<LocationDelegate> delegate;
@property (nonatomic, retain) GeoTagContainer* geoTagContainer;

- (void) addGeoTagAnnotations;
- (void) removeGeoTagAnnotations;

- (MKAnnotationView *)mapView: (MKMapView *)mapView viewForAnnotation: (id <MKAnnotation>)annotation;

@end
