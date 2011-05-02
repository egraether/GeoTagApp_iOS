//
//  AuthorizationViewController.h
//  GeoTagApp_iOS
//
//  Created by thomas.probook on 30.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuthorizationViewController : UIViewController {
	
	IBOutlet UITextField *usernameField;
	IBOutlet UITextField *passwordField;
	IBOutlet UIButton *loginButton;
	IBOutlet UIButton *backButton;
	
}

@property (nonatomic, retain) UITextField *usernameField;
@property (nonatomic, retain) UITextField *passwordField;

- (IBAction) pressBackButton;
- (IBAction) pressLoginButton;
- (void) loginWithUsername:(NSString *) username password:(NSString *) password;

@end
