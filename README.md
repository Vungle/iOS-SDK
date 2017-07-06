## Getting Started
Please refer to https://support.vungle.com/hc/en-us/articles/115000477452


### Version Info
The Vungle iOS SDK supports iOS 8+, iOS 10 with limited ad tracking, and both 32bit and 64bit apps.  

Our newest iOS SDK (5.1.0) was released on July 5th, 2017. Please ensure you are using Xcode 7.0 or higher to ensure smooth integration.

## Release Notes
### 5.1.0
* Launched new Placements feature.
* Added Native Flex View ad unit. 
* Added Moat Viewability technology.
* Added GZIP for faster network transfers.
* Migrate MRAID to WKWebView on iOS 9 and 10 to address memory leak in UIWebView.
* Disabled iOS 7 support.

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
