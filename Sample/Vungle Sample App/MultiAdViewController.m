//
//  MultiAdViewController.m
//  Vungle Sample App
//
//  Created by John Mai on 4/6/20.
//  Copyright © 2020 Jordyn Chuhaloff. All rights reserved.
//

#import "MultiAdViewController.h"
#import "Constants.h"
#import "BannerTableViewCell.h"
#import "MRECTableViewCell.h"

@interface MultiAdViewController () {
        CGFloat screenHeight;
        CGFloat screenWidth;
}

@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) VungleSDK *sdk;
@property (nonatomic, assign, getter = isPlayingBanner1) BOOL playingBanner1;
@property (nonatomic, assign, getter = isPlayingBanner2) BOOL playingBanner2;
@property (nonatomic, assign, getter = isPlayingMREC1) BOOL playingMREC1;
@property (nonatomic, assign, getter = isPlayingMREC2) BOOL playingMREC2;

@end

@implementation MultiAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.multiAdTableView];
    self.multiAdTableView.delegate = self;
    self.multiAdTableView.dataSource = self;
    [self.sdk updateCCPAStatus:VungleCCPAAccepted];
    /**CCPA Status Denied API call
     [self.sdk updateCCPAStatus:VungleCCPADenied];
     */
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setFullscreenDefault];
    [self.multiAdTableView reloadData];
}

- (IBAction)startTapped:(id)sender {
    [self startVungle];
}

- (IBAction)loadFullScreenTapped:(id)sender {
    NSError* error;
    if (![self.sdk loadPlacementWithID:kVungleTestPlacementID02 error:&error]) {
        [self updateButtonState:sender enabled:YES];
        if (error) {
            NSLog(@"The loading error is: %@",error);
        }
    } else {
        [self updateButtonState:sender enabled:NO];
    }
}

- (IBAction)playFullScreenTapped:(id)sender {
    NSError* error;
    if (![self.sdk playAd:self options:nil placementID:kVungleTestPlacementID02 error:&error]) {
        if (error) {
            NSLog(@"Error when attempting to play fullscreen ad %@",error);
        }
    }
}

