//
//  Constants.h
//  Vungle Sample App
//
//  Created by Vungle on 8/21/19.
//  Copyright © 2019 Vungle. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
//static NSString *const kVungleAppIDPrefix = @"App ID:";
//static NSString *const kVungleTestAppID =@"58fe200484fbd5b9670000e3";
//static NSString *const kVunglePlacementID1Prefix = @"PlacementID: ";
//static NSString *const kVungleTestPlacementID01 =@"PLMT01-41570"; // Auto Cached
//static NSString *const kVunglePlacementID2Prefix = @"Interstitial: ";
//static NSString *const kVungleTestPlacementID02 =@"PLMT09-6251444";
//static NSString *const kVunglePlacementID3Prefix = @"Rewarded: ";
//static NSString *const kVungleTestPlacementID03 =@"PLMT02-05269";
//static NSString *const kVunglePlacementID4Prefix = @"Rewarded Playable: ";
//static NSString *const kVungleTestPlacementID04 =@"PLMT06-3683626";
//static NSString *const kVunglePlacementID5Prefix = @"MREC: ";
//static NSString *const kVungleTestPlacementID05 =@"PLMT05-1456830";
//static NSString *const kVunglePlacementID6Prefix = @"Banner Short: ";
//static NSString *const kVungleTestPlacementID06 =@"PLMT07-3480357";
//static NSString *const kVunglePlacementID7Prefix = @"Banner: ";
//static NSString *const kVungleTestPlacementID07 =@"PLMT08-0664769";
//static NSString *const kVungleTestPlacementID08 =@"PLMT08-0664769";
//static NSString *const kVungleTestPlacementID09 =@"PLMT08-0664769";



static NSString *const kVungleAppIDPrefix = @"App ID:";
static NSString *const kVungleTestAppID =@"5e13cc9d61880b27a65bf735";
//static NSString *const kVungleTestAppID = @"5e432e0dbdfca40017f2f9b4";
static NSString *const kVunglePlacementID1Prefix = @"PlacementID: ";
//static NSString *const kVungleTestPlacementID01 =@"PLMT01-41570"; // Auto Cached
static NSString *const kVungleTestPlacementID01 = @"INTERSTITIAL01-8573922";
static NSString *const kVunglePlacementID2Prefix = @"Interstitial: ";
static NSString *const kVungleTestPlacementID02=@"INTERSTITIAL02-1468016";
static NSString *const kVunglePlacementID3Prefix = @"Rewarded: ";
//static NSString *const kVungleTestPlacementID03 =@"PLMT02-05269";
static NSString *const kVungleTestPlacementID03 = @"REWARDED-2316551";
static NSString *const kVunglePlacementID4Prefix = @"Rewarded Playable: ";
static NSString *const kVungleTestPlacementID04 =@"REWARDED_PLAYABLE01-4686142";
static NSString *const kVunglePlacementID5Prefix = @"MREC: ";
static NSString *const kVungleTestPlacementID05 = @"MREC03-4489762";
static NSString *const kVunglePlacementID6Prefix = @"Banner Short: ";
static NSString *const kVungleTestPlacementID06 =@"BANNERSHORT-4710917";
static NSString *const kVunglePlacementID7Prefix = @"Banner: ";
static NSString *const kVungleTestPlacementID07=@"BANNER05-4730786";
static NSString *const kVungleTestPlacementID08= @"BANNER2-4333473";
static NSString *const kVungleTestPlacementID09=@"MREC03-4489762";
////static NSString *const kVungleTestPlacementID07 = @"BANNER01-3273200";

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH self.view.frame.size.width
#define MREC_AD_HEIGHT 250.0
#define MREC_AD_WIDTH 300
#define BANNER_AD_HEIGHT 50.0
#define BANNER_SHORT_AD_WIDTH 300.0
#define BANNER_AD_WIDTH 320.0

#endif /* Constants_h */
