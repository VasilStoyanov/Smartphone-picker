//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "PhoneDetailsViewController.h"
@import Photos;

@interface PhoneDetailsViewController ()

@end

@implementation PhoneDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.deviceFullName setText:self.fullName];
    [self.devicePrice setText:self.priceofDevice];
    self.deviceImageSrc.image = self.imageSrc;
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
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:savedImagePath atomically:YES];
    
    self.deviceImageSrc.image = image;
    self.phone.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
