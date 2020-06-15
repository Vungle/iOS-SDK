//
//  FirstViewController.m
//  Vungle Sample App
//
//  Created by Vungle on 3/24/14.
//  Copyright (c) 2017 Vungle. All rights reserved.
//

#import "FirstViewController.h"
#import "Constants.h"



@interface FirstViewController () {
 CGFloat screenHeight;
 CGFloat screenWidth;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *appIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel1;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel2;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel3;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel4;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel5;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel6;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel7;
@property (weak, nonatomic) IBOutlet UIButton *sdkInitButton;
@property (weak, nonatomic) IBOutlet UIButton *loadButton2;
@property (weak, nonatomic) IBOutlet UIButton *loadButton3;
@property (weak, nonatomic) IBOutlet UIButton *loadButton4;
@property (weak, nonatomic) IBOutlet UIButton *loadButton5;
@property (weak, nonatomic) IBOutlet UIButton *loadButton6;
@property (weak, nonatomic) IBOutlet UIButton *loadButton7;
@property (weak, nonatomic) IBOutlet UIButton *playButton1;
@property (weak, nonatomic) IBOutlet UIButton *playButton2;
@property (weak, nonatomic) IBOutlet UIButton *playButton3;
@property (weak, nonatomic) IBOutlet UIButton *playButton4;
@property (weak, nonatomic) IBOutlet UIButton *playButton5;
@property (weak, nonatomic) IBOutlet UIButton *playButton6;
@property (weak, nonatomic) IBOutlet UIButton *playButton7;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton5;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton6;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton7;
@property (weak, nonatomic) IBOutlet UIButton *checkCurrentStatusButton;
@property (weak, nonatomic) IBOutlet UIButton *multiBannerViewButton;
@property (nonatomic, strong) VungleSDK *sdk;
@property (retain, nonatomic) UIView *adView;
@property (nonatomic, assign, getter=isPlayingMREC) BOOL playingMREC;
@property (nonatomic, assign, getter=isPlayingBanner) BOOL playingBanner;

@end

@implementation FirstViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    // Do any additional setup after loading the view.
    [self setViewDefault];
}
- (IBAction)onShowBannerTapped:(id)sender {
    
}

- (IBAction)onInitButtonTapped:(id)sender {
    [self startVungle];
}

- (IBAction)onLoadButtonTapped:(id)sender {
    if (sender == self.loadButton2) {
        NSLog(@"-->> load an ad for placement 02");
        NSError *error = nil;
        if ([self.sdk loadPlacementWithID:kVungleTestPlacementID02 error:&error]) {
            [self updateButtonState:self.loadButton2 enabled:NO];
        } else {
            [self updateButtonState:self.loadButton2 enabled:YES];
            if (error) {
                NSLog(@"Unable to load placement with reference ID :%@, Error %@", kVungleTestPlacementID02, error);
            }
        }
    } else if(sender == self.loadButton3) {
        NSLog(@"-->> load an ad for placement 03");
        NSError *error = nil;
        if ([self.sdk loadPlacementWithID:kVungleTestPlacementID03 error:&error]) {
            [self updateButtonState:self.loadButton3 enabled:NO];
        } else {
            [self updateButtonState:self.loadButton3 enabled:YES];
            if (error) {
                NSLog(@"Unable to load placement with reference ID :%@, Error %@", kVungleTestPlacementID03, error);
            }
        }
    } else if(sender == self.loadButton4) {
        NSLog(@"-->> load an ad for placement 04");
        NSError *error = nil;
        if ([self.sdk loadPlacementWithID:kVungleTestPlacementID04 error:&error]) {
            [self updateButtonState:self.loadButton4 enabled:NO];
        } else {
            [self updateButtonState:self.loadButton4 enabled:YES];
            if (error) {
                NSLog(@"Unable to load placement with reference ID :%@, Error %@", kVungleTestPlacementID04, error);
            }
        }
    } else if(sender == self.loadButton5) {
        NSLog(@"-->> load an ad for placement 05");
        NSError *error = nil;
        if ([self.sdk loadPlacementWithID:kVungleTestPlacementID05 error:&error]) {
            [self updateButtonState:self.loadButton5 enabled:NO];
        } else {
            [self updateButtonState:self.loadButton5 enabled:YES];
            if (error) {
                NSLog(@"Unable to load placement with reference ID :%@, Error %@", kVungleTestPlacementID05, error);
            }
        }
    } else if(sender == self.loadButton6) {
        NSLog(@"-->> load an ad for placement 06");
        NSError *error = nil;
        if ([self.sdk loadPlacementWithID:kVungleTestPlacementID06 withSize:VungleAdSizeBannerShort error:&error]){
            [self updateButtonState:self.loadButton6 enabled:NO];
        }
         else {
            [self updateButtonState:self.loadButton6 enabled:YES];
            if (error) {
                NSLog(@"Unable to load placement with reference ID :%@, Error %@", kVungleTestPlacementID06, error);
            }
        }
    } else if(sender == self.loadButton7) {
        NSLog(@"-->> load an ad for placement 07");
        NSError *error = nil;
        if ([self.sdk loadPlacementWithID:kVungleTestPlacementID07 withSize:VungleAdSizeBanner error:&error]){
            [self updateButtonState:self.loadButton7 enabled:NO];
        }
         else {
            [self updateButtonState:self.loadButton7 enabled:YES];
            if (error) {
                NSLog(@"Unable to load placement with reference ID :%@, Error %@", kVungleTestPlacementID07, error);
            }
        }
    }
}

