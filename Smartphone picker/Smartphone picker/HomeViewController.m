//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "HomeViewController.h"
#import "PhoneTableViewCell.h"
#import "Phone.h"
#import "UIView+Toast.h"
#import "PhoneDetailsViewController.h"
#import "FMDB.h"


@interface HomeViewController ()

@end

@implementation HomeViewController {
    NSMutableArray *phonesDb;
    NSMutableArray *result;
    Phone *selectedPhone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeDatabase];
    [self getDataFromDb];
    
    [self.homeTableView setDataSource:self];
    [self.homeTableView setDelegate:self];
    
    [self.homeSearchBar setDelegate:self];
    
    [self applyNavStyles];
    self.title = @"Quick find";
    
    result = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated {
    [self getDataFromDb];
    [self.homeTableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"PhoneCell";
    PhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PhoneCell" owner:self options:nil] objectAtIndex:0];
    }
    
    UIImage *currentPhoneImage = [result[indexPath.row] getImage];
    
    cell.deviceManufacturer.text = [result[indexPath.row] manufacturer];
    cell.deviceModel.text = [result[indexPath.row] model];
    cell.devicePrice.text = [NSString stringWithFormat:@"%g $", [result[indexPath.row]price]];
    cell.deviceImage.image = currentPhoneImage;
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    result = [[NSMutableArray alloc]init];
    
    NSString *searchTextToLower = [searchText lowercaseString];
    for (Phone *phone in phonesDb) {
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
    UIColor *navStyle = [self getUIColorFromRGB:102 green:204 blue:255 alpha:1];
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

-(void) initializeDatabase {
    NSLog(@"Check and create database");
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"SmartphonePicker.db"];
    NSLog(@"%@", path);
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    if (![db open]) {
        return;
    }
    else {
        [db open];
        NSLog(@"Database exist.");
        FMResultSet *selectResult = [db executeQuery: @"SELECT * FROM Smartphone"];
        if (selectResult == nil) {
            [db executeUpdate:@"CREATE TABLE Smartphone (id INTEGER PRIMARY KEY AUTOINCREMENT, phoneModel TEXT, phoneManufacturer TEXT, phonePrice DOUBLE, phoneImage TEXT, description TEXT, operationSystem TEXT)"];
    
            [db executeUpdate: @"INSERT INTO Smartphone (phoneModel, phoneManufacturer, phonePrice, phoneImage, description, operationSystem) VALUES (?, ?, ?, ?, ?, ? )", @"One M8", @"HTC", @(800), @"htcM8", @"Great build quality. Amazing speakers.", @"Android"];
            
            [db executeUpdate: @"INSERT INTO Smartphone (phoneModel, phoneManufacturer, phonePrice, phoneImage, description, operationSystem) VALUES (?, ?, ?, ?, ?, ? )", @"Galaxy S6", @"Samsung", @(1200), @"galaxyS6", @"Super fast, amazing camera!", @"Android"];
            
            [db executeUpdate: @"INSERT INTO Smartphone (phoneModel, phoneManufacturer, phonePrice, phoneImage, description, operationSystem) VALUES (?, ?, ?, ?, ?, ? )", @"Galaxy S6 Edge", @"Samsung", @(1400), @"galaxyS6Edge", @"Super fast and stunning design! Great camera!", @"Android"];
            
            [db executeUpdate: @"INSERT INTO Smartphone (phoneModel, phoneManufacturer, phonePrice, phoneImage, description, operationSystem) VALUES (?, ?, ?, ?, ?, ? )", @"Nexus", @"Google", @(600), @"nexus5", @"Vanilla Android, updates arive ASAP on the air! Great price!", @"Android"];
            
            [db executeUpdate: @"INSERT INTO Smartphone (phoneModel, phoneManufacturer, phonePrice, phoneImage, description, operationSystem) VALUES (?, ?, ?, ?, ?, ? )", @"G4", @"LG", @(1100), @"lgg4", @"Great balance of features/speed/camera!", @"Android"];
            
            [db executeUpdate: @"INSERT INTO Smartphone (phoneModel, phoneManufacturer, phonePrice, phoneImage, description, operationSystem) VALUES (?, ?, ?, ?, ?, ? )", @"iPhone 5s", @"Apple", @(1400), @"iphone5s", @"Great build quality, camera is snappy and takes good images!", @"iOS"];
            
            NSLog(@"Table created!");
        }
    }
}

-(void) getDataFromDb {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsPath = [paths objectAtIndex:0];
    NSString *path = [docsPath stringByAppendingPathComponent:@"SmartphonePicker.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    
    phonesDb = [[NSMutableArray alloc]init];
    FMResultSet *selectResult = [db executeQuery: @"SELECT * FROM Smartphone"];
    
    while([selectResult next]) {
        NSString *model = [selectResult stringForColumnIndex:1];
        NSString *manufacturer = [selectResult stringForColumnIndex:2];
        double price = [selectResult doubleForColumnIndex:3];
        UIImage *image = [UIImage imageNamed:[selectResult stringForColumnIndex:4]];
        NSString *description = [selectResult stringForColumnIndex:5];
        NSString *operationSystem = [selectResult stringForColumnIndex:6];
        if(!image) {
            NSString *workSpacePath=[[self applicationDocumentsDirectory] stringByAppendingPathComponent:[selectResult stringForColumnIndex:4]];
            image =[UIImage imageWithData:[NSData dataWithContentsOfFile:workSpacePath]];
        }
        Phone *phoneToPush = [[Phone alloc]initWithModel:model manufacturer:manufacturer price:price image:image description:description andOS:operationSystem];
        [phonesDb addObject:phoneToPush];
    }
    
    [db close];
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


@end
