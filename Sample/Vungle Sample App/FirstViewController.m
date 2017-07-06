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
static NSString *const kVungleTestPlacementID01 = @"DEFAULT87043"; // auto cache placement
static NSString *const kVungleTestPlacementID02 = @"PLMT02I05269";
static NSString *const kVungleTestPlacementID03 = @"PLMT03R77999";


@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel1;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel2;
@property (weak, nonatomic) IBOutlet UILabel *placementIdLabel3;

@property (weak, nonatomic) IBOutlet UIButton *sdkInitButton;

@property (weak, nonatomic) IBOutlet UIButton *loadButton2;
@property (weak, nonatomic) IBOutlet UIButton *loadButton3;

@property (weak, nonatomic) IBOutlet UIButton *playButton1;
@property (weak, nonatomic) IBOutlet UIButton *playButton2;
@property (weak, nonatomic) IBOutlet UIButton *playButton3;
@property (weak, nonatomic) IBOutlet UIButton *checkCurrentStatusButton;

@property (nonatomic, strong) VungleSDK *sdk;
@property (nonatomic, strong) NSArray *placementIDsArray;
@end


@implementation FirstViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewDefault];    
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
    }
    else if(sender == self.loadButton3) {
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
    }
}

- (IBAction)onPlayButtonTapped:(id)sender {
    [self updateButtonState:self.playButton1 enabled:NO];
    [self updateButtonState:self.playButton2 enabled:NO];
    [self updateButtonState:self.playButton3 enabled:NO];
    
    if (sender == self.playButton1) {
        NSLog(@"-->> play an ad for placement 01");
        [self showAdForPlacement01];
    }
    else if (sender == self.playButton2) {
        NSLog(@"-->> play an ad for placement 02");
        [self showAdForPlacement02];
    }
    else if (sender == self.playButton3) {
        NSLog(@"-->> play an ad for placement 03");
        [self showAdForPlacement03];
    }
}

- (IBAction)onCheckCurrentStatusButtonTapped:(id)sender {
    NSLog(@"Current Status ------------>> ");
    NSLog(@"-->> SDK Initialized: %@", (self.sdk.initialized? @"YES":@"NO"));
    NSLog(@"-->> Placement 01 - an ad Loaded: %@", ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID01]? @"YES":@"NO"));
    NSLog(@"-->> Placement 02 - an ad Loaded: %@", ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID02]? @"YES":@"NO"));
    NSLog(@"-->> Placement 03 - an ad Loaded: %@", ([self.sdk isAdCachedForPlacementID:kVungleTestPlacementID03]? @"YES":@"NO"));
    NSLog(@"-->>------------------ ");
}


#pragma mark - VungleSDKDelegate Methods

- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(NSString *)placementID {
    if (isAdPlayable) {
        NSLog(@"-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is available for Placement ID: %@", placementID);
    }
    else {
        NSLog(@"-->> Delegate Callback: vungleAdPlayabilityUpdate: Ad is NOT availablefor Placement ID: %@", placementID);
    }
    
    if ([placementID isEqualToString:kVungleTestPlacementID01]) {
        [self updateButtonState:self.playButton1 enabled:isAdPlayable];
    }
    else if ([placementID isEqualToString:kVungleTestPlacementID02]) {
        [self updateButtonState:self.playButton2 enabled:isAdPlayable];
        [self updateButtonState:self.loadButton2 enabled:!isAdPlayable];
    }
    else if ([placementID isEqualToString:kVungleTestPlacementID03]) {
        [self updateButtonState:self.playButton3 enabled:isAdPlayable];
        [self updateButtonState:self.loadButton3 enabled:!isAdPlayable];
    }
}

- (void)vungleWillShowAdForPlacementID:(nullable NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleSDKwillShowAd");
    
    if ([placementID isEqualToString:kVungleTestPlacementID01]) {
        NSLog(@"-->> Ad will show for Placment 01");
        [self updateButtonState:self.playButton1 enabled:NO];
    }
    else if ([placementID isEqualToString:kVungleTestPlacementID02]) {
        NSLog(@"-->> Ad will show for Placment 02");
        [self updateButtonState:self.playButton2 enabled:NO];
    }
    else if ([placementID isEqualToString:kVungleTestPlacementID03]) {
        NSLog(@"-->> Ad will show for Placment 03");
        [self updateButtonState:self.playButton3 enabled:NO];
    }
}

