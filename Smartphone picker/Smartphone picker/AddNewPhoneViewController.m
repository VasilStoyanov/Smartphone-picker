//
//  AddNewPhoneViewController.m
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/6/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import "AddNewPhoneViewController.h"
#import "PhonesBase.h"
#import "Phone.h"

@interface AddNewPhoneViewController ()

@end

@implementation AddNewPhoneViewController{
    PhonesBase *base;
    Phone *newPhone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add new phone";
    [self.manufacturerTF.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.manufacturerTF.layer setBorderWidth:2.0f];

    [self.deviceModelTF.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.deviceModelTF.layer setBorderWidth:2.0f];

    [self.priceTF.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.priceTF.layer setBorderWidth:2.0f];
    
    [self.descriptionTV.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.descriptionTV.layer setBorderWidth:2.0f];
    base = [[PhonesBase alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewPhone:(id)sender {
    newPhone = [[Phone alloc] initWithModel:@"Pesho" manufacturer:@"PESHO OOD" price:123 image:@"Default" andOS:@"Android"];
    [base.phoneBase addObject:newPhone];
}

-(UIColor *)getUIColorFromRGB: (float)red
                        green: (float)green
                         blue: (float)blue
                        alpha: (int)alpha {
    
    float redInRightFormat = red/255.00;
    float greenInRightFormat = green/255.00;
    float blueInRightFormat = blue/255.00;
    
    UIColor *mainColor = [UIColor colorWithRed: redInRightFormat green: greenInRightFormat blue: blueInRightFormat alpha:alpha];
    
    return mainColor;
    
}

@end
