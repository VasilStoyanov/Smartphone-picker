//
//  PhoneTableViewCell.h
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/3/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *deviceImage;

@property (weak, nonatomic) IBOutlet UILabel *deviceFullName;

@property (weak, nonatomic) IBOutlet UILabel *devicePrice;

@end
