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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set VungleSDK Delegate
    [[VungleSDK sharedSDK] setDelegate:self];
    
    //We might have cached an ad before we reached this ViewController, or might have one cached from a previous launch
    if ([[VungleSDK sharedSDK] isAdPlayable]) {
		[self enableAdButtons:YES];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)dealloc
{
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

- (void) vungleSDKwillCloseAdWithViewInfo:(NSDictionary *)viewInfo willPresentProductSheet:(BOOL)willPresentProductSheet {
    if (willPresentProductSheet) {
        //In this case we don't want to resume animations and sound, the user hasn't returned to the app yet
        NSLog(@"The ad presented was tapped and the user is now being shown the App Product Sheet");
        NSLog(@"ViewInfo Dictionary:");
        for(NSString * key in [viewInfo allKeys]) {
            NSLog(@"%@ : %@", key, [[viewInfo objectForKey:key] description]);
        }
    } else {
        //In this case the user has declined to download the advertised application and is now returning fully to the main app
        //Animations / Sound / Gameplay can be resumed now
        NSLog(@"The ad presented was not tapped - the user has returned to the app");
        NSLog(@"ViewInfo Dictionary:");
        for(NSString * key in [viewInfo allKeys]) {
            NSLog(@"%@ : %@", key, [[viewInfo objectForKey:key] description]);
        }
    }
}

- (void)vungleSDKwillCloseProductSheet:(id)productSheet {
    NSLog(@"The user has downloaded an advertised application and is now returning to the main app");
    //This method can be used to resume animations, sound, etc. if a user was presented a product sheet earlier
}

#pragma mark - FirstView Methods

- (void) enableAdButtons:(BOOL)enabled {
    _showAdButton.enabled = enabled;
    _showAdWithOptionsButton.enabled = enabled;
	_showIncentivizedAdButton.enabled = enabled;
}

- (IBAction)showAd
{
    // Play a Vungle ad (with default options)
    VungleSDK* sdk = [VungleSDK sharedSDK];
    NSError *error;
    [sdk playAd:self error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
    }
}

// Play a Vungle ad (with customized options)
-(IBAction)showAdWithOptions
{
    // Grab instance of Vungle SDK
    VungleSDK* sdk = [VungleSDK sharedSDK];
    
    // Dict to set custom ad options
    NSDictionary* options = @{VunglePlayAdOptionKeyOrientations: @(UIInterfaceOrientationMaskLandscape),
							  VunglePlayAdOptionKeyUser: @"user",
                              // Use this to keep track of metrics about your users
                              VunglePlayAdOptionKeyExtraInfoDictionary: @{VunglePlayAdOptionKeyExtra1: @"21",
                                                                          VunglePlayAdOptionKeyExtra2: @"Female"}};
    
    // Pass in dict of options, play ad
    NSError *error;
    [sdk playAd:self withOptions:options error:&error];
    if (error) {
        NSLog(@"Error encountered playing ad: %@", error);
    }
}

-(IBAction)showIncentivizedAd{
	// Grab instance of Vungle SDK
	VungleSDK* sdk = [VungleSDK sharedSDK];
	
	// Dict to set custom ad options
	NSDictionary* options = @{VunglePlayAdOptionKeyIncentivized: @YES,
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

