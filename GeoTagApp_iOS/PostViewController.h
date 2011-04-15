//
//  PostViewController.h
//  GeoTagApp_iOS
//
//  Created by thomas.probook on 13.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationDelegate

- (CLLocationCoordinate2D)getCoordinate;

- (CLLocation*) getCurrentLocation;

@end

@interface PostViewController : UIViewController {

	IBOutlet UIButton* categoryPrivateButton;
    IBOutlet UIButton* categoryFriendsButton;
    IBOutlet UIButton* categoryPublicButton;
    IBOutlet UIButton* backButton;
    IBOutlet UIButton* postButton;
	IBOutlet UITextView* textField;

	id<LocationDelegate> locationDelegate;

}

@property (nonatomic, assign) id<LocationDelegate> locationDelegate;
@property (nonatomic, retain) UITextView *textField;

- (IBAction) pressBackButton;
- (IBAction) pressPostButton;

@end
