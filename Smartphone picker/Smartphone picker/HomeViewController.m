//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "HomeViewController.h"
#import "PhoneTableViewCell.h"
#import "Phone.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
NSMutableArray *names;
NSMutableArray *result;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.homeTableView setDataSource:self];
    [self.homeTableView setDelegate:self];
    
    [self.homeSearchBar setDelegate:self];
    
    [self applyNavStyles];
    
    names = [NSMutableArray arrayWithObjects:@"Pesho", @"Gosho", @"Penka Lalova", @"Pesho", @"Kolio", @"Pesho", @"Plaka", nil];

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
    Phone *phone = [[Phone alloc]init];
    phone.model = @"One M8";
    phone.manufacturer = @"HTC";
    phone.price = 456;
    
    
    //UIImage *defaultImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:phone.image]]];
    
    UIImage *defaultImage = [UIImage imageNamed:@"DefaultPhoneImage"];
    if(!defaultImage) {
        defaultImage = [UIImage imageNamed:@"DefaultPhoneImage"];
    }
    
    cell.deviceFullName.text = [NSString stringWithFormat:@"%@ %@", phone.manufacturer, phone.model];
    cell.devicePrice.text = [NSString stringWithFormat:@"%g", phone.price];
    cell.deviceImage.image = defaultImage;
    
    [self.homeTableView autoresizesSubviews];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return result.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    result = [[NSMutableArray alloc]init];
    for (NSString *name in names) {
        if([name containsString:searchText]) {
            if(![result containsObject:name]) {
                [result addObject:name];
            }
        }
    }
    
    self.foundItemsLabel.text = [NSString stringWithFormat:@"Found %ld item(s)!", result.count];
    
    [self.homeTableView reloadData];
}

-(void)applyNavStyles {
    self.title = @"Home";
    
    float red = 0.00/255.00;
    float green = 127.00/255.00;
    float blue = 255.00/255.00;
    
    UIColor *mainColor = [UIColor colorWithRed: red green: green blue: blue alpha:1];
    [self.navigationController.navigationBar setBarTintColor: mainColor];
    [self.navigationController.navigationBar setTranslucent:YES];
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
