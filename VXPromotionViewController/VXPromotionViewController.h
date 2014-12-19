//
//  VXPromotionViewController.h
//
//  Created by Swift Management AG on 18.12.2014.
//  Copyright 2010 Swift Management AG. All rights reserved.
//
//  https://github.com/swiftmanagementag/VXPromotionViewController

@interface VXPromotionViewController : UITableViewController

@property (nonatomic, strong) NSString *appID;


- (instancetype)initWithArrayOfAppIDs:(NSArray*)pApps;
- (instancetype)initWithAddress:(NSString*)urlString;

@end
