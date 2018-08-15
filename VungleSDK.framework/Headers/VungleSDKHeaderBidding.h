//
//  VungleSDKHeaderBidding.h
//  Vungle iOS SDK
//
//  Copyright (c) 2013-Present Vungle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VungleSDK.h"

@protocol VungleSDKHeaderBidding
/**
 * If implemented, this will get called when the SDK has a placement prepared with a
 * corresponding bid token.
 * @param placement The ID of a placement which is ready to be played
 * @param bidToken An encrypted bid token used to identify the placement through the auction
 */
- (void)placementPrepared:(NSString *)placement withBidToken:(NSString *)bidToken;
@end

@interface VungleSDK ()
/**
 * Setting this to a non-nil value will enabled header bidding and reporting
 */
@property (nonatomic, weak) id<VungleSDKHeaderBidding> headerBiddingDelegate;
@end
