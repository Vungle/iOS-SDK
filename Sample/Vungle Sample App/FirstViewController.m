//
//  FirstViewController.m
//  Vungle Sample App
//
//  Created by Vungle on 3/24/14.
//  Copyright (c) 2014 Vungle. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set VungleSDK Delegate
    [[VungleSDK sharedSDK] setDelegate:self];
    
    //We might have cached an ad before we reached this ViewController, or might have one cached from a previous launch
    if ([[VungleSDK sharedSDK] isAdPlayable]) {
		[self enableAdButtons:YES];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)dealloc {
    [[VungleSDK sharedSDK] setDelegate:nil];
}

#pragma mark - VungleSDK Delegate

- (void)vungleSDKAdPlayableChanged:(BOOL)isAdPlayable {
	if (isAdPlayable) {
		NSLog(@"An ad is available for playback");
		if (!_showAdButton.enabled || !_showAdWithOptionsButton.enabled) {
			[self enableAdButtons:YES];
		}
	} else {
		NSLog(@"No ads currently available for playback");
		[self enableAdButtons:NO];
	}
}

- (void)vungleSDKwillShowAd {
    NSLog(@"An ad is about to be played!");
    //Use this delegate method to pause animations, sound, etc.
}

- (void)vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet {
    NSLog(@"ViewInfo Dictionary:");
    //This method can be used to resume animations, sound, etc.
    
    // viewInfo dictioanry contains completedView, playTime and didDownload information
    // willPresentProductSheet always returns NO
    for(NSString * key in [viewInfo allKeys]) {
        NSLog(@"%@ : %@", key, [[viewInfo objectForKey:key] description]);
    }
}

#pragma mark - FirstView Methods

- (void)enableAdButtons:(BOOL)enabled {
    _showAdButton.enabled = enabled;
    _showAdWithOptionsButton.enabled = enabled;
    _showIncentivizedAdButton.enabled = enabled;
}

- (IBAction)showAd {
    // Play a Vungle ad (with default options)
    VungleSDK *sdk = [VungleSDK sharedSDK];
    NSError *error;
    [sdk playAd:self error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
    }
}

// Play a Vungle ad (with customized options)
- (IBAction)showAdWithOptions {
    // Grab instance of Vungle SDK
    VungleSDK *sdk = [VungleSDK sharedSDK];
    
    // Dict to set custom ad options
    NSDictionary *options = @{VunglePlayAdOptionKeyOrientations: @(UIInterfaceOrientationMaskLandscape)};
    
    // Pass in dict of options, play ad
    NSError *error;
    [sdk playAd:self withOptions:options error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
    }
}

- (IBAction)showIncentivizedAd {
	// Grab instance of Vungle SDK
	VungleSDK *sdk = [VungleSDK sharedSDK];
	
	// Dict to set custom ad options
	NSDictionary *options = @{VunglePlayAdOptionKeyIncentivized: @YES,
                              VunglePlayAdOptionKeyUser: @"user_test_id",
							  VunglePlayAdOptionKeyIncentivizedAlertBodyText : @"If the video isn't completed you won't get your reward! Are you sure you want to close early?",
							  VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText : @"Close",
							  VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText : @"Keep Watching",
							  VunglePlayAdOptionKeyIncentivizedAlertTitleText : @"Careful!"};
	
	// Pass in dict of options, play ad
	NSError *error;
	[sdk playAd:self withOptions:options error:&error];
	if (error) {
		NSLog(@"Error encountered playing ad: %@", error);
	}
}

@end

