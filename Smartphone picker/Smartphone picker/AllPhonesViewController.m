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

@interface AllPhonesViewController ()

@end

@implementation AllPhonesViewController {
    NSArray *namess;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.allPhonesTV setDataSource:self];
    [self.allPhonesTV setDelegate:self];
    self.title = @"All phones";
    [self applyNavStyles];
    
    namess = [NSMutableArray arrayWithObjects:@"Pesho", @"Gosho", @"Penka Lalova", @"Pesho", @"Kolio", @"Pesho", @"Plaka", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return namess.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"PhoneCell";
    PhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PhoneCell" owner:self options:nil] objectAtIndex:0];
    }
    Phone *phone = [[Phone alloc]init];
    phone.model = @"One M8";
    phone.manufacturer = @"HTC";
    phone.price = 456;
    
    UIImage *defaultImage = [UIImage imageNamed:@"DefaultPhoneImage"];
    if(!defaultImage) {
        defaultImage = [UIImage imageNamed:@"DefaultPhoneImage"];
    }
    
    cell.deviceFullName.text = [NSString stringWithFormat:@"%@ %@", phone.manufacturer, phone.model];
    cell.devicePrice.text = [NSString stringWithFormat:@"%g", phone.price];
    cell.deviceImage.image = defaultImage;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
