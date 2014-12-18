# VXPromotionViewController

VXPromotionViewController is a simple inline promotion display for your iOS 7 app.

![VXPromotionViewController](http://cl.ly/SQVO/download/GitHub.png)

**VXPromotionViewController features:**

* iPhone and iPad distinct UIs
* full landscape orientation support

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

```objective-c
VXPromotionViewController *promoViewController = [[VXPromotionViewController alloc] initWithAddress:@"http://google.com"];
[self.navigationController pushViewController:promoViewController animated:YES];
```

It can also be presented modally using `VXPromotionModalViewController`:

```objective-c
VXPromotionModalViewController *promoViewController = [[VXPromotionModalViewController alloc] initWithAddress:@"http://google.com"];
[self presentViewController:promoViewController animated:YES completion:NULL];
```

### VXPromotionViewControllerActivity

Starting in iOS 6 Apple uses `UIActivity` to let you show additional sharing methods in share sheets. `VXPromotionViewController` comes with "Open in Safari" and "Open in Chrome" activities. You can easily add your own activity by subclassing `VXPromotionViewControllerActivity` which takes care of a few things automatically for you. Have a look at the Safari and Chrome activities for implementation examples. 


## Credits

VXPromotionViewController is based on Sam Vermettes [SVWebViewController](https://github.com/samvermette/SVWebViewController).
VXPromotionViewController is brought to you by [Swift Management AG](http://www.swift.ch) and [contributors to the project](https://github.com/swiftmanagementag/VXPromotionViewController/contributors). If you have feature suggestions or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/swiftmanagementag/VXPromotionViewController/issues/new). If you're using VXPromotionViewController in your project, attribution is always appreciated.
