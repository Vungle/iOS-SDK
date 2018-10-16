//
//  FirstViewController.m
//  Vungle Sample App
//
//  Created by Vungle on 3/24/14.
//  Copyright (c) 2017 Vungle. All rights reserved.
//

#import "FirstViewController.h"

static NSString *const kVungleAppIDPrefix = @"AppID: ";
static NSString *const kVunglePlacementIDPrefix = @"PlacementID: ";

static NSString *const kVungleTestAppID = @"58fe200484fbd5b9670000e3";
static NSString *const kVungleTestPlacementID01 = @"PLMT01-41570"; // Auto Cached
static NSString *const kVungleTestPlacementID02 = @"PLMT02-05269";
static NSString *const kVungleTestPlacementID03 = @"PLMT03-8358426";
static NSString *const kVungleTestPlacementID04 = @"PLMT04-8738960";

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UILabel *appIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel1;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel2;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel3;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel4;

@property (weak, nonatomic) IBOutlet UIButton *sdkInitButton;
@property (weak, nonatomic) IBOutlet UIButton *loadButton2;
@property (weak, nonatomic) IBOutlet UIButton *loadButton3;
@property (weak, nonatomic) IBOutlet UIButton *loadButton4;
@property (weak, nonatomic) IBOutlet UIButton *playButton1;
@property (weak, nonatomic) IBOutlet UIButton *playButton2;
@property (weak, nonatomic) IBOutlet UIButton *playButton3;
@property (weak, nonatomic) IBOutlet UIButton *playButton4;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton3;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton4;
@property (weak, nonatomic) IBOutlet UIButton *checkCurrentStatusButton;

@property (weak, nonatomic) IBOutlet UIView *flexFeedView;

@property (nonatomic, strong) VungleSDK *sdk;

@end

@implementation FirstViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewDefault];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
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
    }
}

- (IBAction)onDismissButtonTapped:(id)sender {
    if (sender == self.dismissButton3) {
        [self.sdk finishedDisplayingAd];
    } else if (sender == self.dismissButton4) {
        [self.sdk finishedDisplayingAd];
    }
}

- (IBAction)onCheckCurrentStatusButtonTapped:(id)sender {
    NSLog(@"-->> SDK Initialized: %@", (self.sdk.initialized? @"YES":@"NO"));
    NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID01, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID01]? @"YES":@"NO"));
    NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID02, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID02]? @"YES":@"NO"));
    NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID03, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID03]? @"YES":@"NO"));
    NSLog(@"-->> %@ - an ad loaded: %@", kVungleTestPlacementID04, ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID04]? @"YES":@"NO"));
}

#pragma mark - VungleSDKDelegate Methods

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
        [self updateButtonState:self.dismissButton3 enabled:YES];
    } else if ([placementID isEqualToString:kVungleTestPlacementID04]) {
        NSLog(@"-->> Ad will show for %@", kVungleTestPlacementID04);
        [self updateButtonState:self.playButton4 enabled:NO];
        [self updateButtonState:self.dismissButton4 enabled:YES];
    }
}

- (void)vungleWillCloseAdWithViewInfo:(VungleViewInfo *)info placementID:(NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleWillCloseAdWithViewInfo");
}

- (void)vungleDidCloseAdWithViewInfo:(VungleViewInfo *)info placementID:(NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleDidCloseAdWithViewInfo");
    
    if ([placementID isEqualToString:kVungleTestPlacementID01]) {
        NSLog(@"-->> Ad is closed for %@", kVungleTestPlacementID01);
    } else if ([placementID isEqualToString:kVungleTestPlacementID02]) {
        NSLog(@"-->> Ad is closed for %@", kVungleTestPlacementID02);
    } else if ([placementID isEqualToString:kVungleTestPlacementID03]) {
        NSLog(@"-->> Ad is closed for %@", kVungleTestPlacementID03);
        [self updateButtonState:self.dismissButton3 enabled:NO];
    } else if ([placementID isEqualToString:kVungleTestPlacementID04]) {
        NSLog(@"-->> Ad is closed for %@", kVungleTestPlacementID04);
        [self updateButtonState:self.dismissButton4 enabled:NO];
    }
    
    if (info) {
        NSLog(@"Info about ad viewed: %@", info);
    }
    
    [self updateButtons];
}

