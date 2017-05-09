//
//  VungleSDK.h
//  Vungle iOS SDK
//  SDK Version: 4.1.0
//
//  Copyright (c) 2013-present Vungle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol VungleAssetLoader;

extern NSString *VungleSDKVersion;
extern NSString *VunglePlayAdOptionKeyIncentivized;
extern NSString *VunglePlayAdOptionKeyIncentivizedAlertTitleText;
extern NSString *VunglePlayAdOptionKeyIncentivizedAlertBodyText;
extern NSString *VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText;
extern NSString *VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText;
extern NSString *VunglePlayAdOptionKeyOrientations;
extern NSString *VunglePlayAdOptionKeyUser;
extern NSString *VunglePlayAdOptionKeyPlacement;
extern NSString *VunglePlayAdOptionKeyExtraInfoDictionary;
extern NSString *VunglePlayAdOptionKeyExtra1;
extern NSString *VunglePlayAdOptionKeyExtra2;
extern NSString *VunglePlayAdOptionKeyExtra3;
extern NSString *VunglePlayAdOptionKeyExtra4;
extern NSString *VunglePlayAdOptionKeyExtra5;
extern NSString *VunglePlayAdOptionKeyExtra6;
extern NSString *VunglePlayAdOptionKeyExtra7;
extern NSString *VunglePlayAdOptionKeyExtra8;
extern NSString *VunglePlayAdOptionKeyLargeButtons;

typedef enum {
    VungleSDKErrorInvalidPlayAdOption = 1,
    VungleSDKErrorInvalidPlayAdExtraKey,
    VungleSDKErrorCannotPlayAd,
    VungleSDKErrorNoAppID,
    VungleSDKErrorTopMostViewControllerMismatch
} VungleSDKErrorCode;

@protocol VungleSDKLogger <NSObject>
- (void)vungleSDKLog:(NSString *)message;
@end

@class VungleSDK;

@protocol VungleSDKDelegate <NSObject>
@optional
/**
 * if implemented, this will get called when the SDK is about to show an ad. This point
 * might be a good time to pause your game, and turn off any sound you might be playing.
 */
- (void)vungleSDKwillShowAd;

/**
 * If implemented, this method gets called when a Vungle Ad Unit is completely dismissed.
 * At this point, it's recommended to resume your Game or App.
 *
 * The `viewInfo` NSDictionary parameter will contain the following keys:
 * - "completedView": NSNumber representing a BOOL whether or not the video can be considered a
 *                    full view.
 * - "playTime": NSNumber representing the time in seconds that the user watched the video.
 * - "didDownload": NSNumber representing a BOOL whether or not the user clicked the download
 *                  button.
 * - "videoLength": **Deprecated** This will no longer be returned
 *
 * NOTE: the `willPresentProductSheet` parameter is *always* `NO`. Because
 * `vungleSDKWillCloseAdWithViewInfo:willPresentProductSheet:` is now called
 * after Product Sheet dismissal, this method should no longer be necessary. It will be
 * removed in a future version. Use `vungleSDKWillCloseAdWithViewInfo:` instead.
 */
- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo
                 willPresentProductSheet:(BOOL)willPresentProductSheet __attribute__((deprecated("Use vungleSDKWillCloseAdWithViewInfo: instead.")));

/**
 * If implemented, this will get called when the product sheet is about to be closed.
 *
 * @note Because `vungleSDKWillCloseAdWithViewInfo:willPresentProductSheet:` is now called
 * after Product Sheet dismissal, this method should no longer be necessary. It will be
 * removed in a future version.
 */
- (void)vungleSDKwillCloseProductSheet:(id)productSheet __attribute__((deprecated("Use vungleSDKWillCloseAdWithViewInfo: instead.")));

