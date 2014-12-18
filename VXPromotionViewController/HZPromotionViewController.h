//
//  ATFlipsideViewController.h
//  hazard
//
//  Created by Graham Lancashire on 07.11.13.
//  Copyright (c) 2013 Swift Management AG. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "HZViewController.h"

@interface HZPromotionViewController : HZViewController
@property (strong, nonatomic) IBOutlet UITableView * tableView;
@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

- (IBAction)rate:(id)sender;

@end
