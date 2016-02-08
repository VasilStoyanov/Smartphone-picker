//
//  MatchResultViewController.m
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/8/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import "MatchResultViewController.h"
#import "PhoneTableViewCell.h"
#import "Phone.h"
#import "PhoneDetailsViewController.h"

@implementation MatchResultViewController {
    Phone *selectedPhone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.matchedResultTV setDataSource:self];
    [self.matchedResultTV setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    selectedPhone = self.filteredResult[indexPath.row];
    selectedCell.contentView.backgroundColor = [self getUIColorFromRGB:175 green:238 blue:238 alpha:1];
    [self performSegueWithIdentifier:@"MatchedPhoneMoreDetailsSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender {
    NSString *toViewPhoneDetailsSegue = @"MatchedPhoneMoreDetailsSegue";
    if([segue.identifier isEqualToString:toViewPhoneDetailsSegue]) {
        PhoneDetailsViewController *toVC = segue.destinationViewController;
        NSString *deviceFullName = [NSString stringWithFormat:@"%@ %@",
                                    selectedPhone.manufacturer,
                                    selectedPhone.model];
        
        toVC.fullName = deviceFullName;
        toVC.priceofDevice = [NSString stringWithFormat:@"%g $", selectedPhone.price];
        toVC.imageSrc = selectedPhone.image;
        toVC.showDescription = selectedPhone.deviceDescription;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"PhoneCell";
    PhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PhoneCell" owner:self options:nil] objectAtIndex:0];
    }
    
    UIImage *currentPhoneImage = [self.filteredResult[indexPath.row] getImage];
    
    cell.deviceManufacturer.text = [self.filteredResult[indexPath.row] manufacturer];
    cell.deviceModel.text = [self.filteredResult[indexPath.row] model];
    cell.devicePrice.text = [NSString stringWithFormat:@"%g $", [self.filteredResult[indexPath.row]price]];
    cell.deviceImage.image = currentPhoneImage;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    [cell.contentView.layer setBorderColor:[self getUIColorFromRGB:237 green:241 blue:228 alpha:1].CGColor];
    [cell.contentView.layer setBorderWidth:2.0f];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredResult.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
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
