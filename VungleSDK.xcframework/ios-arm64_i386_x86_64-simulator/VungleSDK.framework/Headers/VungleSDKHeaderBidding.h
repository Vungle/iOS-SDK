//
//  VungleSDKHeaderBidding.h
//  Vungle iOS SDK
//
//  Copyright (c) 2013-Present Vungle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VungleSDK.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VungleSDKHeaderBidding;
@protocol VungleSDKHBDelegate;

@interface VungleSDK ()

/**
 * Setting this to a non-nil value will enabled header bidding and reporting
 */
@property (nonatomic, weak) NSObject<VungleSDKHeaderBidding> *headerBiddingDelegate;

/**
 * Setting this to a non-nil value will enable header bidding SDK callbacks
 */
@property (nonatomic, weak) NSObject<VungleSDKHBDelegate> *sdkHBDelegate;

/**
 * This is a synchronous method to fetch a bid token for any placement. This method
 * will return nil if it is unable to find a bid token, or a cached placement.
 *
 * @param placement The ID of a that has already been loaded placement
 */
- (NSString *)bidTokenForPlacement:(NSString *)placement __attribute__((deprecated("Use currentSuperToken to get all the participating bid Tokens.")));

/**
 * Prepares a placement when you know that you will want
 * to show an ad experience tied to a specific placementID.
 * @param placementID the specific ID of the placement you would like to present at some point soon
 * @param adMarkup includes the adunit data of the placement you would like to present at some point soon
 * @param error the NSError object that used to hold error generated
 * @return NO if something goes immediately wrong with loading, YES otherwise
 */
- (BOOL)loadPlacementWithID:(nonnull NSString *)placementID adMarkup:(nullable NSString *)adMarkup error:(NSError *__autoreleasing _Nullable *_Nullable)error;

/**
 * (Overloaded method)
 * Prepares a placement when you know that you will want
 * to show an ad experience tied to a specific placementID.
 * @param placementID the specific ID of the placement you would like to present at some point soon
 * @param adMarkup includes the adunit data of the placement you would like to present at some point soon
 * @param size the VungleAdSize (enum) you would like to request (only for banner ad type at the moment)
 * @param error the NSError object that used to hold error generated
 * @return NO if something goes immediately wrong with loading, YES otherwise
 */
- (BOOL)loadPlacementWithID:(nonnull NSString *)placementID adMarkup:(nullable NSString *)adMarkup withSize:(VungleAdSize)size error:(NSError *__autoreleasing _Nullable *_Nullable)error;

/**
 * Pass in an UIView which acts as a container for the ad experience. This view container may be placed in random positions.
 * @note This method should only be called using placements that have the `flexfeed` or `mrec` or `banner` template type. For
 *      the `mrec` template type, note that the UIView must have a width of 300 and a height of 250. If the view is provided without
 *      these dimensions, an error message will be returned and the ad will not be shown. For the  `banner` template type, note that
 *      the UIView must have the same width and height as the banner size (320x50, 300x50, or 728x90) which you requested. If the
 *      view is provided with a different banner size, an error message will be returned and the ad will not be shown.
 * @param publisherView container view in which an ad will be displayed
 * @param options A reference to an instance of NSDictionary with customized ad playback options
 * @param placementID The placement defined on the Vungle dashboard
 * @param adMarkup includes the adunit data of the placement
 * @param error An optional double reference to an NSError. In case this method returns `NO` it will be non-nil
 * @return YES/NO in case of success/error while presenting an AdUnit
 */
- (BOOL)addAdViewToView:(UIView *)publisherView withOptions:(nullable NSDictionary *)options placementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup error:(NSError *__autoreleasing _Nullable *_Nullable)error;

