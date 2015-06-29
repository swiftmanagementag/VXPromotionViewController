//
//  VXPromotionViewController.m
//
//  Created by Swift Management AG on 18.12.2014.
//  Copyright 2010 Swift Management AG. All rights reserved.
//
//  https://github.com/swiftmanagementag/VXPromotionViewController

#import "VXPromotionViewController.h"
#import "VXPromotionApp.h"
#import <StoreKit/StoreKit.h>

@interface VXPromotionViewController () <SKStoreProductViewControllerDelegate, VXDownloadDelegate>


@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSMutableArray *apps;
@property (nonatomic, strong) NSMutableDictionary *appsLoaded;
@property (nonatomic, strong) NSMutableDictionary *appsImages;
@property (nonatomic, strong) UIPopoverController *popover;

@end


@implementation VXPromotionViewController

#pragma mark - Initialization

- (instancetype)initWithAddress:(NSString *)urlString {
	self = [super init];
	if (self) {
		self.address = urlString;
	}
	return self;
}

- (instancetype)initWithArrayOfAppIDs:(NSArray*)pApps {
	self = [super init];
	if (self) {
		self.apps = [pApps mutableCopy];
	}
	return self;
}

- (void)dealloc {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
	[super viewDidLoad];
	
	// initialise holding arrays
	self.appsLoaded = [[NSMutableDictionary alloc] init];
	self.appsImages = [[NSMutableDictionary alloc] init];

	if(self.appID) {
		UIBarButtonItem *rateButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"VXPromotionViewController.bundle/VXPromotionViewControllerRate"] style:UIBarButtonItemStylePlain
																				target:self
																				action:@selector(rateButtonTapped:)];
		UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
																				target:self
																				action:@selector(shareButtonTapped:)];
		self.navigationItem.rightBarButtonItems = @[shareButton,rateButton];
	}
	[self load];
}

- (void)viewWillAppear:(BOOL)animated {
	NSAssert(self.navigationController, @"VXPromotionViewController needs to be contained in a UINavigationController. If you are presenting VXPromotionViewController modally, use VXPromotionModalViewController instead.");
	
	[super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[super viewDidDisappear:animated];
}


- (void)load {
	if(self.address) {
		// initialise storage
		self.apps = [NSMutableArray array];
		// load apps from address - table is reloaded on completion
		[VXPromotionApp downloadWithURL:self.address withDelegate:self];
	} else if (self.apps) {
		if(self.country == nil) {
			NSLocale *locale = [NSLocale currentLocale];
			self.country = [[locale objectForKey: NSLocaleCountryCode] lowercaseString];
		}
		if(self.language == nil) {
			self.language = [[NSLocale preferredLanguages] firstObject];
		}
		// load apps using string array
		for(NSString* appID in self.apps) {
			[VXPromotionApp download:appID withCountry:self.country withLanguage:self.language withDelegate:self];
		}
		// reload table
		[self.tableView reloadData];

	}
}
-(void)downloadCompleteWithApps:(NSArray *)pApps {
	if(pApps) {
		BOOL reloadTable = NO;
		
		for (VXPromotionApp *app in pApps) {
			// app id should be a string
			NSString *appID = [NSString stringWithFormat:@"%@", app.productID ];

			// filter our your own app id
			if(appID && (self.address == nil || self.appID == nil  || ![appID isEqualToString:self.appID])) {
				// store app in cache
				[self.appsLoaded setValue:app forKey:appID];
				
				// check if the app exists in the apps array
				long row = [self.apps indexOfObject:appID];
		
				if(row != NSNotFound) {
					NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
				
					reloadTable = YES;
					// this causes crashes
					//[self.tableView beginUpdates];
					//[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
					//[self.tableView endUpdates];
				} else {
					reloadTable = YES;
					[self.apps addObject:appID];
				}
			}
		}
		if(reloadTable ){
			[self.tableView reloadData];
		}
	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}
- (NSString *)imageFilePath:(NSString*)pAppID {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"vxpromotion_%@.png", pAppID]];
}

#pragma mark Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.apps.count;
}
-(UIImage*)resizedImage:(UIImage*)pImage withSize:(CGSize)pSize{
	UIGraphicsBeginImageContextWithOptions(pSize, NO, UIScreen.mainScreen.scale);

	// Make a trivial (1x1) graphics context, and draw the image into it
	CGRect imageRect = CGRectMake(0.0, 0.0, pSize.width, pSize.height);

	[pImage drawInRect:imageRect];
	UIImage *imageSized = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();

	return imageSized ?: pImage;
}

