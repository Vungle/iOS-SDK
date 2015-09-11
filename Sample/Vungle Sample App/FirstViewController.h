//
//  FirstViewController.h
//  Vungle Sample App
//
//  Created by Vungle on 3/24/14.
//  Copyright (c) 2014 Vungle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VungleSDK/VungleSDK.h>

@interface FirstViewController : UIViewController<VungleSDKDelegate>

@property (weak, nonatomic) IBOutlet UIButton *showAdButton;
@property (weak, nonatomic) IBOutlet UIButton *showAdWithOptionsButton;
@property (weak, nonatomic) IBOutlet UIButton *showIncentivizedAdButton;

-(IBAction)showAd;
-(IBAction)showAdWithOptions;

@end
