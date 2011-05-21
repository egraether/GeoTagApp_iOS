//
//  Matrix.m
//  GeoTagApp_iOS
//
//  Created by ebsi on 15.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Matrix.h"
#import "Vector.h"


@implementation Matrix

@synthesize a, b, c;

- (Matrix*) init {
    
    self = [super init];
    
    [a init];
    [b init];
    [c init];
    
    return self;

}

- (Matrix*) initWithVectorsA: (Vector*)_a  B: (Vector*)_b C: (Vector*)_c {

    self = [super init];
    
    a = _a;
    b = _b;
    c = _c;
    
    return self;
    
}

- (Matrix*) initTransposedWithVectorsA: (Vector*)a  B: (Vector*)b C: (Vector*)c {

    self = [super init];
    
    self.a = [[Vector alloc] initWithX: a.x y: b.x z: c.x];
    self.b = [[Vector alloc] initWithX: a.y y: b.y z: c.y];
    self.c = [[Vector alloc] initWithX: a.z y: b.z z: c.z];
    
    return self;

}

- (Vector*) transformVector: (Vector*)vector {

    return [[Vector alloc] initWithX: [a dot: vector] 
                                   y: [b dot: vector] 
                                   z: [c dot: vector]]; 

}

@end
