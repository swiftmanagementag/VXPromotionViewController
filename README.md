# VXPromotionViewController

VXPromotionViewController is a simple inline and cross promotion display for your iOS 7 app.
It can load the app information from the Apple AppStore or from your own JSON source.
You can specify specific apps or load available apps for a publisher.

![VXPromotionViewController](https://raw.githubusercontent.com/swiftmanagementag/VXPromotionViewController/master/screenshot.png)

**VXPromotionViewController features:**

* iPhone and iPad distinct UIs
* full landscape orientation support

## Release notes

### 1.0.11
Removing current app from list is now configurable

### 1.0.10
Activity indicator
Support for affiliate code
Better iPad support
Bug squashing

### 1.0.9
Move to resource bundles

### 1.0.8
Some minor changes to improve compatability with IOS10

### 1.0.7
Added loading indicator in status bar for longer running tasks
Fixed automatic language error for certain locales
Added localisations (thanks for corrections)
Recompiled and fixed warnings under XCode 7.2.1

## Installation

### CocoaPods

If you want to use VXPromotionViewController with CocoaPods
`pod 'VXPromotionViewController', :head`

### Manually

* Drag the `VXPromotionViewController/VXPromotionViewController` folder into your project.
* `#import "VXPromotionViewController.h"`

## Usage

(see sample Xcode project in `/Demo`)

Just like any UIViewController, VXPromotionViewController can be pushed into a UINavigationController stack:
If you specify your app id, a rating and share button is displayed

```objective-c
VXPromotionViewController *promoViewController = [[VXPromotionViewController alloc] initWithAddress:@"https://www.swift.ch/api/ch/de"];
promoViewController.appID = @"499346672";
[self.navigationController pushViewController:promoViewController animated:YES];
```

It can also be presented modally using `VXPromotionModalViewController`:

```objective-c
VXPromotionModalViewController *promoViewController = [[VXPromotionModalViewController alloc] initWithArrayOfAppIDs:@[@"499346672", @"450499218", @"742018969"]];
promoViewController.appID = @"499346672";
[self presentViewController:promoViewController animated:YES completion:NULL];
```

## Credits

VXPromotionViewController is based on Sam Vermettes [SVWebViewController](https://github.com/samvermette/SVWebViewController).
VXPromotionViewController is brought to you by [Swift Management AG](https://www.swift.ch) and [contributors to the project](https://github.com/swiftmanagementag/VXPromotionViewController/contributors). If you have feature suggestions or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/swiftmanagementag/VXPromotionViewController/issues/new). If you're using VXPromotionViewController in your project, attribution is always appreciated.
