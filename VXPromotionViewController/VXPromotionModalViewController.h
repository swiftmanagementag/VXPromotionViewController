//
//  VXPromotionModalViewController.h
//
//  Created by Oliver Letterer on 13.08.11.
//  Copyright 2011 Home. All rights reserved.
//
//  https://github.com/swiftmanagementag/VXPromotionViewController

#import <UIKit/UIKit.h>
#import "VXPromotionViewController.h"

@interface VXPromotionModalViewController : UINavigationController

- (instancetype)initWithArrayOfAppIDs:(NSArray*)pApps;
- (instancetype)initWithAddress:(NSString*)urlString;


@property (nonatomic, strong) UIColor *barTintColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) NSString *appID;
@end
