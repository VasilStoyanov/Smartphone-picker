//
//  Phone.h
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/3/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Phone : NSObject

@property (nonatomic, strong) NSString *model;

@property (nonatomic, strong) NSString *manufacturer;

@property double price;

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *OS;

//@property (nonatomic, strong) NSString *description;

-(instancetype) initWithModel: (NSString *) model
                  manufacturer: (NSString *) manufacturer
                         price: (double) price
                         image: (NSString *) image
                         andOS: (NSString *) OS;

@end