/**
 * If implemented, this method gets called when a Vungle Ad Unit is completely dismissed.
 * At this point, it's recommended to resume your Game or App.
 *
 * The `viewInfo` NSDictionary parameter will contain the following keys:
 * - "completedView": NSNumber representing a BOOL whether or not the video can be considered a
 *                    full view.
 * - "playTime": NSNumber representing the time in seconds that the user watched the video.
 * - "didDownload": NSNumber representing a BOOL whether or not the user clicked the download
 *                  button.
 * - "videoLength": **Deprecated** This will no longer be returned
 */
- (void)vungleSDKWillCloseAdWithViewInfo:(NSDictionary *)viewInfo;

/**
 * if implemented, this will get called when the SDK has an ad ready to be displayed. Also it will
 * get called with an argument `NO` when for some reason, there's no ad available, for instance
 * there is a corrupt ad or the OS wiped the cache.
 * Please note that receiving a `NO` here does not mean that you can't play an Ad: if you haven't
 * opted-out of our Exchange, you might be able to get a streaming ad if you call `play`.
 */
- (void)vungleSDKAdPlayableChanged:(BOOL)isAdPlayable;

@end

@interface VungleSDK : NSObject
@property (strong) NSDictionary *userData;
@property (strong) id<VungleSDKDelegate> delegate;
@property (strong) id<VungleAssetLoader> assetLoader;
@property (assign) BOOL muted;

/**
 * Returns the singleton instance.
 */
+ (VungleSDK *)sharedSDK;

/**
 * Setup the SDK with an asset loader. This must be called before any call to shareSDK in order
 * to properly set the asset loader.
 */
+ (VungleSDK *)setupSDKWithAssetLoader:(id<VungleAssetLoader>)loader;

/**
 * Initializes the SDK. You can get your app id on Vungle's dashboard: https://v.vungle.com
 */
- (void)startWithAppId:(NSString *)appId;

/**
 * Will play Ad Unit presenting it over the `viewController` parameter
 * @param viewController A subclass of UIViewController. Should correspond to the ViewControler at the top of the ViewController hierarchy
 * @param error An optional reference to an NSError. In case this method returns `NO` it will be non-nil
 * @return YES/NO in case of success/error while presenting an AdUnit
 * @warning Should be called from the main-thread.
 */
- (BOOL)playAd:(UIViewController *)viewController error:(NSError **)error;

/**
 * Will play Ad Unit presenting it over the `viewController` parameter and applying playback options.
 * @param viewController A subclass of UIViewController. Should correspond to the ViewControler at the top of the ViewController hierarchy
 * @param options A reference to an instance of NSDictionary with customized ad playback options
 * @param error An optional reference to a nil NSError reference. In case this method returns `NO` it will be non-nil
 * @return YES/NO in case of success/error while presenting an AdUnit
 * @warning Should be called from the main-thread.
 */
- (BOOL)playAd:(UIViewController *)viewController withOptions:(id)options error:(NSError **)error;

/**
 * returns `YES` when there is certainty that an add will be able to play. Returning `NO`, you can
 * still try to play and get a streaming Ad.
 */
- (BOOL)isAdPlayable;

/**
 * Returns debug info.
 */
- (NSDictionary *)debugInfo;

/**
 * by default, logging is off.
 */
- (void)setLoggingEnabled:(BOOL)enable;

/**
 * Log a new message. The message will be sent to all loggers.
 */
- (void)log:(NSString *)message, ...NS_FORMAT_FUNCTION(1, 2);

/**
 * Attach a new logger. It will get called on every log generated by Vungle (internally and externally).
 */
- (void)attachLogger:(id<VungleSDKLogger>)logger;

/**
 * Detaches a logger. Make sure to do this, otherwise you might leak memory.
 */
- (void)detachLogger:(id<VungleSDKLogger>)logger;

/**
 * This method is no-op and has been deprecated. Will be removed in a future version.
 */
- (void)clearCache __attribute__((deprecated));

/**
 * this also only works on the simulator
 */
- (void)clearSleep;

@end
