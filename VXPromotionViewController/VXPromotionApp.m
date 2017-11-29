//
//  VXApp.m
//  hazard
//
//  Created by Graham Lancashire on 22.01.14.
//  Copyright (c) 2014 Swift Management AG. All rights reserved.
//

#import "VXPromotionApp.h"

@implementation VXPromotionApp

+ (NSString *)jsonFilePathFor:(NSString*)pString {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	pString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(__bridge CFStringRef) pString, NULL,CFSTR("!*'();:@+$,/?%#[]"),kCFStringEncodingUTF8));
	
	NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];

	return [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"vxpromotion_%@_%li%li.json", pString, (long)[components year], (long)[components month]] ];
}


+(void)download:(NSString*)pID withCountry:(NSString*)pCountry withLanguage:(NSString*)pLanguage withDelegate:(id <VXDownloadDelegate>)pDelegate{
	// check local cache
	NSString *fileName = [VXPromotionApp jsonFilePathFor:[NSString stringWithFormat:@"%@%@%@", pID, pCountry, pLanguage]];

	NSData* data = [NSData dataWithContentsOfFile:fileName];
	
	if(data) {
		[pDelegate downloadCompleteWithApps:[VXPromotionApp processJSON:data]];
	} else {
	// build apple conforming url
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/%@/lookup?id=%@&entity=software&lang=%@&limit=100", pCountry, pID, pLanguage];
	
	// download
	[self downloadWithURL:url withDelegate:pDelegate];
	}
	
}
+(NSMutableArray*)processJSON:(NSData*)pData {
			   NSMutableArray *apps = [NSMutableArray array];
			   long counter = 0;
			   
	if(pData.length != 0 ) {
		id jsonResult = [NSJSONSerialization JSONObjectWithData:pData options:0 error:nil];

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
	}
	return apps;
}
+(void)downloadWithURL:(NSString*)pURL withDelegate:(id <VXDownloadDelegate>)pDelegate{
	// check local cache
	NSString *fileName = [VXPromotionApp jsonFilePathFor:pURL];
	NSData* data = [NSData dataWithContentsOfFile:fileName];
	
	if(data) {
		[pDelegate downloadCompleteWithApps:[VXPromotionApp processJSON:data]];
	} else {
		
		// show downloading indicator
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
		
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:pURL]];
		
		[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
			   completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)  {
				   [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
				   if(connectionError && data && [data length] != 0) {
					   [pDelegate downloadCompleteWithApps:nil];
				   } else {
					   [pDelegate downloadCompleteWithApps:[VXPromotionApp processJSON:data]];
					   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
						   [data writeToFile:fileName atomically:YES];
					   });
				}
   }];
}
}
@end
