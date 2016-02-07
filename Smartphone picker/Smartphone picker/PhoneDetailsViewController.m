//
//  PhoneDetailsViewController.m
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/6/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import "PhoneDetailsViewController.h"

@interface PhoneDetailsViewController ()

@end

@implementation PhoneDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.deviceFullName setText:self.fullName];
    [self.devicePrice setText:self.priceofDevice];
    self.deviceImageSrc.image = [UIImage imageNamed:self.imageSrc];
    self.deviceOperatingSystemImage.image = [UIImage imageNamed:self.OS];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