- (IBAction)onPlayButtonTapped:(id)sender {
    if (sender == self.playButton1) {
        NSLog(@"-->> Play an ad for %@", kVungleTestPlacementID01);
        [self updateButtonState:self.playButton1 enabled:NO];
        [self showAdForPlacement01];
    } else if (sender == self.playButton2) {
        NSLog(@"-->> Play an ad for %@", kVungleTestPlacementID02);
        [self updateButtonState:self.playButton2 enabled:NO];
        [self showAdForPlacement02];
    } else if (sender == self.playButton3) {
        NSLog(@"-->> Play an ad for %@", kVungleTestPlacementID03);
        [self updateButtonState:self.playButton3 enabled:NO];
        [self showAdForPlacement03];
    } else if (sender == self.playButton4) {
        NSLog(@"-->> Play an ad for %@", kVungleTestPlacementID04);
        [self updateButtonState:self.playButton4 enabled:NO];
        [self showAdForPlacement04];
    } else if (sender == self.playButton5) {
        NSLog(@"-->> Play an ad for %@", kVungleTestPlacementID05);
        [self updateButtonState:self.playButton5 enabled:NO];
        [self updateButtonState:self.dismissButton5 enabled:YES];
        [self setPlayingMREC:YES];
        [self showAdForPlacement05];
    } else if (sender == self.playButton6) {
        NSLog(@"-->> Play an ad for %@", kVungleTestPlacementID06);
        [self updateButtonState:self.playButton6 enabled:NO];
        [self updateButtonState:self.dismissButton6 enabled:YES];
        [self setPlayingBanner:YES];
        [self showAdForPlacement06];
    }
    else if (sender == self.playButton7) {
        NSLog(@"-->> Play an ad for %@", kVungleTestPlacementID07);
        [self updateButtonState:self.playButton7 enabled:NO];
        [self updateButtonState:self.dismissButton7 enabled:YES];
        [self setPlayingBanner:YES];
        [self showAdForPlacement07];
    }
    [self disablePlayLoadButtons];
}