#pragma mark - UITableView methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 200.0;
    if (indexPath.row == 1 || indexPath.row == 3) {
        height = 400.0;
    }
    return height;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView*) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    if (indexPath.row == 0) {
        cell = [self.multiAdTableView dequeueReusableCellWithIdentifier:@"bannerCell" forIndexPath:indexPath];
        BannerTableViewCell *bannerCell = (BannerTableViewCell*) cell;
        bannerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        bannerCell.bannerLabel.text = [kVunglePlacementID7Prefix stringByAppendingString:kVungleTestPlacementID07];
        if (![self.sdk isInitialized]) {
            [self updateButtonState:bannerCell.loadBannerButton enabled:NO];
            [self updateButtonState:bannerCell.playBannerButton enabled:NO];
            [self updateButtonState:bannerCell.dismissBannerButton enabled:NO];
        } else {
            [self updateButtonState:bannerCell.loadBannerButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID07]? NO:YES];
            [self updateButtonState:bannerCell.playBannerButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID07]? YES:NO];
        }
        [bannerCell.loadBannerButton addTarget:self action:@selector(loadVungleBannerAd) forControlEvents:UIControlEventTouchUpInside];
        [bannerCell.playBannerButton addTarget:self action:@selector(playVungleBannerAd) forControlEvents:UIControlEventTouchUpInside];
        [bannerCell.dismissBannerButton addTarget:self action:@selector(dismissVungleBanner) forControlEvents:UIControlEventTouchUpInside];
    } else if (indexPath.row == 1) {
        cell = [self.multiAdTableView dequeueReusableCellWithIdentifier:@"mrecCell" forIndexPath:indexPath];
        MRECTableViewCell *mrecCell = (MRECTableViewCell*) cell;
        mrecCell.selectionStyle = UITableViewCellSelectionStyleNone;
        mrecCell.mrecLabel.text = [kVunglePlacementID5Prefix stringByAppendingString:kVungleTestPlacementID05];
        if (![self.sdk isInitialized]) {
            [self updateButtonState:mrecCell.loadMRECButton enabled:NO];
            [self updateButtonState:mrecCell.playMRECButton enabled:NO];
            [self updateButtonState:mrecCell.dismissMRECButton enabled:NO];
        } else {
            [self updateButtonState:mrecCell.loadMRECButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID05]? NO:YES];
            [self updateButtonState:mrecCell.playMRECButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID05]? YES:NO];
        }
        [mrecCell.loadMRECButton addTarget:self action:@selector(loadVungleMrecAd) forControlEvents:UIControlEventTouchUpInside];
        [mrecCell.playMRECButton addTarget:self action:@selector(playVungleMrecAd) forControlEvents:UIControlEventTouchUpInside];
        [mrecCell.dismissMRECButton addTarget:self action:@selector(dismissVungleMrec) forControlEvents:UIControlEventTouchUpInside];
    } else if (indexPath.row == 2) {
        cell = [self.multiAdTableView dequeueReusableCellWithIdentifier:@"bannerCell" forIndexPath:indexPath];
        BannerTableViewCell *bannerCell2 = (BannerTableViewCell*) cell;
        bannerCell2.selectionStyle = UITableViewCellSelectionStyleNone;
        bannerCell2.bannerLabel.text = [kVunglePlacementID8Prefix stringByAppendingFormat:kVungleTestPlacementID08];
        if (![self.sdk isInitialized]) {
            [self updateButtonState:bannerCell2.loadBannerButton enabled:NO];
            [self updateButtonState:bannerCell2.playBannerButton enabled:NO];
            [self updateButtonState:bannerCell2.dismissBannerButton enabled:NO];
        } else {
            [self updateButtonState:bannerCell2.loadBannerButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID08]? NO:YES];
            [self updateButtonState:bannerCell2.playBannerButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID08]? YES:NO];
        }
        [bannerCell2.loadBannerButton addTarget:self action:@selector(loadVungleBannerAdBottom) forControlEvents:UIControlEventTouchUpInside];
        [bannerCell2.playBannerButton addTarget:self action:@selector(playVungleBannerAdBottom) forControlEvents:UIControlEventTouchUpInside];
        [bannerCell2.dismissBannerButton addTarget:self action:@selector(dismissVungleBannerBottom) forControlEvents:UIControlEventTouchUpInside];
    } else if (indexPath.row == 3) {
        cell = [self.multiAdTableView dequeueReusableCellWithIdentifier:@"mrecCell" forIndexPath:indexPath];
        MRECTableViewCell *mrecCell2 = (MRECTableViewCell*) cell;
        mrecCell2.selectionStyle = UITableViewCellSelectionStyleNone;
        mrecCell2.mrecLabel.text = [kVunglePlacementID9Prefix stringByAppendingFormat:kVungleTestPlacementID09];
        if (![self.sdk isInitialized]) {
            [self updateButtonState:mrecCell2.loadMRECButton enabled:NO];
            [self updateButtonState:mrecCell2.playMRECButton enabled:NO];
            [self updateButtonState:mrecCell2.dismissMRECButton enabled:NO];
        } else {
            [self updateButtonState:mrecCell2.loadMRECButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID09]? NO:YES];
            [self updateButtonState:mrecCell2.playMRECButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID09]? YES:NO];
        }
        [mrecCell2.loadMRECButton addTarget:self action:@selector(loadVungleMrecAdBottom) forControlEvents:UIControlEventTouchUpInside];
        [mrecCell2.playMRECButton addTarget:self action:@selector(playVungleMrecAdBottom) forControlEvents:UIControlEventTouchUpInside];
        [mrecCell2.dismissMRECButton addTarget:self action:@selector(dismissVungleMrecBottom) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

#pragma mark - VungleSDKDelegate Methods

- (void)vungleSDKDidInitialize {
    NSLog(@"-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY");
    [self updateButtons];
}

-(void)vungleWillShowAdForPlacementID:(NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleWillShowAdForPlacement is called %@", placementID);
}

-(void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(NSString *)placementID error:(NSError *)error {
    if (isAdPlayable) {
        NSLog(@"-->> Delegate Callback: vungleAdPlayabilityUpdate is available to be played for %@",placementID);
    } else {
        NSLog(@"-->> Delegate Callback: vungleAdPlayabilityUpdate is NOT available to be played for %@",placementID);
    }
    if ([placementID isEqualToString:kVungleTestPlacementID05]) {
        NSLog(@"vungleAdPlayability for 05");
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForItem:1 inSection:0];
        UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath2];
        MRECTableViewCell *mCell = (MRECTableViewCell*)cell;
        if(![self isPlayingMREC1]) {
            [self updateButtonState:mCell.loadMRECButton enabled:!isAdPlayable];
        }
        [self updateButtonState:mCell.playMRECButton enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID07]) {
        NSLog(@"vungleAdPlayability for 07");
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:0 inSection:0];
        UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath1];
        BannerTableViewCell *bCell = (BannerTableViewCell*)cell;
        if (![self isPlayingBanner1]) {
            [self updateButtonState:bCell.loadBannerButton enabled:!isAdPlayable];
        }
        [self updateButtonState:bCell.playBannerButton enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID08]) {
        NSLog(@"vungleAdPlayability for 08");
        NSIndexPath *indexPath3 = [NSIndexPath indexPathForItem:2 inSection:0];
        UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath3];
        BannerTableViewCell *bCell = (BannerTableViewCell*)cell;
        if (![self isPlayingBanner2]) {
            [self updateButtonState:bCell.loadBannerButton enabled:!isAdPlayable];
        }
        [self updateButtonState:bCell.playBannerButton enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID09]) {
        NSLog(@"vungleAdPlayability for 09");
        NSIndexPath *indexPath4 = [NSIndexPath indexPathForItem:3 inSection:0];
        UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath4];
        MRECTableViewCell *mCell = (MRECTableViewCell*)cell;
        if (![self isPlayingMREC2]) {
            [self updateButtonState:mCell.loadMRECButton enabled:!isAdPlayable];
        }
        [self updateButtonState:mCell.playMRECButton enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID02]) {
        [self updateButtonState:self.loadFullScreen enabled:!isAdPlayable];
        [self updateButtonState:self.playFullScreen enabled:isAdPlayable];
    }
}

