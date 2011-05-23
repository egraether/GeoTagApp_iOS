//
//  ArchiveTableViewCell.m
//  GeoTagApp_iOS
//
//  Created by thomas.probook on 23.05.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ArchiveTableViewCell.h"


@implementation ArchiveTableViewCell

@synthesize messageLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}

- (void) setMessage:(NSString*) message {
	messageLabel.text = message;
}

- (NSString*) getMessage {
	return messageLabel.text;
}

@end
