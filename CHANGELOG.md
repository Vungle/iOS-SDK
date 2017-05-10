## Changelog
## VERSION 4.1.0
* Fix for occurrence of a black screen at the end of video.
* Fix to accurately report ad views.
* Implementation of WKWebView for end cards on iOS 9 and 10.
* Set user-agent in HTTP header to platform user agent for all external requests.
* StoreKit support for MRAID ads.
* Plug memory leaks and squash bugs.

## VERSION 4.0.9
* Fix wrong behavior for the willCloseAdWithViewInfo: delegate method
* Improved SDK initialization
* Minor fixes and performance improvements
* Fix user-agent field on requests

## VERSION 4.0.8
* Refresh the IDFA when app comes to foreground
* Minor fixes

## VERSION 4.0.6
* Add cache early check to initial operation chain 
* Prefix 3rd party zip/unzip lib functions 
* Track and use the didDownload state for legacy ads

## VERSION 4.0.5
* Bug fixes
* Performance improvement

## VERSION 4.0.4
* iOS 10 OS performance optimizations
* CloudUX functionality support
* Vungle unique id implementation to maintain publisher frequency capping
* Fix click area around CTA button 
* Resume video when app comes to foreground 
* Add logging when the publisher uses a wrong appId 


## VERSION 3.2.2
* Fix presenting modal view controller exception

## VERSION 3.2.1
* Bitcode support!
* Initialization prevention for devices under iOS 7.0
* Multiple initialization crash fix

## VERSION 3.2.0
* This SDK supports iOS 7+ devices only
* Enabled SSL as default for all internal network requests
* Improved caching performance
* Resolved race-condition crash around fetchConfig request
* Unified adPlayable behavior across flags & events
* Fix for playAd return code inconsistency during streaming ad plays
* Fix for progress bar location on smaller screens
* Fix for AppStore failing to load on some occasions
* Fix for issues resulting in inaccessible postroll

## VERSION 3.1.2
* Bug fixes

## VERSION 3.1.0
* API changed in Vungle delegate protocol: `vungleSDKhasCachedAdAvailable` changed to `vungleSDKAdPlayableChanged:`
* API changed in Vungle singleton: `isCachedAdAvailable` deprecated in favor of `isAdPlayable`
* New UI while playing video
* Bug fixes (background related bug, networking improvements)

## VERSION 3.0.13
* Minor Bug Fixes

## VERSION 3.0.12
* Fixes crash that happened on rare occasions when sending the app to the background
* Improves re-queuing of network requests. It should improve the ability to re-send requests even after they failed.
* Move saved /reportAds from cache directory to app support directory
* Option to modify incentivized alert text (title, body, close button, and continue button)

### VERSION 3.0.11
* Deprecated VunglePlayAdOptionKeyShowClose
* Deprecated VungleSDK#playAd: & VungleSDK#playAd:withOptions:
* Fixed some minor memory leaks
* Fixed orientations issues on iOS 8
* Fixed some random crashes on very limited edge cases
* Moved internal database from Documents to App Support

### VERSION 3.0.10
* Fixed crash that killed the app when sent to the background (in rare conditions)
* Fixed postroll and corrupted video bugs
* Improved support for iOS 8

### VERSION 3.0.9

* improved iOS 5 support
* fixed TPAT bugs

### VERSION 3.0.8

* added global playAd options
* added placements for each play, as well as dev-defined extra keys
* Fix a few mem leaks
* Send post params instead of query params for /sessionEnd
* miniz symbols no longer exposed
* Delegate methods are optional now
