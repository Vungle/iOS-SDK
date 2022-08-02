#ifndef Constants_h
#define Constants_h

static NSString *const kVungleAppIDPrefix = @"App ID:";
static NSString *const kVungleTestAppID = @"5e13cc9d61880b27a65bf735";
static NSString *const kVunglePlacementID1Prefix = @"PlacementID: ";
static NSString *const kVungleTestPlacementID01 = @"DEFAULT-2227894"; // Auto Cached
static NSString *const kVunglePlacementID2Prefix = @"Interstitial: ";
static NSString *const kVungleTestPlacementID02 = @"INTERSTITIAL01-8573922";
static NSString *const kVunglePlacementID3Prefix = @"Rewarded: ";
static NSString *const kVungleTestPlacementID03 = @"REWARDED01-4772665";
static NSString *const kVunglePlacementID4Prefix = @"Rewarded Playable: ";
static NSString *const kVungleTestPlacementID04 = @"REWARDED_PLAYABLE03-6535366";
static NSString *const kVunglePlacementID5Prefix = @"MREC: ";
static NSString *const kVungleTestPlacementID05 = @"MRECC02-9825235";
static NSString *const kVunglePlacementID6Prefix = @"Banner Short: ";
static NSString *const kVungleTestPlacementID06 = @"BANNER04-8166553";
static NSString *const kVunglePlacementID7Prefix = @"Banner: ";
static NSString *const kVungleTestPlacementID07 = @"BANNER3-7051875";
static NSString *const kVunglePlacementID8Prefix = @"Banner: ";
static NSString *const kVungleTestPlacementID08 = @"BANNER05-4730786";
static NSString *const kVunglePlacementID9Prefix = @"MREC: ";
static NSString *const kVungleTestPlacementID09 = @"MREC04-8692745";

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH self.view.frame.size.width
#define MREC_AD_HEIGHT 250.0
#define MREC_AD_WIDTH 300
#define BANNER_AD_HEIGHT 50.0
#define BANNER_SHORT_AD_WIDTH 300.0
#define BANNER_AD_WIDTH 320.0

#endif /* Constants_h */
