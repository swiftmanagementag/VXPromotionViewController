//
//  VXApp.h
//  hazard
//
//  Created by Graham Lancashire on 22.01.14.
//  Copyright (c) 2014 Swift Management AG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VXPromotionApp;

@protocol VXDownloadDelegate <NSObject>

-(void)downloadCompleteWithApps:(NSArray*)pApps;

@end

@interface VXPromotionApp : NSObject

@property (nonatomic, strong) NSString	*name;
@property (nonatomic, strong) NSString	*text;
@property (nonatomic, strong) NSString	*version;
@property (nonatomic, strong) NSString	*category;
@property (nonatomic, strong) NSString	*publisher;
@property (nonatomic, strong) NSString	*releaseDate;
@property (nonatomic, strong) NSString	*price;
@property (nonatomic, strong) NSString	*currency;

@property (nonatomic, strong) NSString	*link;
@property (nonatomic, strong) NSString	*icon;

@property (nonatomic, strong) NSString	*bundleID;
@property (nonatomic, strong) NSString	*productID;
@property (nonatomic, strong) NSString	*position;

// download single app or apps from a publisher
+(void)download:(NSString*)pID withCountry:(NSString*)pCountry withLanguage:(NSString*)pLanguage withDelegate:(id <VXDownloadDelegate>)pDelegate;

// download apps using a request, the result has to be in the appstore json format
+(void)downloadWithURL:(NSString*)pURL withDelegate:(id <VXDownloadDelegate>)pDelegate;

@end
