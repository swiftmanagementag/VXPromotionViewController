//
//  VXPromotionModalViewController.h
//
//  Created by Oliver Letterer on 13.08.11.
//  Copyright 2011 Home. All rights reserved.
//
//  https://github.com/swiftmanagementag/VXPromotionViewController

#import <UIKit/UIKit.h>

@interface VXPromotionModalViewController : UINavigationController

- (instancetype)initWithApps:(NSArray*)pApps;
- (instancetype)initWithAddress:(NSString*)urlString;
- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)initWithURLRequest:(NSURLRequest *)request;

@property (nonatomic, strong) UIColor *barsTintColor;

@end
