//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "HomeViewController.h"
#import "PhoneTableViewCell.h"
#import "Phone.h"

@interface HomeViewController ()

@end

@implementation HomeViewController {
    NSMutableArray *phones;
    NSMutableArray *result;
    Phone *p1;
    Phone *p2;
    Phone *p3;
    Phone *p4;
    Phone *p5;
    Phone *p6;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.homeTableView setDataSource:self];
    [self.homeTableView setDelegate:self];
    
    [self.homeSearchBar setDelegate:self];
    
    [self applyNavStyles];
    self.title = @"Quick find";
    
    p1 = [[Phone alloc]initWithModel:@"One M8" manufacturer:@"HTC" price:1200 image:@"DefaultPhoneImage" andOS:@"Android"];
    
    p2 = [[Phone alloc]initWithModel:@"Galaxy S6" manufacturer:@"Samsung" price:1220 image:@"DefaultPhoneImage" andOS:@"Android"];
    
    p3 = [[Phone alloc]initWithModel:@"Galaxy S6 Edge" manufacturer:@"Samsung" price:1400 image:@"DefaultPhoneImage" andOS:@"Android"];
    
    p4 = [[Phone alloc]initWithModel:@"Nexus 5" manufacturer:@"Google" price:1000 image:@"DefaultPhoneImage" andOS:@"Android"];
    
    p5 = [[Phone alloc]initWithModel:@"G4" manufacturer:@"LG" price:1500 image:@"DefaultPhoneImage" andOS:@"Android"];
    
    p6 = [[Phone alloc]initWithModel:@"iPhone 5s" manufacturer:@"Apple" price:2200 image:@"DefaultPhoneImage" andOS:@"iOS"];
    
    phones = [NSMutableArray arrayWithObjects:p1, p2, p3, p4, p5, p6, nil];

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
    
    //UIImage *defaultImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:phone.image]]];
    
//    NSString *currentPhoneImage = [phones[indexPath.row] image];
    UIImage *defaultImage = [UIImage imageNamed:@"DefaultPhoneImage"];
    
    if(!defaultImage) {
        defaultImage = [UIImage imageNamed:@"DefaultPhoneImage"];
    }
    
    NSString *deviceFullName = [NSString stringWithFormat:@"%@ %@",
                                [result[indexPath.row] model],
                                [result[indexPath.row] manufacturer]];
    
    cell.deviceFullName.text = deviceFullName;
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
    [self performSegueWithIdentifier:@"ViewPhoneDetailsSegue" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender {
//    NSString *toAndroidManufacturersSegueIdentifier = @"ViewPhoneDetailsSegue";
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    result = [[NSMutableArray alloc]init];
    
    NSString *searchTextToLower = [searchText lowercaseString];
    for (Phone *phone in phones) {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
