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
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Phone for me"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:nil];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                                   initWithTitle:@"All phones"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:nil];
    
    NSArray *pesho = [NSArray arrayWithObjects:flipButton, nil];
    self.navigationItem.rightBarButtonItem = flipButton;
    self.navigationItem.leftBarButtonItem = add;
    
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
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
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
    
    if(result.count > 0) {
        self.foundItemsLabel.text = [NSString stringWithFormat:@"Found %ld item(s)!", result.count];
    }
    else {
        self.foundItemsLabel.text = @"";
    }

    [self.homeTableView reloadData];
}

-(void)applyNavStyles {
    self.title = @"Quick find";
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
