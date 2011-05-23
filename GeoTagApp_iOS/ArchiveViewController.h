//
//  ArchiveViewController.h
//  GeoTagApp_iOS
//
//  Created by thomas.probook on 21.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArchiveTableViewCell.h"


@interface ArchiveViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	
	IBOutlet UIButton* backButton;
	IBOutlet UITableView* archiveTableView;
	
	IBOutlet ArchiveTableViewCell* archiveTableViewCell;
	
	NSArray* geoTags;

}

@property (nonatomic, retain) NSArray* geoTags;
//@property (nonatomic, assign) ArchiveTableViewCell* archiveTableViewCell;


- (void) updateGeoTags;
- (IBAction) pressBackButton;


@end
