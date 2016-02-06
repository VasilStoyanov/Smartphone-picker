//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "AndroidManufacturerersViewController.h"
#import "MatchPhoneViewController.h"

@interface AndroidManufacturerersViewController ()

@end

@implementation AndroidManufacturerersViewController {
    NSArray *androidManufacturers;
    NSString *manufacturerName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.androidManufacturersTV setDataSource:self];
    [self.androidManufacturersTV setDelegate:self];
    
    androidManufacturers = [NSArray arrayWithObjects:
                            @"Samsung", @"Google", @"HTC", @"Huawei", @"Lenovo",
                            @"Oppo", @"Motorolla", @"Sony", @"LG", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ManufacturerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = androidManufacturers[indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return androidManufacturers.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    manufacturerName = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [self performSegueWithIdentifier:@"SendAndroidManuName" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender {
    NSString *toAndroidManufacturersSegueIdentifier = @"SendAndroidManuName";
    
    if([segue.identifier isEqualToString:toAndroidManufacturersSegueIdentifier]) {
        MatchPhoneViewController *toVC = segue.destinationViewController;
        toVC.deviceManufacturer.text = manufacturerName;
        
    }
}

@end
