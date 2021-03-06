//
//  MenuViewController.h
//  GeoTagApp_iOS
//
//  Created by ebsi on 27.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PostViewController;
@class AuthorizationViewController;
@class ArchiveViewController;

@protocol TouchDelegate

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
- (void) switchViews;

@end



@interface TouchView : UIView {
}

@property (nonatomic, assign) id<TouchDelegate> delegate;

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;

@end


@interface MenuViewController : UIViewController {
    
    IBOutlet UIButton* menuClosedButton;
    IBOutlet UIButton* menuOpenButton;
    IBOutlet UIButton* postButton;
    IBOutlet UIButton* profileButton;
    IBOutlet UIButton* archiveButton;
    IBOutlet UIButton* friendsButton;
    IBOutlet UIButton* mapViewButton;
    IBOutlet UIButton* cameraViewButton;
    
    TouchView* touchView;
	
	IBOutlet PostViewController *postViewController;
	IBOutlet AuthorizationViewController *authorizationViewController;
	IBOutlet ArchiveViewController *archiveViewController;
}

@property (nonatomic, retain) TouchView* touchView;
@property (nonatomic, retain) PostViewController *postViewController;
@property (nonatomic, retain) AuthorizationViewController *authorizationViewController;
@property (nonatomic, retain) ArchiveViewController *archiveViewController;

- (IBAction) toggleViewIcon;
- (IBAction) toggleMenu;
- (IBAction) pressPostButton;
- (IBAction) pressProfileButton;
- (IBAction) pressArchiveButton;
- (IBAction) pressFriendsButton;

@end
