//
//  GeoTag.h
//  GeoTagApp_iOS
//
//  Created by ebsi on 26.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@class Vector;

@interface GeoTag : NSObject<MKAnnotation> {

}

@property (nonatomic, retain) UIButton* button;

@property (nonatomic, retain) NSString* message;
@property (nonatomic, retain) NSString* author;

@property (nonatomic, retain) CLLocation* location;

@property (nonatomic, retain) Vector* worldDirection;
@property (nonatomic, retain) Vector* phoneDirection;

@property (nonatomic, retain) Vector* screenPosition;

- (GeoTag*) init;

- (CLLocationCoordinate2D) coordinate;
- (NSString*) title;
- (NSString*) subtitle;

@end
