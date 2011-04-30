//
//  Matrix.h
//  GeoTagApp_iOS
//
//  Created by ebsi on 15.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Vector;

@interface Matrix : NSObject {
    
}

@property (nonatomic, retain) Vector* a;
@property (nonatomic, retain) Vector* b;
@property (nonatomic, retain) Vector* c;

- (Matrix*) init;
- (Matrix*) initWithVectorsA: (Vector*)a  B: (Vector*)b C: (Vector*)c;
- (Matrix*) initTransposedWithVectorsA: (Vector*)a  B: (Vector*)b C: (Vector*)c;

- (Vector*) transformVector: (Vector*)vector;

@end
