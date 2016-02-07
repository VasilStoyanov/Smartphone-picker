//
//  PhonesBase.m
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/7/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import "PhonesBase.h"
#import "Phone.h"

@implementation PhonesBase {
    Phone *p1;
    Phone *p2;
    Phone *p3;
    Phone *p4;
    Phone *p5;
    Phone *p6;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(NSMutableArray*) phoneBase {
    static NSMutableArray* theArray = nil;
    if (theArray == nil)
    {
        theArray = [[NSMutableArray alloc] init];
    }
    
    p1 = [[Phone alloc]initWithModel:@"One M8" manufacturer:@"HTC" price:1200 image:[UIImage imageNamed:@"htcM8"] andOS:@"Android"];
    
    p2 = [[Phone alloc]initWithModel:@"Galaxy S6" manufacturer:@"Samsung" price:1220 image:[UIImage imageNamed:@"galaxyS6"] andOS:@"Android"];
    
    p3 = [[Phone alloc]initWithModel:@"Galaxy S6 Edge" manufacturer:@"Samsung" price:1400 image:[UIImage imageNamed:@"galaxyS6Edge"] andOS:@"Android"];
    
    p4 = [[Phone alloc]initWithModel:@"Nexus 5" manufacturer:@"Google" price:1000 image:[UIImage imageNamed:@"nexus5"] andOS:@"Android"];
    
    p5 = [[Phone alloc]initWithModel:@"G4" manufacturer:@"LG" price:1500 image:[UIImage imageNamed:@"lgg4"] andOS:@"Android"];
    
    p6 = [[Phone alloc]initWithModel:@"iPhone 5s" manufacturer:@"Apple" price:2200 image:[UIImage imageNamed:@"iphone5s"] andOS:@"iOS"];
    
    if(theArray.count <= 0) {
        theArray = [NSMutableArray arrayWithObjects:p1,p2,p3,p4,p5,p6, nil];
    }

    return theArray;
}

@end
