//
//  MatchPhoneViewController.h
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/6/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchPhoneViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *deviceManufacturer;

@property (weak, nonatomic) IBOutlet UIButton *androidManuSelect;

@property (weak, nonatomic) IBOutlet UISegmentedControl *operatingSystemsSegment;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (weak, nonatomic) IBOutlet UITextField *minPriceTF;

@property (weak, nonatomic) IBOutlet UITextField *maxPriceTf;

@end
