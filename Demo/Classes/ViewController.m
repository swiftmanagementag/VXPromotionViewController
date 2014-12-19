//
//  RootViewController.m
//  VXPromotionViewController
//
//  Created by Swift Management AG on 18.12.2014.
//  Copyright 2011 Swift Management AG. All rights reserved.
//

#import "ViewController.h"
#import "VXPromotionViewController.h"
#import "VXPromotionModalViewController.h"


@implementation ViewController


- (void)pushViewController {
	VXPromotionViewController *promoViewController = [[VXPromotionViewController alloc] initWithArrayOfAppIDs:@[@"499346672", @"450499218", @"742018969"]];
	promoViewController.appID = @"499346672";
	[self.navigationController pushViewController:promoViewController animated:YES];
}


- (void)presentViewController {
	VXPromotionModalViewController *promoViewController = [[VXPromotionModalViewController alloc] initWithAddress:@"http://www.swift.ch/api/ch/de"];
	promoViewController.modalPresentationStyle = UIModalPresentationPageSheet;
	promoViewController.appID = @"499346672";
    [self presentViewController:promoViewController animated:YES completion:NULL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


@end

