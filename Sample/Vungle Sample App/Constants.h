//
//  Constants.h
//  Vungle Sample App
//
//  Created by Vungle on 8/21/19.
//  Copyright © 2019 Vungle. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

static NSString *const kVungleAppIDPrefix = @"App ID:";
static NSString *const kVungleTestAppID = @"5ee7cef38693721c500d15ca";
static NSString *const kVunglePlacementID1Prefix = @"PlacementID: ";
static NSString *const kVungleTestPlacementID01 = @"DEFAULT-3652844"; // Auto Cached
static NSString *const kVunglePlacementID2Prefix = @"Interstitial: ";
static NSString *const kVungleTestPlacementID02 = @"INTERSTITIAL01-2446128";
static NSString *const kVunglePlacementID3Prefix = @"Rewarded: ";
static NSString *const kVungleTestPlacementID03 = @"REWARDED02-6669942";
static NSString *const kVunglePlacementID4Prefix = @"Rewarded Playable: ";
static NSString *const kVungleTestPlacementID04 = @"REWARDED_PLAYABLE-8222961";
static NSString *const kVunglePlacementID5Prefix = @"MREC: ";
static NSString *const kVungleTestPlacementID05 = @"MREC01-8863655";
static NSString *const kVunglePlacementID6Prefix = @"Banner Short: ";
static NSString *const kVungleTestPlacementID06 = @"BANNER01-1678809";
static NSString *const kVunglePlacementID7Prefix = @"Banner: ";
static NSString *const kVungleTestPlacementID07 = @"BANNER02-6146432";
static NSString *const kVunglePlacementID8Prefix = @"Banner: ";
static NSString *const kVungleTestPlacementID08 = @"BANNER05-9988742";
static NSString *const kVunglePlacementID9Prefix = @"MREC: ";
static NSString *const kVungleTestPlacementID09 = @"MREC02-3040297";

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH self.view.frame.size.width
#define MREC_AD_HEIGHT 250.0
#define MREC_AD_WIDTH 300
#define BANNER_AD_HEIGHT 50.0
#define BANNER_SHORT_AD_WIDTH 300.0
#define BANNER_AD_WIDTH 320.0

#endif /* Constants_h */
