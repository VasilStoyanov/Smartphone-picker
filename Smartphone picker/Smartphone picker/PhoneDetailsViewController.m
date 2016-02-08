//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "PhoneDetailsViewController.h"
#import "FMDB.h"

@import Photos;

@interface PhoneDetailsViewController ()

@end

@implementation PhoneDetailsViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.deviceFullName setText:self.fullName];
    [self.devicePrice setText:self.priceofDevice];
    self.deviceImageSrc.image = self.imageSrc;
    self.deviceDescription.text = self.showDescription;
    self.deviceDescription.font = [UIFont systemFontOfSize:16.0f];
    self.deviceOperatingSystemImage.image = [UIImage imageNamed:self.OS];
    
    self.deviceImageSrc.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *tapAndHoldGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAndHoldGesture)];
    
    [self.deviceImageSrc addGestureRecognizer:tapAndHoldGesture];
    
}

-(void)handleTapAndHoldGesture {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    [imagePickerController setDelegate:self];
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion: nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {

    [picker dismissModalViewControllerAnimated:YES];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *newImageName = [NSString stringWithFormat:@"image%d.png",
                              [self getRandomNumberBetween:1 to:99999]];
                              
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent: newImageName];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:YES];
    
    self.deviceImageSrc.image = image;
    self.phone.image = image;
    [self updatePhoneInDatabase:self.phone.model
                       newImage:newImageName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)updatePhoneInDatabase: (NSString *) phoneModel
                    newImage: (NSString *) newImage {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"SmartphonePicker.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    FMResultSet *selectResult = [db executeQuery: @"SELECT * FROM Smartphone"];
    if(selectResult != nil) {
        [db executeUpdate: @"UPDATE Smartphone SET phoneImage = ? WHERE phoneModel = ?", newImage, phoneModel];
    }
    [db close];
}

-(int)getRandomNumberBetween:(int)from
                          to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

@end
