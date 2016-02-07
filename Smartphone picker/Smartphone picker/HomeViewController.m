//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "HomeViewController.h"
#import "PhoneTableViewCell.h"
#import "Phone.h"
#import "UIView+Toast.h"
#import "PhoneDetailsViewController.h"
#import "PhonesBase.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {
    PhonesBase *phones;
    NSMutableArray *result;
    Phone *selectedPhone;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.homeTableView setDataSource:self];
    [self.homeTableView setDelegate:self];
    
    [self.homeSearchBar setDelegate:self];
    
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

    
    [self applyNavStyles];
    self.title = @"Quick find";
    
    phones = [[PhonesBase alloc]init];
    result = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"PhoneCell";
    PhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PhoneCell" owner:self options:nil] objectAtIndex:0];
    }
    
    NSString *currentDeviceImage = (NSString *)[result[indexPath.row] image];
    UIImage *defaultImage = [UIImage imageNamed:currentDeviceImage];
    
    if(!defaultImage) {
        defaultImage = [UIImage imageNamed:currentDeviceImage];
    }
    
    cell.deviceManufacturer.text = [result[indexPath.row] manufacturer];
    cell.deviceModel.text = [result[indexPath.row] model];
    cell.devicePrice.text = [NSString stringWithFormat:@"%g $", [result[indexPath.row]price]];
    cell.deviceImage.image = defaultImage;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    [cell.contentView.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [cell.contentView.layer setBorderWidth:2.0f];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return result.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedPhone = result[indexPath.row];
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
        
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    result = [[NSMutableArray alloc]init];
    
    NSString *searchTextToLower = [searchText lowercaseString];
    for (Phone *phone in phones.phoneBase) {
        NSString *phoneModelToLower = [phone.model lowercaseString];
        if([phoneModelToLower containsString:searchTextToLower]) {
            if(![result containsObject:phone]) {
                [result addObject:phone];
            }
        }
    }
    
    if(result.count > 0) {
        self.foundItemsLabel.text = [NSString stringWithFormat:@"Found %ld item(s)!", result.count];
    }
    else {
        self.foundItemsLabel.text = @"";
    }

    [self.homeTableView reloadData];
}

-(void)applyNavStyles {
    UIColor *navStyle = [self getUIColorFromRGB:0 green:127 blue:255 alpha:1];
    [self.navigationController.navigationBar setBarTintColor: navStyle];
    [self.navigationController.navigationBar setTranslucent:YES];
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

@end
