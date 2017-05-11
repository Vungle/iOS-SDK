# Vungle's iOS-SDK
[![Version](https://img.shields.io/cocoapods/v/VungleSDK-iOS.svg?style=flat)](http://cocoapods.org/pods/VungleSDK-iOS)
[![License](https://img.shields.io/cocoapods/l/VungleSDK-iOS.svg?style=flat)](http://cocoapods.org/pods/VungleSDK-iOS)
[![Platform](https://img.shields.io/cocoapods/p/VungleSDK-iOS.svg?style=flat)](http://cocoapods.org/pods/VungleSDK-iOS)

## Getting Started
To get up and running with Vungle, you'll need to [Create an Account With Vungle](https://v.vungle.com/dashboard) and [Add an Application to the Vungle Dashboard](https://support.vungle.com/hc/en-us/articles/210468678)

Once you've created an account you can follow our [Getting Started for iOS Guide](https://support.vungle.com/hc/en-us/articles/204430550-Getting-Started-with-Vungle-iOS-SDK) to complete the integration. Remember to get the Vungle App ID from the Vungle dashboard.

The Vungle iOS SDK can also be installed via [CocoaPods](https://cocoapods.org/).  To install the Vungle iOS-SDK via CocoaPods add the following line to your Podfile and re-run the `pod install` command:

```ruby
pod "VungleSDK-iOS"
```

The latest information around our CocoaPods support can be found at the [VungleSDK-iOS CocoaPods Page](https://cocoapods.org/pods/VungleSDK-iOS)

### Version Info
The Vungle iOS SDK supports iOS 7+, iOS 10 with limited ad tracking, and both 32bit and 64bit apps.  

Our newest iOS SDK (4.1.0) was released on May 10th, 2017. Please ensure you are using Xcode 7.0 or higher to ensure smooth integration.

## Release Notes
### 4.1.0
* Fix for occurrence of a black screen at the end of video
* Cache improvements
* Migrate to UIWebView for end cards on iOS 9 and 10 to address memory leak in UIWebView
* Set user-agent in HTTP header to platform user agent for all external requests
* StoreKit support for MRAID ads

### 4.0.9
* Fix wrong behavior for the willCloseAdWithViewInfo: delegate method
* Improved SDK initialization
* Minor fixes and performance improvements
* Fix user-agent field on requests

### 4.0.8
* Refresh the IDFA when app comes to foreground
* Minor fixes

### 4.0.6
* Add cache early check to initial operation chain 
* Prefix 3rd party zip/unzip lib functions 
* Track and use the didDownload state for legacy ads

### 4.0.5
* Bug fixes
* Performance improvement

### 4.0.4
* iOS 10 OS performance optimizations
* CloudUX functionality support
* Vungle unique id implementation to maintain publisher frequency capping
* Fix click area around CTA button


## License
The Vungle iOS-SDK is available under a commercial license. See the LICENSE file for more info.
