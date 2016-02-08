//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
#import "MatchPhoneViewController.h"
#import "FMDB.h"
#import "Phone.h"
#import "MatchResultViewController.h"

@interface MatchPhoneViewController ()

@end

@implementation MatchPhoneViewController {
    NSMutableArray *phonesDb;
    NSMutableArray *matchedPhones;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self applyNavStyles];
    [self getDataFromDb];
    
    self.title = @"Match your phone";
    self.sendButton.layer.cornerRadius = 10;
    
    [self.minimumPriceTF.layer setBorderColor:[self getUIColorFromRGB:102 green:204 blue:255 alpha:1].CGColor];
    [self.minimumPriceTF.layer setBorderWidth:2.0f];
    
    [self.maximumPriceTF.layer setBorderColor:[self getUIColorFromRGB:102 green:204 blue:255 alpha:1].CGColor];
    [self.maximumPriceTF.layer setBorderWidth:2.0f];
    
    [self.androidManuSelect setHidden:YES];
    self.androidManuSelect.layer.cornerRadius = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated {
    [self getDataFromDb];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender {
    NSString *manufacturer = self.deviceManufacturer.text;
    double minBorder = [self.minimumPriceTF.text doubleValue];
    double maxBorder = [self.maximumPriceTF.text doubleValue];
    matchedPhones = [[NSMutableArray alloc]init];
    
    for (Phone *phone in phonesDb) {
        if([phone.manufacturer isEqualToString:manufacturer] &&
           (phone.price >= minBorder) && (phone.price <= maxBorder)) {
            [matchedPhones addObject:phone];
        }
    }
    
    
    NSString *toViewPhoneDetailsSegue = @"MatchResultSegue";
    if([segue.identifier isEqualToString:toViewPhoneDetailsSegue]) {
        MatchResultViewController *toVC = segue.destinationViewController;
        toVC.filteredResult = matchedPhones;
    }
}

- (IBAction)segmentSelectedValueChanged:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            [self setAndroidMenuHidden];
            self.deviceManufacturer.text = @"Apple";
            break;
        case 1:
            self.deviceManufacturer.text = @"";
            [self setAndroidMenuVissible];
            break;
        case 2:
            [self setAndroidMenuHidden];
            self.deviceManufacturer.text = @"Microsoft";
            break;
        default:
            break;
    }
}

-(void)setAndroidMenuHidden {
    [self.androidManuSelect setHidden:YES];
}

-(void)setAndroidMenuVissible {
    [self.androidManuSelect setHidden:NO];
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

-(IBAction)returnToThis: (UIStoryboardSegue *) segue {
}

-(void)applyNavStyles {
    UIColor *navStyle = [self getUIColorFromRGB:102 green:204 blue:255 alpha:1];
    [self.navigationController.navigationBar setBarTintColor: navStyle];
    [self.navigationController.navigationBar setTranslucent:YES];
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
