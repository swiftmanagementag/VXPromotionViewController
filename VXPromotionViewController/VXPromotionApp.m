//
//  VXApp.m
//  hazard
//
//  Created by Graham Lancashire on 22.01.14.
//  Copyright (c) 2014 Swift Management AG. All rights reserved.
//

#import "VXPromotionApp.h"

@implementation VXPromotionApp

+(void)download:(NSString*)pID withCountry:(NSString*)pCountry withLanguage:(NSString*)pLanguage withDelegate:(id <VXDownloadDelegate>)pDelegate{
	// show downloading indicator
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
	// build apple conforming url
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/%@/lookup?id=%@&entity=software&lang=%@&limit=100", pCountry, pID, pLanguage];
	
	// download
	[self downloadWithURL:url withDelegate:pDelegate];
	
}
+(void)downloadWithURL:(NSString*)pURL withDelegate:(id <VXDownloadDelegate>)pDelegate{
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:pURL]];
	
	[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
	 	   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)  {
			   NSMutableArray *apps = [NSMutableArray array];
			   
			   long counter = 0;
			   
			   if(data.length != 0 && !connectionError ) {
				   id jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

				   NSArray* jsonObjects = nil;
				   if([jsonResult isKindOfClass:[NSDictionary class]]) {
					   jsonObjects = [(NSDictionary*)jsonResult valueForKey:@"results"];
				   } else if([jsonResult isKindOfClass:[NSArray class]]) {
					   jsonObjects = (NSArray*)jsonResult;
				   }
				   if(jsonObjects) {
					   for (NSDictionary *object in jsonObjects) {
					   counter ++;
					   VXPromotionApp *app = [[VXPromotionApp alloc] init];
					   
					   app.position = [NSString stringWithFormat:@"%li", counter];
					   app.productID = [object valueForKey:@"trackId"];
					   app.name = [object valueForKey:@"trackName"];
					   app.category = [object valueForKey:@"primaryGenreName"];
					   app.text = [object valueForKey:@"description"];
					   app.currency = [object valueForKey:@"currency"];
					   app.publisher = [object valueForKey:@"artistName"];
					   app.version = [object valueForKey:@"version"];
					   app.price	= [object valueForKey:@"formattedPrice"];
					   app.releaseDate =[object valueForKey:@"releaseDate"];
					   app.bundleID =[object valueForKey:@"bundleId"];
					   app.icon =[object valueForKey:@"artworkUrl100"];
					   
					   [apps addObject:app];
					}
				   }
				   [pDelegate downloadCompleteWithApps:apps];
				} else {
					[pDelegate downloadCompleteWithApps:apps];
				}
				[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   }];
}
@end