/**
 * Will play Ad Unit presenting it over the `controller` parameter
 * @note This method should only be called using placements with `fullscreen` or `flexview` template types
 * @param controller A subclass of UIViewController. Should correspond to the ViewControler at the top of the ViewController hierarchy
 * @param options A reference to an instance of NSDictionary with customized ad playback options
 * @param placementID The placement defined on the Vungle dashboard
 * @param adMarkup includes the adunit data of the placement
 * @param error An optional double reference to an NSError. In case this method returns `NO` it will be non-nil
 * @return YES/NO in case of success/error while presenting an AdUnit
 * @warning Should be called from the main-thread.
 */
- (BOOL)playAd:(UIViewController *)controller options:(nullable NSDictionary *)options placementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup error:(NSError *__autoreleasing _Nullable *_Nullable)error;

/**
 * Returns YES/NO when there is certainty that an ad will be able to play/can't play for a given placementID.
 * @param placementID the specific ID of the placement
 * @param adMarkup includes the adunit data of the placement
 */
- (BOOL)isAdCachedForPlacementID:(nonnull NSString *)placementID adMarkup:(nullable NSString *)adMarkup;

/**
* (Overloaded method)
 * Returns YES/NO when there is certainty that an ad will be able to play/can't play for a given placementID.
 * @param placementID the specific ID of the placement
 * @param size the VungleAdSize (enum) you would like to request (only for banner ad type at the moment)
 * @param adMarkup includes the adunit data of the placement
 */
- (BOOL)isAdCachedForPlacementID:(nonnull NSString *)placementID adMarkup:(nullable NSString *)adMarkup withSize:(VungleAdSize)size;

/**
 * This method will dismiss the currently playing Flex View, Flex Feed, Banner or MREC advertisement with the placementId specified.
 * If you have added an advertisement with `addAdViewToView:` or you are playing a placement that has been configured as a
 * Flex View, Flex Feed, Banner or MREC placement, then this method will remove the advertisement from the screen and perform any
 * necessary clean up steps.
 * This method will call the existing delegate callbacks as part of the lifecycle.
 * @param placementId the specific ID of the placement
 * @param adMarkup includes the adunit data of the placement
 */
- (void)finishDisplayingAd:(nonnull NSString *)placementId adMarkup:(nullable NSString *)adMarkup;

/**
 * This is a synchronous method to fetch super token. This method
 * will return nil if it is unable to find an available token.
 *
 */
- (NSString *)currentSuperToken __attribute__((deprecated("Use currentSuperTokenForPlacementID:placementID:size: instead.")));

/**
 * This is a synchronous method to fetch super token. This method
 * will return nil if it is unable to find an available token.
 * @param size Size limit of the supertoken needs to be returned
 */
- (NSString *)currentSuperTokenForSize:(NSInteger)size __attribute__((deprecated("Use currentSuperTokenForPlacementID:placementID:size: instead.")));

/**
 * This is a synchronous method to request super token includes bidTokens
 * for specified Placement with size limitation.
 * @param placementID the specific ID of the placement. Setting `nil` includes all bidTokens for available Placements.
 * @param size size limit applied for the supertoken returned. 0 or negative value sets no size limit.
 */
- (NSString *)currentSuperTokenForPlacementID:(nullable NSString *)placementID forSize:(NSInteger)size;

@end

@protocol VungleSDKHeaderBidding

@optional
/**
 * If implemented, this will be called as soon as the SDK receives a bidToken for a particular
 * placement. Note that the placement is NOT available to playback until preparation.
 *
 * @param placement The ID of a placement which is ready to be played
 * @param bidToken An encrypted bid token used to identify the placement through the auction
 */
- (void)placementWillBeginCaching:(NSString *)placement
                     withBidToken:(NSString *)bidToken __attribute__((deprecated("This delegate method will no longer be used in feature releases.")));

/**
 * If implemented, this will be called when the SDK has a placement fully prepared and cached
 * to disk with a corresponding bid token.
 *
 * @param placement The ID of a placement which is ready to be played
 * @param bidToken An encrypted bid token used to identify the placement through the auction
 */