- (IBAction)onDismissButtonTapped:(id)sender {
    if (sender == self.dismissButton5) {
        [self.sdk finishDisplayingAd:kVungleTestPlacementID05];
        [self setPlayingMREC:NO];
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0)
                                 animated:YES];
        if(self.adView != nil){
            [self.adView removeFromSuperview];
        }
        [self updateButtonState:self.dismissButton5 enabled:NO];
    } else if (sender == self.dismissButton6) {
        [self.sdk finishDisplayingAd:kVungleTestPlacementID06];
        [self setPlayingBanner:NO];
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0)
                                 animated:YES];
        if(self.adView != nil){
            [self.adView removeFromSuperview];
        }
        [self updateButtonState:self.dismissButton6 enabled:NO];
    }else if (sender == self.dismissButton7) {
        [self.sdk finishDisplayingAd:kVungleTestPlacementID07];
        [self setPlayingBanner:NO];
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, 0)
                                 animated:YES];
        if(self.adView != nil){
            [self.adView removeFromSuperview];
        }
        [self updateButtonState:self.dismissButton7 enabled:NO];
    }
}

- (IBAction)onCheckCurrentStatusButtonTapped:(id)sender {
    NSLog(@"-->> SDK Initialized: %@", (self.sdk.initialized? @"YES":@"NO"));
    NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID01, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID01]? @"YES":@"NO"));
    NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID02, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID02]? @"YES":@"NO"));
    NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID03, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID03]? @"YES":@"NO"));
    NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID04, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID04]? @"YES":@"NO"));
    NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID05, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID05]? @"YES":@"NO"));
        NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID06, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID06]? @"YES":@"NO"));
        NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID07, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID07]? @"YES":@"NO"));
}

#pragma mark - VungleSDKDelegate Methods

- (void)vungleRewardUserForPlacementID:(nullable NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleRewardUserForPlacementID: Rewarded for Placement ID: %@", placementID);
}

- (void)vungleTrackClickForPlacementID:(nullable NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleTrackClickForPlacementID %@",placementID);
}

- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(NSString *)placementID error:(NSError *)error {
    if (isAdPlayable) {
        NSLog(@"-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is available for Placement ID: %@", placementID);
    } else {
        NSLog(@"-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is NOT available for Placement ID: %@", placementID);
    }
    
    if ([placementID isEqualToString:kVungleTestPlacementID01]) {
        [self updateButtonState:self.playButton1 enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID02]) {
        [self updateButtonState:self.loadButton2 enabled:!isAdPlayable];
        [self updateButtonState:self.playButton2 enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID03]) {
        [self updateButtonState:self.loadButton3 enabled:!isAdPlayable];
        [self updateButtonState:self.playButton3 enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID04]) {
        [self updateButtonState:self.loadButton4 enabled:!isAdPlayable];
        [self updateButtonState:self.playButton4 enabled:isAdPlayable];
    }
    else if ([placementID isEqualToString:kVungleTestPlacementID05]) {
        if(![self isPlayingMREC]) {
            [self updateButtonState:self.loadButton5 enabled:!isAdPlayable];
        }
        [self updateButtonState:self.playButton5 enabled:isAdPlayable];
    }
    else if ([placementID isEqualToString:kVungleTestPlacementID06]) {
           if(![self isPlayingBanner]) {
               [self updateButtonState:self.loadButton6 enabled:!isAdPlayable];
           }
           [self updateButtonState:self.playButton6 enabled:isAdPlayable];
       }
    else if ([placementID isEqualToString:kVungleTestPlacementID07]) {
           if(![self isPlayingBanner]) {
               [self updateButtonState:self.loadButton7 enabled:!isAdPlayable];
           }
           [self updateButtonState:self.playButton7 enabled:isAdPlayable];
       }
}

- (void)vungleWillLeaveApplicationForPlacementID:(nullable NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleWillLeaveApplicationForPlacementId is pressed on %@",placementID);
}

- (void)vungleDidShowAdForPlacementID:(nullable NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleDidShowAdForPlacementID for %@",placementID);
}

