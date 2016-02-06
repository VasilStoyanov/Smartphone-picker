//
//  AddNewPhoneViewController.m
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/6/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import "AddNewPhoneViewController.h"

@interface AddNewPhoneViewController ()

@end

@implementation AddNewPhoneViewController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
