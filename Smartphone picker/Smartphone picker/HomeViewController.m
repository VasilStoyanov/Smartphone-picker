//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
NSMutableArray *names;
NSMutableArray *result;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self applyNavStyles];
    names = [NSMutableArray arrayWithObjects:@"Pesho", @"Gosho", @"Penka Lalova", @"Kolio", nil];
    [self.homeTableView setDataSource:self];
    [self.homeSearchBar setDelegate:self];
    result = [[NSMutableArray alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"SmartphoneCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = result[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return result.count;
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
