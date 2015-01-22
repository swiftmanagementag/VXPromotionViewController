//
//  VXPromotionModalViewController.m
//
//  Created by Oliver Letterer on 13.08.11.
//  Copyright 2011 Home. All rights reserved.
//
//  https://github.com/swiftmanagementag/VXPromotionViewController

#import "VXPromotionModalViewController.h"

@interface VXPromotionModalViewController ()
@property (nonatomic, strong) VXPromotionViewController *promoViewController;
@end

@interface VXPromotionViewController (DoneButton)

- (void)doneButtonTapped:(id)sender;
- (void)rateButtonTapped:(id)sender;
- (void)shareButtonTapped:(id)sender;

@end


@implementation VXPromotionModalViewController

#pragma mark - Initialization


- (instancetype)initWithAddress:(NSString*)urlString {
	self.promoViewController = [[VXPromotionViewController alloc] initWithAddress:urlString];
	return [self initController];
}

- (instancetype)initWithArrayOfAppIDs:(NSArray *)pApps {
	self.promoViewController = [[VXPromotionViewController alloc] initWithArrayOfAppIDs:pApps];
	
	return [self initController];
	
}

- (instancetype)initController {
	if (self = [super initWithRootViewController:self.promoViewController]) {
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																					target:self.promoViewController
																					action:@selector(doneButtonTapped:)];
		self.promoViewController.navigationItem.leftBarButtonItem = doneButton;
	}
	return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
	
    self.promoViewController.title = self.title;
	if(self.tintColor) {
		self.navigationBar.tintColor = self.tintColor;
	}
	if(self.barTintColor) {
		self.navigationBar.barTintColor = self.barTintColor;
	}
}

-(void)setAppID:(NSString *)appID {
	if(self.promoViewController) {
		self.promoViewController.appID = appID;
	}
}
-(NSString *)appID {
	if(self.promoViewController) {
		return self.promoViewController.appID;
	} else {
		return nil;
	}
}
@end
