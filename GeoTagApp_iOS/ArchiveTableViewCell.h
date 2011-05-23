//
//  ArchiveTableViewCell.h
//  GeoTagApp_iOS
//
//  Created by thomas.probook on 23.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ArchiveTableViewCell : UITableViewCell {
	
	IBOutlet UILabel* messageLabel;

}

@property (nonatomic, retain) UILabel* messageLabel;

- (void) setMessage:(NSString*) message;
- (NSString*) getMessage;

@end
