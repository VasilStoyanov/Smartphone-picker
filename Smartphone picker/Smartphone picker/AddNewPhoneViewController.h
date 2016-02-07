//
//  AddNewPhoneViewController.h
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/6/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewPhoneViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *manufacturerTF;

@property (weak, nonatomic) IBOutlet UITextField *deviceModelTF;

@property (weak, nonatomic) IBOutlet UITextField *priceTF;

@property (weak, nonatomic) IBOutlet UITextView *descriptionTV;

@property (weak, nonatomic) IBOutlet UIButton *btnAddNewPhone;

@end