-(void)vungleWillCloseAdForPlacementID:(nonnull NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleWillCloseAdForPlacementID for %@",placementID);
}

- (void)vungleDidCloseAdForPlacementID:(nonnull NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleDidCloseAdForPlacementID for %@", placementID);
    [self updateButtons];
}

- (void)vungleTrackClickForPlacementID:(nullable NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleTrackClickForPlacementID for %@", placementID);
}

- (void)vungleWillLeaveApplicationForPlacementID:(nullable NSString *)placementID {
    NSLog(@"-->> Delegate Callback: vungleWillLeaveApplicationForPlacementID for %@", placementID);
}

#pragma mark - Helper Methods

- (void)startVungle {
    [self updateButtonState:self.startButton enabled:NO];
    self.sdk = [VungleSDK sharedSDK];
    [self.sdk setDelegate:self];
    [self.sdk setLoggingEnabled:YES];
    NSError *error = nil;
    if(![self.sdk startWithAppId:kVungleTestAppID options:nil error:&error]) {
        NSLog(@"Error while starting VungleSDK %@",[error localizedDescription]);
        return;
    }
}

-(void)setFullscreenDefault {
    self.fullScreenLabel.text = [kVunglePlacementID2Prefix stringByAppendingString:kVungleTestPlacementID02];
    [self updateButtonState:self.loadFullScreen enabled:NO];
    [self updateButtonState:self.playFullScreen enabled:NO];
}

-(void)loadVungleBannerAd {
    NSError *error;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    BannerTableViewCell *bCell = (BannerTableViewCell*)cell;
    if (![self.sdk loadPlacementWithID:kVungleTestPlacementID07 withSize:VungleAdSizeBanner error:&error]) {
        [self updateButtonState:bCell.loadBannerButton enabled:YES];
        if (error) {
            NSLog(@"Error encountered trying to load banner ad %@",error);
        }
    } else {
        [self updateButtonState:bCell.loadBannerButton enabled:NO];
    }
}

-(void)loadVungleMrecAd {
    NSError *error;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    MRECTableViewCell *mCell = (MRECTableViewCell*)cell;
    if (![self.sdk loadPlacementWithID:kVungleTestPlacementID05 error:&error]) {
        [self updateButtonState:mCell.loadMRECButton enabled:YES];
        if (error) {
            NSLog(@"Error encountered trying to load MRECad %@",error);
        }
    } else {
        [self updateButtonState:mCell.loadMRECButton enabled:NO];
    }
}

