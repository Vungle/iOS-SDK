//
//  VungleMediaView.h
//  Vungle iOS SDK
//
//  Copyright © 2021 Vungle Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The VungleMediaView loads media content from a given VNGNativeAd.
 * This view takes the place of manually loading a cover image.
 */
@interface VungleMediaView : UIView

/**
 * Method that load an image from a local path.
 * @param path A local path of the image.
 */
- (BOOL)loadImageFromLocalPath:(NSString *)path;

/**
 * Method that load an image from a remote URL.
 * @param urlPath A remote path of the image.
 */
- (BOOL)loadImageFromRemoteURL:(NSString *)urlPath;

/**
 * Method that cleans up the currently displayed image.
 */
- (void)cleanupImage;

@end

NS_ASSUME_NONNULL_END
