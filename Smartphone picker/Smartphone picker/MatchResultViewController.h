//
//  MatchResultViewController.h
//  Smartphone picker
//
//  Created by Vasil Stoyanov on 2/8/16.
//  Copyright © 2016 Vasil Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatchResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *filteredResult;

@property (weak, nonatomic) IBOutlet UITableView *matchedResultTV;

@end
