//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import <UIKit/UIKit.h>
#import "Phone.h"

@interface PhoneDetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *deviceFullName;

@property (weak, nonatomic) IBOutlet UIImageView *deviceImageSrc;

@property (strong, nonatomic) IBOutlet UILabel *devicePrice;

@property (weak, nonatomic) IBOutlet UITextView *deviceDescription;

@property (weak, nonatomic) IBOutlet UIImageView *deviceOperatingSystemImage;

@property (strong, nonatomic) NSString *fullName;

@property (strong, nonatomic) UIImage *imageSrc;

@property (strong, nonatomic) NSString *priceofDevice;

//@property (strong, nonatomic) NSString *description;

@property (strong, nonatomic) NSString *OS;

@property (strong, nonatomic) Phone *phone;

@end
