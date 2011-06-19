
#import "GeoTag.h"
#import "Vector.h"


@implementation GeoTag


@synthesize location;

@synthesize worldDirection, phoneDirection;
@synthesize screenPosition;

@synthesize buttonView;

- (GeoTag*) initAtLocation: (CLLocation*)_location 
               withMessage: (NSString*)_message 
                 andAuthor: (NSString*)_author {

    self = [super init];
    
    location = _location;
    message = _message;
    author = _author;
    
    [location retain];
    [message retain];
    [author retain];
    
    buttonView = [UIButton buttonWithType:UIButtonTypeCustom];        
    
    imageView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"map_item.png"]];
    [buttonView addSubview: imageView];
    
    messageView = [[UITextView alloc] initWithFrame:CGRectMake(30, 0, 170, 1000)];
    messageView.text = message;
    [buttonView addSubview: messageView];
    messageView.frame = CGRectMake(30, 0, 170, messageView.contentSize.height * 1.2);
    
    authorView = [[UITextView alloc] init];
    authorView.text = author;
    authorView.textColor = [UIColor colorWithRed:0.071 green:0.369 blue:0.145 alpha:1.0];
    [buttonView addSubview: authorView];
    authorView.frame = CGRectMake(30, messageView.contentSize.height, 170, authorView.contentSize.height);
    
    buttonView.frame = CGRectMake(0, 0, 200, messageView.contentSize.height + authorView.contentSize.height);
    //[buttonView setImage: [UIImage imageNamed:@"map_item.png"] forState:UIControlStateNormal];
    
    [buttonView retain];
    
    return self;

}


- (CLLocationCoordinate2D) coordinate {
    return location.coordinate;
}

- (NSString*) title {
    return author;
}

- (NSString*) subtitle {
    return message;
}

@end
