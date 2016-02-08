//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "AddNewPhoneViewController.h"
#import "Phone.h"
#import "UIView+Toast.h"
#import "FMDB.h"
#import "SmartphonePicker-Swift.h"

@interface AddNewPhoneViewController ()

@end

@implementation AddNewPhoneViewController{
    Phone *newPhone;
    PhoneValidator *validator;
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
    validator = [[PhoneValidator alloc]init];
    
    NSString *newDeviceModelName = self.deviceModelTF.text;
    if(![validator modelIsValid:newDeviceModelName]) {
        [self sendErrorMessage];
        return;
    }
    
    NSString *newDeviceManufacturerName = self.manufacturerTF.text;
    if(![validator manufacturerNameIsValid:newDeviceManufacturerName]) {
        [self sendErrorMessage];
        return;
    }
    
    double newDevicePrice = [self.priceTF.text doubleValue];
    if(![validator priceIsValid:newDevicePrice]) {
        [self sendErrorMessage];
        return;
    }
    
    NSString *newDeviceDescription = self.descriptionTV.text;
    if(![validator descriptionIsValid:newDeviceDescription]) {
        [self sendErrorMessage];
        return;
    }
    
    NSString *newDeviceOS = newDeviceOperatingSystem;
    
    // Passed validations
    [self addNewPhoneToDatabase:newDeviceModelName manufacturer:newDeviceManufacturerName price:newDevicePrice phoneImage:@"defaultPhotoForPhones" description:newDeviceDescription operatingSystem:newDeviceOS];
    
    self.deviceModelTF.text = @"";
    self.priceTF.text = @"";
    self.descriptionTV.text = @"";
    
    [self sendSuccessMessage];
    
}
- (IBAction)osValueChanged:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            newDeviceOperatingSystem = @"iOS";
            self.manufacturerTF.text = @"Apple";
            [self.manufacturerTF setEnabled:NO];
            break;
        case 1:
            newDeviceOperatingSystem = @"Android";
            self.manufacturerTF.text = @"";
            [self.manufacturerTF setEnabled:YES];
            break;
        case 2:
            newDeviceOperatingSystem = @"Windows";
            self.manufacturerTF.text = @"Microsoft";
            [self.manufacturerTF setEnabled:NO];
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
        [db executeUpdate: @"INSERT INTO Smartphone (phoneModel, phoneManufacturer, phonePrice, phoneImage, description, operationSystem) VALUES (?, ?, ?, ?, ?, ?)", model, manufacturer, @(1400), image, description, operatingSystem];
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
    [self.manufacturerTF.layer setBorderColor:[self getUIColorFromRGB:102 green:204 blue:255 alpha:1].CGColor];
    [self.manufacturerTF.layer setBorderWidth:2.0f];
    
    [self.deviceModelTF.layer setBorderColor:[self getUIColorFromRGB:102 green:204 blue:255 alpha:1].CGColor];
    [self.deviceModelTF.layer setBorderWidth:2.0f];
    
    [self.priceTF.layer setBorderColor:[self getUIColorFromRGB:102 green:204 blue:255 alpha:1].CGColor];
    [self.priceTF.layer setBorderWidth:2.0f];
    
    [self.descriptionTV.layer setBorderColor:[self getUIColorFromRGB:102 green:204 blue:255 alpha:1].CGColor];
    [self.descriptionTV.layer setBorderWidth:2.0f];
    newDeviceOperatingSystem = @"iOS";
    self.manufacturerTF.text = @"Apple";
    [self.manufacturerTF setEnabled:NO];
}

-(void)sendSuccessMessage {
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

-(void)sendErrorMessage {
    [self.view makeToast:validator.reasonForFail
                duration:3.0
                position:CSToastPositionCenter
                   title: @"Something went wrong!"
                   image:[UIImage imageNamed:@"somethingIsWrong.png"]
                   style:nil
              completion:^(BOOL didTap) {
                  if (didTap) {
                      NSLog(@"completion from tap");
                  } else {
                      NSLog(@"completion without tap");
                  }
              }];
}

@end
