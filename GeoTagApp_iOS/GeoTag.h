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

    UIImageView* imageView;
    UITextView* messageView;
    UITextView* authorView;

    NSString* message;
    NSString* author;

}

@property (nonatomic, retain) UIButton* buttonView;
@property (nonatomic, retain) CLLocation* location;

@property (nonatomic, retain) Vector* worldDirection;
@property (nonatomic, retain) Vector* phoneDirection;

@property (nonatomic, retain) Vector* screenPosition;

- (GeoTag*) initAtLocation: (CLLocation*)_location 
               withMessage: (NSString*)_message 
                 andAuthor: (NSString*)_author;

- (CLLocationCoordinate2D) coordinate;
- (NSString*) title;
- (NSString*) subtitle;

@end