- (void)vungleWillShowAdForPlacementID:(nullable NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleWillShowAdForPlacementID");
    if ([placementID isEqualToString:kVungleTestPlacementID01]) {
        NSLog(@"-->> Ad will show for %@", kVungleTestPlacementID01);
        [self updateButtonState:self.playButton1 enabled:NO];
    } else if ([placementID isEqualToString:kVungleTestPlacementID02]) {
        NSLog(@"-->> Ad will show for %@", kVungleTestPlacementID02);
        [self updateButtonState:self.playButton2 enabled:NO];
    } else if ([placementID isEqualToString:kVungleTestPlacementID03]) {
        NSLog(@"-->> Ad will show for %@", kVungleTestPlacementID03);
        [self updateButtonState:self.playButton3 enabled:NO];
    } else if ([placementID isEqualToString:kVungleTestPlacementID04]) {
        NSLog(@"-->> Ad will show for %@", kVungleTestPlacementID04);
        [self updateButtonState:self.playButton4 enabled:NO];
    } else if ([placementID isEqualToString:kVungleTestPlacementID05]) {
        NSLog(@"-->> Ad will show for %@", kVungleTestPlacementID05);
        [self updateButtonState:self.playButton5 enabled:NO];
        [self updateButtonState:self.dismissButton5 enabled:YES];
    }else if ([placementID isEqualToString:kVungleTestPlacementID06]) {
        NSLog(@"-->> Ad will show for %@", kVungleTestPlacementID06);
        [self updateButtonState:self.playButton6 enabled:NO];
        [self updateButtonState:self.dismissButton6 enabled:YES];
    }else if ([placementID isEqualToString:kVungleTestPlacementID07]) {
        NSLog(@"-->> Ad will show for %@", kVungleTestPlacementID07);
        [self updateButtonState:self.playButton7 enabled:NO];
        [self updateButtonState:self.dismissButton7 enabled:YES];
    }
}

- (void)vungleWillCloseAdForPlacementID:(nonnull NSString *)placementID {
    NSLog(@"-->> Delegate callback: vungleWillCloseAdForPlacement for %@",placementID);
}

-(void)vungleDidCloseAdForPlacementID:(NSString *)placementID {
    NSLog(@"-->> Delegate callback: vungleDidCloseAdForPlacementID for %@", placementID);
    [self updateButtons];
}

- (void)vungleSDKDidInitialize {
    NSLog(@"-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY");
    [self updateButtons];
}

#pragma mark - FirstView Methods

- (void)setViewDefault {
    self.appIdLabel.text = [kVungleAppIDPrefix stringByAppendingString:kVungleTestAppID];
    self.placementIdLabel1.text = [kVunglePlacementID1Prefix stringByAppendingString:kVungleTestPlacementID01];
    self.placementIdLabel2.text = [kVunglePlacementID2Prefix stringByAppendingString:kVungleTestPlacementID02];
    self.placementIdLabel3.text = [kVunglePlacementID3Prefix stringByAppendingString:kVungleTestPlacementID03];
    self.placementIdLabel4.text = [kVunglePlacementID4Prefix stringByAppendingString:kVungleTestPlacementID04];
    self.placementIdLabel5.text = [kVunglePlacementID5Prefix stringByAppendingString:kVungleTestPlacementID05];
        self.placementIdLabel6.text = [kVunglePlacementID6Prefix stringByAppendingString:kVungleTestPlacementID06];
        self.placementIdLabel7.text = [kVunglePlacementID7Prefix stringByAppendingString:kVungleTestPlacementID07];
    [self updateButtonState:self.loadButton2 enabled:NO];
    [self updateButtonState:self.loadButton3 enabled:NO];
    [self updateButtonState:self.loadButton4 enabled:NO];
    [self updateButtonState:self.loadButton5 enabled:NO];
    [self updateButtonState:self.loadButton6 enabled:NO];
    [self updateButtonState:self.loadButton7 enabled:NO];
    [self updateButtonState:self.playButton1 enabled:NO];
    [self updateButtonState:self.playButton2 enabled:NO];
    [self updateButtonState:self.playButton3 enabled:NO];
    [self updateButtonState:self.playButton4 enabled:NO];
    [self updateButtonState:self.playButton5 enabled:NO];
    [self updateButtonState:self.playButton6 enabled:NO];
    [self updateButtonState:self.playButton7 enabled:NO];
    [self updateButtonState:self.dismissButton5 enabled:NO];
    [self updateButtonState:self.dismissButton6 enabled:NO];
    [self updateButtonState:self.dismissButton7 enabled:NO];
}

