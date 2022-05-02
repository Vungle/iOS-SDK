//
//  VungleNativeAd.h
//  Vungle iOS SDK
//
//  Copyright (c) 2013-Present Vungle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VungleNativeAdDelegate;
@class VungleMediaView;

typedef NS_ENUM (NSInteger, NativeAdOptionsPosition) {
    NativeAdOptionsPositionTopLeft = 1,
    NativeAdOptionsPositionTopRight,
    NativeAdOptionsPositionBottomLeft,
    NativeAdOptionsPositionBottomRight,
};

@interface VungleNativeAd : NSObject

/**
 * The delegate to receive Native Ad callbacks (VungleNativeAdDelegate).
 */
@property (nonatomic, weak, nullable) id<VungleNativeAdDelegate> delegate;

/**
 * The application name that the ad advertises.
 */
@property (nonatomic, copy, readonly) NSString *title;

/**
 * The description of the application that the ad advertises.
 */
@property (nonatomic, copy, readonly) NSString *bodyText;

/**
 * The call to action phrase of the ad.
 */
@property (nonatomic, copy, readonly) NSString *callToAction;

/**
 * The rating for the application that the ad advertises.
 */
@property (nonatomic, assign, readonly) double adStarRating;

/**
 * The sponsored text, normally "sponsored by".
 */
@property (nonatomic, copy, readonly) NSString *sponsoredText;

/**
 * The app icon image of the ad.
 */
@property (nonatomic, strong, readonly, nullable) UIImage *iconImage;

/**
 * The position for the ad choices icon. Default is TOP_RIGHT.
 */
@property (nonatomic, assign) NativeAdOptionsPosition adOptionsPosition;

/**
 * Initialize a VungleNativeAd with the specified placement id.
 * @param placementID the ID of the placement used to present the native ad
 */
- (instancetype)initWithPlacementID:(nonnull NSString *)placementID;

/**
 * Prepare a native ad for the specified placement.
 */
- (void)loadAd;

/**
 * Pass UIViews and UIViewController to prepare and display a Native ad.
 * @param view a container view in which a native ad will be displayed. This view will be clickable.
 * @param mediaView a VungleMediaView to display the ad's image or video
 * @param iconImageView a UIImageView to display the app icon
 * @param viewController a UIViewController to present SKStoreProductViewController
 */
- (void)registerViewForInteraction:(nonnull UIView *)view
                         mediaView:(nonnull VungleMediaView *)mediaView
                     iconImageView:(nullable UIImageView *)iconImageView
                    viewController:(nullable UIViewController *)viewController;

/**
 * Pass UIViews and UIViewController to prepare and display a Native ad.
 * Also, specify clickable area.
 * @param view a container view in which a native ad will be displayed
 * @param mediaView a VungleMediaView to display the ad's image or video
 * @param iconImageView a UIImageView to display the app icon
 * @param viewController a UIViewController to present SKStoreProductViewController
 * @param clickableViews an array of UIViews that you would like to set clickable.
 * If nil or empty, the view will be clickable.
 */
- (void)registerViewForInteraction:(nonnull UIView *)view
                         mediaView:(nonnull VungleMediaView *)mediaView
                     iconImageView:(nullable UIImageView *)iconImageView
                    viewController:(nullable UIViewController *)viewController
                    clickableViews:(nullable NSArray<UIView *> *)clickableViews;

/**
 * Dismiss the currently displaying Native ad.
 */
- (void)unregisterView;

@end

@protocol VungleNativeAdDelegate <NSObject>
@optional

/**
 * If implemented, this method will be called when the SDK loads a native ad successfully.
 * @param nativeAd The VungleNativeAd object sending the message.
 */
- (void)nativeAdDidLoad:(VungleNativeAd *)nativeAd;

/**
 * If implemented, this method will be called when the SDK fails to load a native ad.
 * @param nativeAd The VungleNativeAd object sending the message.
 * @param error An NSError object containing details of the error.
 */
- (void)nativeAd:(VungleNativeAd *)nativeAd didFailWithError:(NSError *)error;

/**
 * If implemented, this method will be called when the SDK fails to present a native ad.
 * @param nativeAd The VungleNativeAd object sending the message.
 * @param error An NSError object containing details of the error.
 */
- (void)nativeAd:(VungleNativeAd *)nativeAd didFailToPlayWithError:(NSError *)error;

/**
 * If implemented, this method will be called when a native ad is displayed successfully.
 * @note Please use this callback to track an impression.
 * @param nativeAd The VungleNativeAd object sending the message.
 */
- (void)nativeAdDidTrackImpression:(VungleNativeAd *)nativeAd;

/**
 * If implemented, this method will be called when a user clicks the native ad.
 * @param nativeAd The VungleNativeAd object sending the message.
 */
- (void)nativeAdDidClick:(VungleNativeAd *)nativeAd;

@end

NS_ASSUME_NONNULL_END
