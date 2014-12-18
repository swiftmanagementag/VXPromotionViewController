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


- (void)pushWebViewController {
    NSURL *URL = [NSURL URLWithString:@"http://swift.ch"];
	VXPromotionViewController *webViewController = [[VXPromotionViewController alloc] initWithURL:URL];
	[self.navigationController pushViewController:webViewController animated:YES];
}


- (void)presentWebViewController {
	NSURL *URL = [NSURL URLWithString:@"http://swift.ch"];
	VXPromotionModalViewController *webViewController = [[VXPromotionModalViewController alloc] initWithURL:URL];
	webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:webViewController animated:YES completion:NULL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


@end