- (void)startVungle {
    [self updateButtonState:self.sdkInitButton enabled:NO];
    self.sdk = [VungleSDK sharedSDK];
    [self.sdk updateConsentStatus:VungleConsentAccepted consentMessageVersion:@"Accepted"];
    /**GDPR status option to opt_out
     [self.sdk updateConsentStatus:VungleConsentDenied consentMessageVersion:@"Denied"];
     */
    [self.sdk updateCCPAStatus:VungleCCPAAccepted];
    /**CCPA Status Opt_Out API Call
     [self.sdk updateCCPAStatus:VungleCCPADenied];
     */
    [self.sdk setDelegate:self];  
    [self.sdk setLoggingEnabled:YES];
    NSError *error = nil;
    if(![self.sdk startWithAppId:kVungleTestAppID options:nil error:&error]) {
        NSLog(@"Error while starting VungleSDK %@",[error localizedDescription]);
        [self updateButtonState:self.sdkInitButton enabled:YES];
        return;
    }
}

#pragma mark - Button Actions

- (IBAction)showAdForPlacement01 {
    NSError *error;
    [self.sdk playAd:self options:nil placementID:kVungleTestPlacementID01 error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
    }
}

- (IBAction)showAdForPlacement02 {
    NSDictionary *options = @{VunglePlayAdOptionKeyOrientations: @(UIInterfaceOrientationMaskAll),VunglePlayAdOptionKeyOrdinal: @20031023};
    NSError *error;
    [self.sdk playAd:self options:options placementID:kVungleTestPlacementID02 error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
        [self updateButtonState:self.loadButton2 enabled:YES];
    }
}

- (IBAction)showAdForPlacement03 {
    NSDictionary *options = @{VunglePlayAdOptionKeyUser:@"test_user_id",
                              VunglePlayAdOptionKeyIncentivizedAlertBodyText : @"If the video isn't completed you won't get your reward! Are you sure you want to close early?",
							  VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText : @"Close",
							  VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText : @"Keep Watching",
							  VunglePlayAdOptionKeyIncentivizedAlertTitleText : @"Careful!"};
	NSError *error;
	[self.sdk playAd:self options:options placementID:kVungleTestPlacementID03 error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
        [self updateButtonState:self.loadButton3 enabled:YES];
    }
}

- (IBAction)showAdForPlacement04 {
    NSError *error;
    [self.sdk playAd:self options:nil placementID:kVungleTestPlacementID04 error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
        [self updateButtonState:self.loadButton4 enabled:YES];
    }
}

- (IBAction)showAdForPlacement05 {
    NSLog(@"showAdForPlacement05");
    CGPoint bottomOffset = CGPointMake(0.0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height-30.0);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    NSError *error;
    [self getScreenDimension];
    self.adView = [[UIView alloc]initWithFrame:CGRectMake((screenWidth / 2) - (MREC_AD_WIDTH / 2), screenHeight - MREC_AD_HEIGHT, MREC_AD_WIDTH, MREC_AD_HEIGHT)];
    [self.view addSubview:self.adView];
    [self.sdk addAdViewToView:self.adView withOptions:nil placementID:kVungleTestPlacementID05 error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
        [self updateButtonState:self.loadButton5 enabled:YES];
    } else {
        [self updateButtonState:self.dismissButton5 enabled:YES];
    }
}

