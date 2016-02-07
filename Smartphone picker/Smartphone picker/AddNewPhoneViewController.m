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
#import "UIView+Toast.h"

@interface AddNewPhoneViewController ()

@end

@implementation AddNewPhoneViewController{
    PhonesBase *base;
    Phone *newPhone;
    NSString *newDeviceOperatingSystem;
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
    newDeviceOperatingSystem = @"iOS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addNewPhone:(id)sender {
    // VALIDATIONS!!!!
    NSString *newDeviceModelName = self.deviceModelTF.text;
    NSString *newDeviceManufacturerName = self.manufacturerTF.text;
    double newDevicePrice = [self.priceTF.text doubleValue];
    NSString *newDeviceOS = newDeviceOperatingSystem;
    UIImage *newDeviceImage = [UIImage imageNamed:@"defaultPhotoForPhones"];
    newPhone = [[Phone alloc] initWithModel:newDeviceModelName manufacturer:newDeviceManufacturerName price:newDevicePrice image:newDeviceImage andOS:newDeviceOS];
    
    [base.phoneBase addObject:newPhone];
    [self.view makeToast:@"Smartphone added! You owe only a smile! :)"
                duration:3.0
                position:CSToastPositionCenter
                   title:@"Success!"
                   image:[UIImage imageNamed:@"everythingAllright.png"]
                   style:nil
              completion:^(BOOL didTap) {
                  if (didTap) {
                      NSLog(@"completion from tap");
                  } else {
                      NSLog(@"completion without tap");
                  }
              }];
}
- (IBAction)osValueChanged:(id)sender {
    NSLog(@"I AM HEREEEE");
    switch ([sender selectedSegmentIndex]) {
        case 0:
            newDeviceOperatingSystem = @"iOS";
            break;
        case 1:
            newDeviceOperatingSystem = @"Android";
            break;
        case 2:
            newDeviceOperatingSystem = @"Windows";
            break;
        default:
            newDeviceOperatingSystem = @"iOS";
            break;
    }
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