-(void)configureCell:(UITableViewCell*)pCell withIndexPath:(NSIndexPath*)indexPath withApp:(VXPromotionApp*)pApp {
	double margin = 4.0f;
	double height = [self tableView:self.tableView heightForRowAtIndexPath:indexPath];

	if(pApp && pApp.name) {
		pCell.textLabel.text = pApp.name;
		pCell.detailTextLabel.text = pApp.text;
		
		UIImage __block *image =[self.appsImages objectForKey:pApp.icon];
		if(image) {
			[pCell.imageView setImage:[self resizedImage:image withSize:CGSizeMake(height - 2*margin,height - 2*margin)]];
		} else {
			NSString __block *fileName = [self imageFilePath:pApp.productID];
			image = [[UIImage alloc] initWithContentsOfFile:fileName];
			
			if(image) {
				[pCell.imageView setImage:[self resizedImage:image withSize:CGSizeMake(height - 2*margin,height - 2*margin)]];
		} else {
			[pCell.imageView setImage:[UIImage imageNamed:@"placeholder.png"]];
				
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
					image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pApp.icon]]];
					UIImage *imageSized = [self resizedImage:image withSize:CGSizeMake(height - 2*margin,height - 2*margin)];
			
				// Now the image will have been loaded and decoded and is ready to rock for the main thread
				dispatch_sync(dispatch_get_main_queue(), ^{
						[pCell.imageView setImage:imageSized];
					[pCell setNeedsLayout];
					[pCell.imageView setNeedsDisplay];
						[self.appsImages setValue:imageSized forKey:pApp.icon];
						
						
				});
					
					if(imageSized) {
						NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
						[imageData writeToFile:fileName atomically:YES];
					}
			});
		}
		}
		pCell.imageView.backgroundColor = [UIColor clearColor];
		pCell.imageView.layer.cornerRadius = 2*margin;
		pCell.imageView.layer.masksToBounds = YES;
		pCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	}
};

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"VXPromotionCell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[	UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
	NSString *productID = [self.apps objectAtIndex:indexPath.row];
	
	VXPromotionApp *app = [self.appsLoaded valueForKey:productID];
	
	[self configureCell:cell withIndexPath:indexPath withApp:app];
	
	return cell;
}

#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
#if TARGET_IPHONE_SIMULATOR
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[self.class description] message:@"Sorry, you cannot open the Storekit Controller in Simulator." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	[alertView show];
	return;
#else
	NSString *productID = [self.apps objectAtIndex:indexPath.row];
	
	//[[UINavigationBar appearance] setTintColor:[UIColor darkTextColor]];
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
#endif
}
#pragma mark - Actions
- (void)doneButtonTapped:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rateButtonTapped:(id)sender {
#if TARGET_IPHONE_SIMULATOR
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[self.class description] message:@"Sorry, you cannot open the Storekit Controller in Simulator." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	
	[alertView show];
	return;
#else
	
	SKStoreProductViewController *controller = [[SKStoreProductViewController alloc] init];
	controller.delegate = self;
	[controller loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:self.appID} completionBlock:^(BOOL result, NSError *error) {
		if (error) {
			NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
		} else {
			// Present Store Product View Controller
			[self presentViewController:controller animated:YES completion:nil];
		}
	}];
#endif
}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
	[viewController dismissViewControllerAnimated:YES completion:nil];
}
- (void)shareButtonTapped:(id)sender {
	NSString *url = [NSString stringWithFormat:@"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@", self.appID];
	NSURL *urlToShare = [NSURL URLWithString:url];
	
	NSString *textToShare = NSLocalizedString(@"VXPromotionShareTemplateCustom", nil);
	
	if(textToShare == nil || [textToShare length]==0 || [textToShare isEqualToString:@"VXPromotionShareTemplateCustom"]) {
		textToShare = NSLocalizedStringFromTable(@"VXPromotionShareTemplate", @"VXPromotionViewController", nil);
	}
	
	NSMutableArray *activityItems = [@[textToShare, urlToShare] mutableCopy];
	
	UIImage *imageToShare = nil;
	
	for(NSString *imageName in @[@"Icon@2x", @"Icon", @"Icon-60", @"Icon-76", @"Icon-60@2x", @"logo.png"]) {
		imageToShare = [UIImage imageNamed:imageName];
		if(imageToShare != nil) {
			break;
		}
	}
		
	if(imageToShare != nil) {
		[activityItems addObject:imageToShare];
	}
	
	UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems  applicationActivities:nil];
	activityVC.excludedActivityTypes = @[UIActivityTypePostToWeibo,  UIActivityTypeAssignToContact, UIActivityTypeMessage, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];

	if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
		[self presentViewController:activityVC animated:YES completion:^{
			//your completion here
		}];
	} else {
		self.popover = [[UIPopoverController alloc] initWithContentViewController:activityVC];
		[self.popover presentPopoverFromBarButtonItem:(UIBarButtonItem*)sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
		
	}
	
}

@end
