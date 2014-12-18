//
//  VXPromotionViewController.h
//
//  Created by Swift Management AG on 18.12.2014.
//  Copyright 2010 Swift Management AG. All rights reserved.
//
//  https://github.com/swiftmanagementag/VXPromotionViewController

@interface VXPromotionViewController : UITableViewController

- (instancetype)initWithApps:(NSArray*)pApps;

- (instancetype)initWithAddress:(NSString*)urlString;
- (instancetype)initWithURL:(NSURL*)URL;
- (instancetype)initWithURLRequest:(NSURLRequest *)request;

@end
