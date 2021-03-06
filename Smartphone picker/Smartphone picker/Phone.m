//
//  Phone.m
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/3/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import "Phone.h"

@implementation Phone

-(instancetype) initWithModel:(NSString *)model
                 manufacturer:(NSString *)manufacturer
                        price:(double)price
                        image:(UIImage *)image
                  description: (NSString *)description
                        andOS:(NSString *)OS {
    
    Phone *result = [[Phone alloc]init];
    result.model = model;
    result.manufacturer = manufacturer;
    result.price = price;
    result.deviceDescription = description;
    result.image = image;
    result.OS = OS;
    
    return result;
}

-(UIImage *) getImage {
    return self.image;
}

@end