- (void)placementPrepared:(NSString *)placement
             withBidToken:(NSString *)bidToken __attribute__((deprecated("This delegate method will no longer be used in feature releases.")));

@end

@protocol VungleSDKHBDelegate <VungleSDKDelegate>

@optional
/**
 * If implemented, this will get called when the SDK has an ad ready to be displayed. Also it will
 * get called with an argument `NO` for `isAdPlayable` when for some reason, there is
 * no ad available, for instance there is a corrupt ad or the OS wiped the cache.
 * @param isAdPlayable A boolean indicating if an ad is currently in a playable state
 * @param placementID The ID of a placement which is ready to be played
 * @param adMarkup The ad markup of an adUnit which is ready to be played.
 * @param error The error that was encountered.  This is only sent when the placementID is nil.
 */
- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup error:(nullable NSError *)error;

/**
 * If implemented, this will get called when the SDK is about to show an ad. This point
 * might be a good time to pause your game, and turn off any sound you might be playing.
 * @param placementID The placement which is about to be shown.
 * @param adMarkup The ad markup of an adUnit which is about to be shown.
 */
- (void)vungleWillShowAdForPlacementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup;

/**
 * If implemented, this will get called when the SDK has presented the view controller or the
 * view that houses the ad.
 * @param placementID The placement which is about to be shown.
 * @param adMarkup The ad markup of an adUnit which is about to be shown..
 */
- (void)vungleDidShowAdForPlacementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup;

/**
 * If implemented, this will be called when the ad is first rendered for the specified placement.
 * @NOTE: Please use this callback to track views.
 * @param placementID The placement ID of the advertisement shown
 * @param adMarkup The ad markup of the advertisement shown.
 */
- (void)vungleAdViewedForPlacementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup;

/**
 * If implemented, this method gets called when a Vungle Ad Unit is about to be completely dismissed.
 * At this point, it's recommended to resume your Game or App.
 * @param placementID The placement ID of the advertisement about to be closed.
 * @param adMarkup The ad markup of the advertisement about to be closed.
 */
- (void)vungleWillCloseAdForPlacementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup;

/**
 * If implemented, this method gets called when a Vungle Ad Unit has been completely dismissed.
 * At this point, you can load another ad for non-auto-cached placement if necessary.
 * @param placementID The placement ID of the advertisement that has been closed.
 * @param adMarkup The ad markup of the advertisement that has been closed.
 */
- (void)vungleDidCloseAdForPlacementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup;

/**
 * If implemented, this method gets called when user clicks the Vungle Ad.
 * At this point, it's recommended to track the click event.
 * @param placementID The placement ID of the advertisement shown.
 * @param adMarkup The ad markup of the advertisement shown
 */
- (void)vungleTrackClickForPlacementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup;

/**
 * If implemented, this method gets called when user taps the Vungle Ad
 * which will cause them to leave the current application(e.g. the ad action
 * opens the iTunes store, Mobile Safari, etc).
 * @param placementID The placement ID of the advertisement about to leave the current application.
 * @param adMarkup The ad markup of the advertisement about to leave the current application.
 */
- (void)vungleWillLeaveApplicationForPlacementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup;

/**
 * This method is called when the user should be rewarded for watching a Rewarded Video Ad.
 * At this point, it's recommended to reward the user.
 * @param placementID The placement ID of the advertisement shown.
 * @param adMarkup The ad markup of the advertisement shown.
 */
- (void)vungleRewardUserForPlacementID:(nullable NSString *)placementID adMarkup:(nullable NSString *)adMarkup;

/**
 * This method is called when the publisher changes the placement state from HB to NON-HB or the other way.
 * At this point, it's recommended to remove all the delegate object references related to placement.
 * @param placementID The unique ID referred to the placement of the advertisement shown
 */
- (void)invalidateObjectsForPlacementID:(nullable NSString *)placementID;

@end

NS_ASSUME_NONNULL_END
