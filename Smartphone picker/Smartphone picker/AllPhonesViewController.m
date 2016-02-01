//
//  AllPhonesViewController.m
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/1/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import "AllPhonesViewController.h"
//#import "Smartphone_picker-Swift.h"

@implementation AllPhonesViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    // Navigation menu customization	
    self.title = @"All phones";
    
    float red = 0.00/255.00;
    float green = 127.00/255.00;
    float blue = 255.00/255.00;
    
    UIColor *mainColor = [UIColor colorWithRed: red green: green blue: blue alpha:1];
    [self.navigationController.navigationBar setBarTintColor: mainColor];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    [self addBasePhones];
    
    
}

-(void) addBasePhones {
    self.phones = [NSArray arrayWithObjects: @"Galaxy S6", @"HTC One M8", nil];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"phoneCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *currentPhoneName = self.phones[indexPath.row];
    
    if([currentPhoneName containsString:@"Galaxy"]) {
        cell.textLabel.text = self.phones[indexPath.row];
    }
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.phones.count;
}

@end
