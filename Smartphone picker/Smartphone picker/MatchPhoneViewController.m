//
//  MatchPhoneViewController.m
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/6/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import "MatchPhoneViewController.h"

@interface MatchPhoneViewController ()

@end

@implementation MatchPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self applyNavStyles];
    self.title = @"Match your phone";
    self.sendButton.layer.cornerRadius = 10;
    
    [self.minPriceTF.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.minPriceTF.layer setBorderWidth:2.0f];
    
    [self.maxPriceTf.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.maxPriceTf.layer setBorderWidth:2.0f];
    
    [self.androidManuSelect setHidden:YES];
    self.androidManuSelect.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender {
}

- (IBAction)segmentSelectedValueChanged:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            [self setAndroidMenuHidden];
            self.deviceManufacturer.text = @"Apple";
            break;
        case 1:
            self.deviceManufacturer.text = @"";
            [self setAndroidMenuVissible];
            break;
        case 2:
            [self setAndroidMenuHidden];
            self.deviceManufacturer.text = @"Microsoft";
            break;
        default:
            break;
    }
}

-(void)setAndroidMenuHidden {
    [self.androidManuSelect setHidden:YES];
}

-(void)setAndroidMenuVissible {
    [self.androidManuSelect setHidden:NO];
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

-(IBAction)returnToThis: (UIStoryboardSegue *) segue {
}

-(void)applyNavStyles {
    UIColor *navStyle = [self getUIColorFromRGB:0 green:127 blue:255 alpha:1];
    [self.navigationController.navigationBar setBarTintColor: navStyle];
    [self.navigationController.navigationBar setTranslucent:YES];
}

@end
