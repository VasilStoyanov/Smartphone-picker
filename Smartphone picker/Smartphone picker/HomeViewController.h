//
//  HomeViewController.h
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/2/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property (weak, nonatomic) IBOutlet UISearchBar *homeSearchBar;

@property (weak, nonatomic) IBOutlet UILabel *foundItemsLabel;

@end
