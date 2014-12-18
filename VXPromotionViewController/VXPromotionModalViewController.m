//
//  VXPromotionModalViewController.m
//
//  Created by Oliver Letterer on 13.08.11.
//  Copyright 2011 Home. All rights reserved.
//
//  https://github.com/swiftmanagementag/VXPromotionViewController

#import "VXPromotionModalViewController.h"
#import "VXPromotionViewController.h"

@interface VXPromotionModalViewController ()

@property (nonatomic, strong) VXPromotionViewController *promoViewController;

@end

@interface VXPromotionViewController (DoneButton)

- (void)doneButtonTapped:(id)sender;

@end


@implementation VXPromotionModalViewController

#pragma mark - Initialization


- (instancetype)initWithAddress:(NSString*)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL *)URL {
    return [self initWithURLRequest:[NSURLRequest requestWithURL:URL]];
}

- (instancetype)initWithURLRequest:(NSURLRequest *)request {
    self.promoViewController = [[VXPromotionViewController alloc] initWithURLRequest:request];
	return [self initController];
}
- (instancetype)initWithApps:(NSArray *)pApps {
	self.promoViewController = [[VXPromotionViewController alloc] initWithApps:pApps];
	
	return [self initController];
	
}

- (instancetype)initController {
	if (self = [super initWithRootViewController:self.promoViewController]) {
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																					target:self.promoViewController
																					action:@selector(doneButtonTapped:)];
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
			self.promoViewController.navigationItem.leftBarButtonItem = doneButton;
		else
			self.promoViewController.navigationItem.rightBarButtonItem = doneButton;
	}
	return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:NO];
	
    self.promoViewController.title = self.title;
    self.navigationBar.tintColor = self.barsTintColor;
}

@end