- (IBAction)showAdForPlacement06 {
    NSLog(@"showAdForPlacement06");
    // Scroll the view to see the ad completely
    CGPoint bottomOffset = CGPointMake(0.0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height-30.0);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    NSError *error;
    [self getScreenDimension];
    CGFloat viewYAxis = screenHeight - BANNER_AD_HEIGHT;
    NSLog(@"viewYAxis is %f",viewYAxis);
       self.adView = [[UIView alloc]initWithFrame:CGRectMake((screenWidth / 2) - (BANNER_SHORT_AD_WIDTH / 2), screenHeight - BANNER_AD_HEIGHT-20, BANNER_SHORT_AD_WIDTH, BANNER_AD_HEIGHT)];
    [self.view addSubview:self.adView];
   [self.sdk addAdViewToView:self.adView withOptions:nil placementID:kVungleTestPlacementID06 error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
        [self updateButtonState:self.loadButton6 enabled:YES];
    } else {
        [self updateButtonState:self.dismissButton6 enabled:YES];
    }
}

- (IBAction)showAdForPlacement07 {
    NSLog(@"showAdForPlacement07");
    // Scroll the view to see the ad completely
    CGPoint bottomOffset = CGPointMake(0.0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height+50.0);
    [self.scrollView setContentOffset:bottomOffset animated:YES];
    NSError *error;
    [self getScreenDimension];
   self.adView = [[UIView alloc]initWithFrame:CGRectMake((screenWidth / 2) - (BANNER_AD_WIDTH / 2), screenHeight - BANNER_AD_HEIGHT-20, BANNER_AD_WIDTH, BANNER_AD_HEIGHT)];
    [self.view addSubview:self.adView];
   [self.sdk addAdViewToView:self.adView withOptions:nil placementID:kVungleTestPlacementID07 error:&error];
    
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
        [self updateButtonState:self.loadButton7 enabled:YES];
    } else {
        [self updateButtonState:self.dismissButton7 enabled:YES];
    }
}

- (void)updateButtons {
    [self updateButtonState:self.playButton1 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID01]? YES:NO];
    [self updateButtonState:self.loadButton2 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID02]? NO:YES];
    [self updateButtonState:self.playButton2 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID02]? YES:NO];
    [self updateButtonState:self.loadButton3 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID03]? NO:YES];
    [self updateButtonState:self.playButton3 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID03]? YES:NO];
    [self updateButtonState:self.loadButton4 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID04]? NO:YES];
    [self updateButtonState:self.playButton4 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID04]? YES:NO];
    [self updateButtonState:self.loadButton5 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID05]? NO:YES];
    [self updateButtonState:self.playButton5 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID05]? YES:NO];
     [self updateButtonState:self.loadButton6 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID06]? NO:YES];
     [self updateButtonState:self.playButton6 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID06]? YES:NO];
    [self updateButtonState:self.loadButton7 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID07]? NO:YES];
    [self updateButtonState:self.playButton7 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID07]? YES:NO];
}

- (void)disablePlayLoadButtons {
    [self updateButtonState:self.playButton1 enabled:NO];
    [self updateButtonState:self.loadButton2 enabled:NO];
    [self updateButtonState:self.playButton2 enabled:NO];
    [self updateButtonState:self.loadButton3 enabled:NO];
    [self updateButtonState:self.playButton3 enabled:NO];
    [self updateButtonState:self.loadButton4 enabled:NO];
    [self updateButtonState:self.playButton4 enabled:NO];
    [self updateButtonState:self.loadButton5 enabled:NO];
    [self updateButtonState:self.playButton5 enabled:NO];
    [self updateButtonState:self.loadButton6 enabled:NO];
    [self updateButtonState:self.playButton6 enabled:NO];
    [self updateButtonState:self.loadButton7 enabled:NO];
    [self updateButtonState:self.playButton7 enabled:NO];
}

- (void)updateButtonState:(UIButton *) button enabled:(BOOL)enabled {
    button.enabled = enabled;
    button.alpha = (enabled? 1.0:.5);
}

#pragma mark - Screen Orientation related helpers

-(void)deviceOrientationDidChange {
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        [self getScreenDimension];
    }
    else if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        [self getScreenDimension];
    }
}

-(void)getScreenDimension {
    screenHeight = SCREEN_HEIGHT;
    screenWidth = SCREEN_WIDTH;
}

@end
