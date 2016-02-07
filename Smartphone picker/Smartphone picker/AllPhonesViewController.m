//
//  AllPhonesViewController.m
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/6/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import "AllPhonesViewController.h"
#import "Phone.h"
#import "PhoneTableViewCell.h"
#import "AddNewPhoneViewController.h"
#import "PhonesBase.h"
#import "PhoneDetailsViewController.h"

@interface AllPhonesViewController ()

@end

@implementation AllPhonesViewController {
    PhonesBase *phones;
    Phone *selectedPhone;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.allPhonesTV setDataSource:self];
    [self.allPhonesTV setDelegate:self];
    self.title = @"All phones";
    [self applyNavStyles];
    
    phones = [[PhonesBase alloc]init];
}

-(void)viewDidAppear:(BOOL)animated {
        [self.allPhonesTV reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return phones.phoneBase.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedPhone = phones.phoneBase[indexPath.row];
    selectedCell.contentView.backgroundColor = [self getUIColorFromRGB:175 green:238 blue:238 alpha:1];
    [self performSegueWithIdentifier:@"ViewPhoneDetailsSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender {
    NSString *toViewPhoneDetailsSegue = @"ViewPhoneDetailsSegue";
    if([segue.identifier isEqualToString:toViewPhoneDetailsSegue]) {
        PhoneDetailsViewController *toVC = segue.destinationViewController;
        NSString *deviceFullName = [NSString stringWithFormat:@"%@ %@",
                                    selectedPhone.manufacturer,
                                    selectedPhone.model];
        
        toVC.fullName = deviceFullName;
        toVC.priceofDevice = [NSString stringWithFormat:@"%g $", selectedPhone.price];
        toVC.imageSrc = selectedPhone.image;
        toVC.devicePrice.text = [NSString stringWithFormat:@"%g", selectedPhone.price];
        if([selectedPhone.OS isEqualToString:@"iOS"]) {
            toVC.OS = @"iosLogo";
        }
        else if([selectedPhone.OS isEqualToString:@"Android"]) {
            toVC.OS = @"androidLogo";
        }
        else {
            toVC.OS = @"windowsLogo";
        }
        toVC.phone = selectedPhone;
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"PhoneCell";
    PhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PhoneCell" owner:self options:nil] objectAtIndex:0];
    }
    
    UIImage *currentDeviceImage = [phones.phoneBase[indexPath.row] getImage];
    
    cell.deviceManufacturer.text = [phones.phoneBase[indexPath.row] manufacturer];
    cell.deviceModel.text = [phones.phoneBase[indexPath.row] model];
    cell.devicePrice.text = [NSString stringWithFormat:@"%g $", [phones.phoneBase[indexPath.row]price]];
    cell.deviceImage.image = currentDeviceImage;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    [cell.contentView.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [cell.contentView.layer setBorderWidth:2.0f];
    return cell;
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

-(void)applyNavStyles {
    UIColor *navStyle = [self getUIColorFromRGB:0 green:127 blue:255 alpha:1];
    [self.navigationController.navigationBar setBarTintColor: navStyle];
    [self.navigationController.navigationBar setTranslucent:YES];

    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPhone)];
    
    self.navigationItem.rightBarButtonItem = add;
}

-(void)addNewPhone {
    NSString *boardId = @"addPhoneScene";
    AddNewPhoneViewController *addPhoneVC = [self.storyboard instantiateViewControllerWithIdentifier:boardId];
    [self.navigationController pushViewController:addPhoneVC animated:YES];
}

@end
