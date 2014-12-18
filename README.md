# VXPromotionViewController

VXPromotionViewController is a simple inline browser for your iOS 7 app.

![VXPromotionViewController](http://cl.ly/SQVO/download/GitHub.png)

**VXPromotionViewController features:**

* iPhone and iPad distinct UIs
* full landscape orientation support
* back, forward, stop/refresh and share buttons
* Open in Safari and Chrome UIActivities
* navbar title set to the currently visible web page
* talks with `setNetworkActivityIndicatorVisible`

## Installation

### CocoaPods

I'm not a big fan of CocoaPods, so tend to not keep it updated. If you really want to use VXPromotionViewController with CocoaPods, I suggest you use `pod 'VXPromotionViewController', :head` to pull from the `master` branch directly. I'm usually careful about what I push there and is the version I use myself in all my projects.

### Manually

* Drag the `VXPromotionViewController/VXPromotionViewController` folder into your project.
* `#import "VXPromotionViewController.h"`

## Usage

(see sample Xcode project in `/Demo`)

Just like any UIViewController, VXPromotionViewController can be pushed into a UINavigationController stack:

```objective-c
VXPromotionViewController *webViewController = [[VXPromotionViewController alloc] initWithAddress:@"http://google.com"];
[self.navigationController pushViewController:webViewController animated:YES];
```

It can also be presented modally using `VXPromotionModalViewController`:

```objective-c
VXPromotionModalViewController *webViewController = [[VXPromotionModalViewController alloc] initWithAddress:@"http://google.com"];
[self presentViewController:webViewController animated:YES completion:NULL];
```

### VXPromotionViewControllerActivity

Starting in iOS 6 Apple uses `UIActivity` to let you show additional sharing methods in share sheets. `VXPromotionViewController` comes with "Open in Safari" and "Open in Chrome" activities. You can easily add your own activity by subclassing `VXPromotionViewControllerActivity` which takes care of a few things automatically for you. Have a look at the Safari and Chrome activities for implementation examples. Feel free to send it as a pull request once you're done!


## Credits

VXPromotionViewController is brought to you by [Swift Management AG](http://swiftmanagementag.com) and [contributors to the project](https://github.com/swiftmanagementag/VXPromotionViewController/contributors). If you have feature suggestions or bug reports, feel free to help out by sending pull requests or by [creating new issues](https://github.com/swiftmanagementag/VXPromotionViewController/issues/new). If you're using VXPromotionViewController in your project, attribution is always appreciated.