- (void)vungleSDKDidInitialize {
    NSLog(@"-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY");
    [self updateButtons];
}

#pragma mark - FirstView Methods

- (void)setViewDefault {
    self.appIdLabel.text = [kVungleAppIDPrefix stringByAppendingString:kVungleTestAppID];
    self.placementIdLabel1.text = [kVunglePlacementIDPrefix stringByAppendingString:kVungleTestPlacementID01];
    self.placementIdLabel2.text = [kVunglePlacementIDPrefix stringByAppendingString:kVungleTestPlacementID02];
    self.placementIdLabel3.text = [kVunglePlacementIDPrefix stringByAppendingString:kVungleTestPlacementID03];
    self.placementIdLabel4.text = [kVunglePlacementIDPrefix stringByAppendingString:kVungleTestPlacementID04];

    [self updateButtonState:self.loadButton2 enabled:NO];
    [self updateButtonState:self.loadButton3 enabled:NO];
    [self updateButtonState:self.loadButton4 enabled:NO];
    [self updateButtonState:self.playButton1 enabled:NO];
    [self updateButtonState:self.playButton2 enabled:NO];
    [self updateButtonState:self.playButton3 enabled:NO];
    [self updateButtonState:self.playButton4 enabled:NO];
    [self updateButtonState:self.dismissButton3 enabled:NO];
    [self updateButtonState:self.dismissButton4 enabled:NO];
}

- (void)startVungle {
    [self updateButtonState:self.sdkInitButton enabled:NO];
    self.sdk = [VungleSDK sharedSDK];
    [self.sdk setDelegate:self];
    [self.sdk setLoggingEnabled:YES];
    NSError *error = nil;

    if(![self.sdk startWithAppId:kVungleTestAppID error:&error]) {
        NSLog(@"Error while starting VungleSDK %@", [error localizedDescription]);
        [self updateButtonState:self.sdkInitButton enabled:YES];
        return;
    }
}

- (IBAction)showAdForPlacement01 {
    // Play a Vungle ad (with ordinal)
    NSError *error;
    [self.sdk playAd:self options:@{VunglePlayAdOptionKeyUser:@"test_user_id",
                                    VunglePlayAdOptionKeyIncentivizedAlertBodyText : @"If the video isn't completed you won't get your reward! Are you sure you want to close early?",
                                    VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText : @"Close",
                                    VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText : @"Keep Watching",
                                    VunglePlayAdOptionKeyIncentivizedAlertTitleText : @"Careful!"} placementID:kVungleTestPlacementID01 error:&error];
    
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
    }
}

- (IBAction)showAdForPlacement02 {
    // Play a Vungle ad (with options). Dictionary to set custom ad options.
    NSDictionary *options = @{VunglePlayAdOptionKeyUser:@"test_user_id",
                              VunglePlayAdOptionKeyIncentivizedAlertBodyText : @"If the video isn't completed you won't get your reward! Are you sure you want to close early?",
                              VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText : @"Close",
                              VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText : @"Keep Watching",
                              VunglePlayAdOptionKeyIncentivizedAlertTitleText : @"Careful!"};
    
    NSError *error;
    [self.sdk playAd:self options:options placementID:kVungleTestPlacementID02 error:&error];
    
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
        [self updateButtonState:self.loadButton2 enabled:YES];
    }
}

- (IBAction)showAdForPlacement03 {
	// Play a Vungle ad (with options). Dictionary to set custom ad options.
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
    } else {
        [self updateButtonState:self.dismissButton3 enabled:YES];
    }
}

- (IBAction)showAdForPlacement04 {
    // Play a Vungle ad (with default options)
    NSError *error;
    [self.sdk addAdViewToView:self.flexFeedView withOptions:nil placementID:kVungleTestPlacementID04 error:&error];
    
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
        [self updateButtonState:self.loadButton4 enabled:YES];
    } else {
        [self updateButtonState:self.dismissButton4 enabled:YES];
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
}

- (void)updateButtonState:(UIButton *) button enabled:(BOOL)enabled {
    button.enabled = enabled;
    button.alpha = (enabled? 1.0:.5);
}

@end