-(void)loadVungleMrecAdBottom {
    NSError *error;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    MRECTableViewCell *mCell = (MRECTableViewCell*)cell;
    if (![self.sdk loadPlacementWithID:kVungleTestPlacementID09 error:&error]) {
        [self updateButtonState:mCell.loadMRECButton enabled:YES];
        if (error) {
            NSLog(@"Error encountered trying to load MRECad %@",error);
        }
    } else {
        [self updateButtonState:mCell.loadMRECButton enabled:NO];
    }
}

-(void)playVungleBannerAd {
    NSError *error;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    BannerTableViewCell *bCell = (BannerTableViewCell*)cell;
    CGFloat cellWidth = cell.contentView.frame.size.width;
    bCell.bannerView.frame = CGRectMake((cellWidth - 320)/2.0, 121, 320.0, 50.0);
    bCell.bannerView = [[UIView alloc] initWithFrame:bCell.bannerView.frame];
    [bCell addSubview:bCell.bannerView];
    if(![self.sdk addAdViewToView:bCell.bannerView withOptions:nil placementID:kVungleTestPlacementID07 error:&error]) {
        if(error) {
            NSLog(@"Error encountered when trying to display banner %@",error);
            [self updateButtonState:bCell.loadBannerButton enabled:YES];
        }
    } else {
        [self updateButtonState:bCell.dismissBannerButton enabled:YES];
    }
    [self setPlayingBanner1:YES];
}

-(void)playVungleMrecAd {
    NSError *error;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    MRECTableViewCell *mCell = (MRECTableViewCell*)cell;
    CGFloat cellWidth = cell.contentView.frame.size.width;
    mCell.mrecView.frame = CGRectMake((cellWidth - 320)/2.0, 118, 300.0, 250.0);
    mCell.mrecView = [[UIView alloc] initWithFrame:mCell.mrecView.frame];
    [mCell addSubview:mCell.mrecView];
    if (![self.sdk addAdViewToView:mCell.mrecView withOptions:nil placementID:kVungleTestPlacementID05 error:&error]) {
        if (error) {
            NSLog(@"Error encountered trying to load ad %@",error);
            [self updateButtonState:mCell.loadMRECButton enabled:YES];
        }
    } else {
        [self updateButtonState:mCell.dismissMRECButton enabled:YES];
    }
    [self setPlayingMREC1:YES];
}

-(void)playVungleMrecAdBottom {
    NSError *error;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    MRECTableViewCell *mCell = (MRECTableViewCell*)cell;
    CGFloat cellWidth = cell.contentView.frame.size.width;
    mCell.mrecView.frame = CGRectMake((cellWidth - 320)/2.0, 118, 300.0, 250.0);
       mCell.mrecView = [[UIView alloc] initWithFrame:mCell.mrecView.frame];
       [mCell addSubview:mCell.mrecView];
    if (![self.sdk addAdViewToView:mCell.mrecView withOptions:nil placementID:kVungleTestPlacementID09 error:&error]) {
        if (error) {
            NSLog(@"Error encountered trying to load ad %@",error);
            [self updateButtonState:mCell.loadMRECButton enabled:YES];
        }
    } else {
        [self updateButtonState:mCell.dismissMRECButton enabled:YES];
    }
    [self setPlayingMREC2:YES];
}

-(void)loadVungleBannerAdBottom {
    NSError *error;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:2 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    BannerTableViewCell *bCell = (BannerTableViewCell*)cell;
    if(![self.sdk loadPlacementWithID:kVungleTestPlacementID08 withSize:VungleAdSizeBanner error:&error]) {
        [self updateButtonState:bCell.loadBannerButton enabled:YES];
        if(error) {
            NSLog(@"Error encountered when attempting to load the bottom banner %@",error);
        }
    } else {
        [self updateButtonState:bCell.loadBannerButton enabled:NO];
    }
}

