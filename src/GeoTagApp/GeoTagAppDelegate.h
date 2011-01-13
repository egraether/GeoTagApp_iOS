//
//  GeoTagAppDelegate.h
//  GeoTag
//
//  Created by ebsi on 13.01.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GeoTagViewController;

@interface GeoTagAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GeoTagViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet GeoTagViewController *viewController;

@end

