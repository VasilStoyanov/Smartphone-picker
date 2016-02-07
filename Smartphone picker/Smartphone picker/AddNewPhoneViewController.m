//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "AddNewPhoneViewController.h"
#import "Phone.h"
#import "UIView+Toast.h"
#import "FMDB.h"

@interface AddNewPhoneViewController ()

@end

@implementation AddNewPhoneViewController{
    Phone *newPhone;
    NSString *newDeviceOperatingSystem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setStyles];
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
    
    [self addNewPhoneToDatabase:newDeviceModelName manufacturer:newDeviceManufacturerName price:newDevicePrice phoneImage:@"defaultPhotoForPhones" description:@"None yet" operatingSystem:newDeviceOS];
    
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

-(void)addNewPhoneToDatabase: (NSString *) model
                manufacturer: (NSString *) manufacturer
                       price: (double) price
                  phoneImage: (NSString *) image
                 description: (NSString *) description
             operatingSystem: (NSString *) operatingSystem {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"SmartphonePicker.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    FMResultSet *selectResult = [db executeQuery: @"SELECT * FROM Smartphone"];
    if(selectResult != nil) {
        [db executeUpdate: @"INSERT INTO Smartphone (phoneModel, phoneManufacturer, phonePrice, phoneImage, description, operationSystem) VALUES (?, ?, ?, ?, ?, ?)", model, manufacturer, @(1400), image, @"No desc", operatingSystem];
    }
    [db close];
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

-(void) setStyles {
    self.title = @"Add new phone";
    [self.manufacturerTF.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.manufacturerTF.layer setBorderWidth:2.0f];
    
    [self.deviceModelTF.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.deviceModelTF.layer setBorderWidth:2.0f];
    
    [self.priceTF.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.priceTF.layer setBorderWidth:2.0f];
    
    [self.descriptionTV.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [self.descriptionTV.layer setBorderWidth:2.0f];
    newDeviceOperatingSystem = @"iOS";
}

@end