- (void)vungleWillCloseAdWithViewInfo:(VungleViewInfo *)info placementID:(NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleWillCloseAdWithViewInfo");
    
    if ([placementID isEqualToString:kVungleTestPlacementID01]) {
        NSLog(@"-->> Ad is closed for Placment 01");
    }
    else if ([placementID isEqualToString:kVungleTestPlacementID02]) {
        NSLog(@"-->> Ad is closed for Placment 02");
    }
    else if ([placementID isEqualToString:kVungleTestPlacementID03]) {
        NSLog(@"-->> Ad is closed for Placment 03");
    }
    
    if (info) {
        NSLog(@"Info about ad viewed: %@", info);
    }
    
    [self updateButtons];
}

- (void)vungleSDKDidInitialize {
    NSLog(@"-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY");
    
    [self updateButtonState:self.loadButton2 enabled:YES];
    [self updateButtonState:self.loadButton3 enabled:YES];
}


#pragma mark - FirstView Methods

- (void)setViewDefault {
    self.appIdLabel.text = [kVungleAppIDPrefix stringByAppendingString:kVungleTestAppID];
    self.placementIdLabel1.text = [kVunglePlacementIDPrefix stringByAppendingString:kVungleTestPlacementID01];
    self.placementIdLabel2.text = [kVunglePlacementIDPrefix stringByAppendingString:kVungleTestPlacementID02];
    self.placementIdLabel3.text = [kVunglePlacementIDPrefix stringByAppendingString:kVungleTestPlacementID03];

    [self updateButtonState:self.loadButton2 enabled:NO];
    [self updateButtonState:self.loadButton3 enabled:NO];
    [self updateButtonState:self.playButton1 enabled:NO];
    [self updateButtonState:self.playButton2 enabled:NO];
    [self updateButtonState:self.playButton3 enabled:NO];
}

- (void)startVungle {
    [self updateButtonState:self.sdkInitButton enabled:NO];

    self.placementIDsArray = [NSArray arrayWithObjects:kVungleTestPlacementID01, kVungleTestPlacementID02, kVungleTestPlacementID03, nil];
    
    self.sdk = [VungleSDK sharedSDK];
    [self.sdk setDelegate:self];
    [self.sdk setLoggingEnabled:YES];
    NSError *error = nil;

    if(![self.sdk startWithAppId:kVungleTestAppID placements:self.placementIDsArray error:&error]) {
        NSLog(@"Error while starting VungleSDK %@", [error localizedDescription]);
        
        [self updateButtonState:self.sdkInitButton enabled:YES];
        return;
    }
}

- (IBAction)showAdForPlacement01 {
    // Play a Vungle ad (with default options)
    NSError *error;
    [self.sdk playAd:self options:nil placementID:kVungleTestPlacementID01 error:&error];
    
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
    }
}

- (IBAction)showAdForPlacement02 {
    // Play a Vungle ad (with options). Dictionary to set custom ad options.
    NSDictionary *options = @{VunglePlayAdOptionKeyOrientations: @(UIInterfaceOrientationMaskLandscape)};
    
    NSError *error;
    [self.sdk playAd:self options:options placementID:kVungleTestPlacementID02 error:&error];
    
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
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
	}
}

- (void)updateButtons {
    [self updateButtonState:self.playButton1 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID01]? YES:NO];
    [self updateButtonState:self.playButton2 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID02]? YES:NO];
    [self updateButtonState:self.loadButton2 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID02]? NO:YES];
    [self updateButtonState:self.playButton3 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID03]? YES:NO];
    [self updateButtonState:self.loadButton3 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID03]? NO:YES];
}

- (void)updateButtonState:(UIButton *) button enabled:(BOOL)enabled {
    button.enabled = enabled;
    button.alpha = (enabled? 1.0:0.45);
}

@end