-(void)playVungleBannerAdBottom {
    NSError *error;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:2 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    BannerTableViewCell *bCell = (BannerTableViewCell*)cell;
    CGFloat cellWidth = cell.contentView.frame.size.width;
    bCell.bannerView.frame = CGRectMake((cellWidth - 320)/2.0, 121, 320.0, 50.0);
    bCell.bannerView = [[UIView alloc] initWithFrame:bCell.bannerView.frame];
    [bCell addSubview:bCell.bannerView];
    if (![self.sdk addAdViewToView:bCell.bannerView withOptions:nil placementID:kVungleTestPlacementID08 error:&error]) {
        if (error) {
            NSLog(@"Error encountered trying to load ad %@",error);
            [self updateButtonState:bCell.loadBannerButton enabled:YES];
        }
    } else {
        [self updateButtonState:bCell.dismissBannerButton enabled:YES];
    }
    [self setPlayingBanner2:YES];
}

-(void)dismissVungleBanner {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    BannerTableViewCell *bCell = (BannerTableViewCell*)cell;
    [self.sdk finishDisplayingAd:kVungleTestPlacementID07];
    if (bCell.bannerView != nil) {
        [bCell.bannerView removeFromSuperview];
        [self updateButtonState:bCell.dismissBannerButton enabled:NO];
    }
}
-(void)dismissVungleMrec {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    MRECTableViewCell *mCell = (MRECTableViewCell*)cell;
    [self.sdk finishDisplayingAd:kVungleTestPlacementID05];
    if (mCell.mrecView != nil) {
        [mCell.mrecView removeFromSuperview];
        [self updateButtonState:mCell.dismissMRECButton enabled:NO];
    }
}
-(void)dismissVungleBannerBottom {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:2 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    BannerTableViewCell *bCell = (BannerTableViewCell*)cell;
    [self.sdk finishDisplayingAd:kVungleTestPlacementID08];
    if (bCell.bannerView != nil) {
        [bCell.bannerView removeFromSuperview];
        [self updateButtonState:bCell.dismissBannerButton enabled:NO];
    }
}

-(void)dismissVungleMrecBottom {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:3 inSection:0];
    UITableViewCell *cell = [self.multiAdTableView cellForRowAtIndexPath:indexPath];
    MRECTableViewCell *mCell = (MRECTableViewCell*)cell;
    [self.sdk finishDisplayingAd:kVungleTestPlacementID09];
    if (mCell.mrecView != nil) {
        [mCell.mrecView removeFromSuperview];
        [self updateButtonState:mCell.dismissMRECButton enabled:NO];
    }
}

- (void)updateButtons {
    [self updateButtonState:self.loadFullScreen enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID02]? NO:YES];
    [self updateButtonState:self.playFullScreen enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID02]? YES:NO];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:0 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForItem:1 inSection:0];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForItem:2 inSection:0];
    NSIndexPath *indexPath4 = [NSIndexPath indexPathForItem:3 inSection:0];
    BannerTableViewCell *bCell1 = (BannerTableViewCell*)([self.multiAdTableView cellForRowAtIndexPath:indexPath1]);
    BannerTableViewCell *bCell2 = (BannerTableViewCell*)([self.multiAdTableView cellForRowAtIndexPath:indexPath3]);
    MRECTableViewCell *mCell1 = (MRECTableViewCell*)([self.multiAdTableView cellForRowAtIndexPath:indexPath2]);
    MRECTableViewCell *mCell2 = (MRECTableViewCell*)([self.multiAdTableView cellForRowAtIndexPath:indexPath4]);
    [self updateButtonState:bCell1.loadBannerButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID07]? NO:YES];
    [self updateButtonState:bCell1.playBannerButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID07]? YES:NO];
    [self updateButtonState:mCell1.loadMRECButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID05]? NO:YES];
    [self updateButtonState:mCell1.playMRECButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID05]? YES:NO];
    [self updateButtonState:bCell2.loadBannerButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID08]? NO:YES];
    [self updateButtonState:bCell2.playBannerButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID08]? YES:NO];
    [self updateButtonState:mCell2.loadMRECButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID09]? NO:YES];
    [self updateButtonState:mCell2.playMRECButton enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID09]? YES:NO];
}

- (void)updateButtonState:(UIButton *) button enabled:(BOOL)enabled {
    button.enabled = enabled;
    button.alpha = (enabled? 1.0:.5);
}

-(BOOL)shouldAutorotate {
    return YES;
}

-(UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
