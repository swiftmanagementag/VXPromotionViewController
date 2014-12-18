//
//  ATFlipsideViewController.h
//  hazard
//
//  Created by Graham Lancashire on 07.11.13.
//  Copyright (c) 2013 Swift Management AG. All rights reserved.
//
#import "HZAppDelegate.h"
#import "HZPromotionViewController.h"
#import "HZStoreCell.h"
#import "UIColor+Palette.h"
#import "NSDate+Category.h"
#import "SVProgressHUD.h"
#import "VXApp.h"
#import "Appirater.h"
#import <SDWebImage/UIImageView+WebCache.h>


/****
 Nasty hack to avoid crash when running in landscape only!
***/
@interface SKStoreProductViewController(Nonrotating)
- (BOOL)shouldAutorotate;
@end

@implementation SKStoreProductViewController(Nonrotating)

- (BOOL)shouldAutorotate {
	return NO;
}
@end

@interface HZPromotionViewController()<VXDownloadDelegate,SKStoreProductViewControllerDelegate>

@end
@implementation HZPromotionViewController {
    NSArray *_products;
    NSDictionary *_productsLoaded;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[HZAppDelegate track:@"Promotion Screen"];
	
	

	// set promoted products
    _products = PROMOTED_APPS;

	[self load];
}

- (void)load {
   	self.navItem.title = NSLocalizedString(@"promotionTitle", @"");

	_productsLoaded = [[NSMutableDictionary alloc] init];
	
	for(NSString* productID in _products) {
		VXApp* app = [[VXApp alloc] init];
		NSString* language = [[HZAppDelegate getLanguage] lowercaseString];
		[app download:productID withCountry:COUNTRY_CODE withLanguage:language withDelegate:self];
		[_productsLoaded setValue:app forKey:productID];
	}
	[self.tableView reloadData];
}

-(void)downloadComplete:(NSString*)pID withApp:(VXApp *)pApp {
	[_productsLoaded setValue:pApp forKey:pID];
	
	long row = [_products indexOfObject:pID];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];

	// update the correct row...
	[self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Actions

#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}
-(void)configureCell:(HZStoreCell*)pCell withApp:(VXApp*)pApp {
	if(pApp && pApp.name) {
		pCell.labelTitle.text = pApp.name;
		pCell.labelDescription.text = pApp.description;
		
		[pCell.iconView sd_setImageWithURL:[NSURL URLWithString:pApp.icon]  placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
		pCell.iconView.backgroundColor = [UIColor clearColor];
		pCell.iconView.layer.cornerRadius = 12.0f;
		pCell.iconView.layer.masksToBounds = YES;

		pCell.shadowView.layer.cornerRadius = 12.0f;
		pCell.shadowView.layer.masksToBounds = YES;

		[pCell.buttonPurchase setTitle:NSLocalizedString(@"ViewInAppStore", "ViewInAppStore") forState:UIControlStateNormal];
	}
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"StoreCell";
    HZStoreCell *cell = (HZStoreCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[HZStoreCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSString *productID = [_products objectAtIndex:indexPath.row];

	VXApp *app = [_productsLoaded valueForKey:productID];

	[self configureCell:cell withApp:app];
    
	return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *productID = [_products objectAtIndex:indexPath.row];
	//	itms-apps://itunes.apple.com/app/idAPP_ID

	[HZAppDelegate track:[NSString stringWithFormat:@"Product Recommendation %@", productID]];

	
	[[UINavigationBar appearance] setTintColor:[UIColor darkTextColor]];
	SKStoreProductViewController *controller = [[SKStoreProductViewController alloc] init];
	controller.delegate = self;
    
	[controller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:productID} completionBlock:^(BOOL result, NSError *error) {
        if (error) {
            NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
        } else {
            // Present Store Product View Controller
			[self presentViewController:controller animated:YES completion:nil];
        }
    }];
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];

	

}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController{
	[viewController dismissViewControllerAnimated:YES completion:nil];
	[[UINavigationBar appearance] setTintColor:[UIColor textColor]];
}

- (IBAction)rate:(id)sender{
	[Appirater rateApp];
}


@end
