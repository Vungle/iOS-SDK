//
//  MultiAdViewController.m
//  Vungle Sample App
//
//  Created by John Mai on 4/6/20.
//  Copyright © 2020 Jordyn Chuhaloff. All rights reserved.
//

#import "MultiAdViewController.h"
#import "Constants.h"
#import "MultiAdViewTableViewCell.h"

@interface MultiAdViewController () {
        CGFloat screenHeight;
        CGFloat screenWidth;
}
@property (strong, nonatomic) IBOutlet UIView *view;

@property (nonatomic, strong) VungleSDK *sdk;
@property MultiAdViewTableViewCell *bannerCell;
@property MultiAdViewTableViewCell *mrecCell;
@property MultiAdViewTableViewCell *bannerCell2;
@property MultiAdViewTableViewCell *mrecCell2;
@property (nonatomic, assign, getter=isPlayingBanner) BOOL playingBanner;
@end

@implementation MultiAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startVungle];
    [self.view addSubview:self.multiAdTableView];
    self.multiAdTableView.delegate = self;
    self.multiAdTableView.dataSource = self;
    //CCPA status accepted
    
    [self.sdk updateCCPAStatus:VungleCCPAAccepted];
    //CCPA status denied
//    [self.sdk updateCCPAStatus:VungleCCPADenied];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {
    [self.multiAdTableView reloadData];
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

- (void)startVungle {
    NSLog(@"Starting the VungleSDK in banner");
    self.sdk = [VungleSDK sharedSDK];
    [self.sdk setDelegate:self];
    [self.sdk setLoggingEnabled:YES];
    NSError *error = nil;
    NSDictionary *options = @{VungleSDKInitOptionKeyPriorityPlacementID:kVungleTestPlacementID08,VungleSDKInitOptionKeyPriorityPlacementAdSize:[NSNumber numberWithInt:VungleAdSizeBanner]};
    if(![self.sdk startWithAppId:kVungleTestAppID options:options error:&error]) {
        NSLog(@"Error while starting VungleSDK %@",[error localizedDescription]);
//        [self updateButtonState:self.sdkInitButton enabled:YES];
        return;
    }
//    if(![self.sdk startWithAppId:kVungleTestAppID error:&error]) {
//        NSLog(@"Error while starting VungleSDK %@", [error localizedDescription]);
//        return;
//    }
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
    UITableViewCell *cell;
    if (indexPath.row == 0) {
         cell = [self.multiAdTableView dequeueReusableCellWithIdentifier:@"bannerCell" forIndexPath:indexPath];
         CGFloat cellWidth = cell.contentView.frame.size.width;
        NSLog(@"The cellWidth is %f",cellWidth);
         self.bannerCell = (MultiAdViewTableViewCell*) cell;
        self.bannerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bannerCell.adView.frame = CGRectMake((cellWidth - 320)/2.0, 121, 320.0, 50.0);
        NSLog(@"The adWidth is %f",self.bannerCell.adView.frame.size.width);
        NSLog(@"The adHeight is %f",self.bannerCell.adView.frame.size.height);
        [self.bannerCell.loadButton01 addTarget:self action:@selector(loadVungleBannerAd) forControlEvents:UIControlEventTouchUpInside];
        [self.bannerCell.playButton01 addTarget:self action:@selector(playVungleBannerAd) forControlEvents:UIControlEventTouchUpInside];
        [self.bannerCell.dismissButton01 addTarget:self action:@selector(dismissVungleBanner) forControlEvents:UIControlEventTouchUpInside];
    } else if (indexPath.row == 1) {
        cell = [self.multiAdTableView dequeueReusableCellWithIdentifier:@"mrecCell" forIndexPath:indexPath];
         CGFloat cellWidth = cell.contentView.frame.size.width;
         self.mrecCell = (MultiAdViewTableViewCell*) cell;
        self.mrecCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.mrecCell.mrecView.frame = CGRectMake((cellWidth - 320)/2.0, 118, 300.0, 250.0);
        NSLog(@"The mrecWidth is %f",self.mrecCell.mrecView.frame.size.width);
        NSLog(@"The mrecHeight is %f",self.mrecCell.mrecView.frame.size.height);
        [self.mrecCell.loadButton02 addTarget:self action:@selector(loadVungleMrecAd) forControlEvents:UIControlEventTouchUpInside];
        [self.mrecCell.playButton02 addTarget:self action:@selector(playVungleMrecAd) forControlEvents:UIControlEventTouchUpInside];
        [self.mrecCell.dismissButton02 addTarget:self action:@selector(dismissVungleMrec) forControlEvents:UIControlEventTouchUpInside];
    } else if (indexPath.row == 2) {
        cell = [self.multiAdTableView dequeueReusableCellWithIdentifier:@"bannerCell2" forIndexPath:indexPath];
         CGFloat cellWidth = cell.contentView.frame.size.width;
        NSLog(@"The cellWidth is %f",cellWidth);
         self.bannerCell2 = (MultiAdViewTableViewCell*) cell;
        self.bannerCell2.selectionStyle = UITableViewCellSelectionStyleNone;
        self.bannerCell2.adView.frame = CGRectMake((cellWidth - 320)/2.0, 121, 320.0, 50.0);
        NSLog(@"The adWidth is %f",self.bannerCell2.adView.frame.size.width);
        NSLog(@"The adHeight is %f",self.bannerCell2.adView.frame.size.height);
        [self.bannerCell2.loadButton01 addTarget:self action:@selector(loadVungleBannerAdBottom) forControlEvents:UIControlEventTouchUpInside];
        [self.bannerCell2.playButton01 addTarget:self action:@selector(playVungleBannerAdBottom) forControlEvents:UIControlEventTouchUpInside];
        [self.bannerCell2.dismissButton01 addTarget:self action:@selector(dismissVungleBannerBottom) forControlEvents:UIControlEventTouchUpInside];
    } else if (indexPath.row == 3) {
        cell = [self.multiAdTableView dequeueReusableCellWithIdentifier:@"mrecCell2" forIndexPath:indexPath];
         CGFloat cellWidth = cell.contentView.frame.size.width;
         self.mrecCell2 = (MultiAdViewTableViewCell*) cell;
        self.mrecCell2.selectionStyle = UITableViewCellSelectionStyleNone;
        self.mrecCell2.mrecView.frame = CGRectMake((cellWidth - 320)/2.0, 118, 300.0, 250.0);
        NSLog(@"The mrecWidth is %f",self.mrecCell2.mrecView.frame.size.width);
        NSLog(@"The mrecHeight is %f",self.mrecCell2.mrecView.frame.size.height);
        [self.mrecCell2.loadButton02 addTarget:self action:@selector(loadVungleMrecAdBottom) forControlEvents:UIControlEventTouchUpInside];
        [self.mrecCell2.playButton02 addTarget:self action:@selector(playVungleMrecAdBottom) forControlEvents:UIControlEventTouchUpInside];
        [self.mrecCell2.dismissButton02 addTarget:self action:@selector(dismissVungleMrecBottom) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - VungleSDKDelegate Methods
- (void)vungleSDKDidInitialize {
    NSLog(@"-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY");
    [self updateButtons];
}
-(void)vungleWillShowAdForPlacementID:(NSString *)placementID {
    NSLog(@"VungleWillShowAdForPlacement is called %@", placementID);
}
-(void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(NSString *)placementID error:(NSError *)error {
    if (isAdPlayable) {
        NSLog(@"vungleAdPlayabilityUpdate is available to be played for %@",placementID);
    }
    if ([placementID isEqualToString:kVungleTestPlacementID05]) {
        NSLog(@"vungleAdPlayability for 05");
        [self updateButtonState:self.mrecCell.playButton02 enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID07]) {
        NSLog(@"vungleAdPlayability for 07");
        [self updateButtonState:self.bannerCell.playButton01 enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID08]) {
        NSLog(@"vungleAdPlayability for 08");
        [self updateButtonState:self.bannerCell2.playButton01 enabled:isAdPlayable];
    } else if ([placementID isEqualToString:kVungleTestPlacementID09]) {
        NSLog(@"vungleAdPlayability for 09");
        [self updateButtonState:self.mrecCell2.playButton02 enabled:isAdPlayable];
    }
}
-(void)vungleWillCloseAdForPlacementID:(nonnull NSString *)placementID {
    NSLog(@"vungleWillCloseAdForPlacementID on %@",placementID);
}
- (void)vungleDidCloseAdForPlacementID:(nonnull NSString *)placementID {
    NSLog(@"vungleDidCloseAdForPlacementID");
}
- (void)vungleTrackClickForPlacementID:(nullable NSString *)placementID {
    NSLog(@"vungleTrackClickForPlacementID");
}
- (void)vungleWillLeaveApplicationForPlacementID:(nullable NSString *)placementID {
    NSLog(@"vungleWillLeaveApplicationForPlacementID");
}
#pragma mark - AdTableViewControllerDelegate
- (void)presentedViewControllerWillDismiss:(NSDictionary *)selectedPlacement {
    
}

#pragma mark - Helper Methods
-(void)loadVungleBannerAd {
        NSLog(@"ad view dimension is %@",self.bannerCell.adView);
    NSLog(@"Attempting to load banner ad on MultiAdViewController");
    NSError *error;
    if (![self.sdk loadPlacementWithID:kVungleTestPlacementID07 withSize:VungleAdSizeBanner error:&error]) {
        [self updateButtonState:self.bannerCell.loadButton01 enabled:YES];
        if (error) {
            NSLog(@"Error encountered trying to load banner ad %@",error);
        }
    } else {
        [self updateButtonState:self.bannerCell.loadButton01 enabled:NO];
    }
}
-(void)loadVungleMrecAd {
    NSLog(@"Pressing the load MREC button");
    NSError *error;
    if (![self.sdk loadPlacementWithID:kVungleTestPlacementID05 error:&error]) {
        [self updateButtonState:self.bannerCell.loadButton02 enabled:YES];
        if (error) {
            NSLog(@"Error encountered trying to load MRECad %@",error);
        }
    } else {
        [self updateButtonState:self.mrecCell.loadButton02 enabled:NO];
    }
}
-(void)loadVungleMrecAdBottom {
    NSLog(@"Pressing the load MREC button");
    NSError *error;
    if (![self.sdk loadPlacementWithID:kVungleTestPlacementID09 error:&error]) {
        [self updateButtonState:self.bannerCell.loadButton02 enabled:YES];
        if (error) {
            NSLog(@"Error encountered trying to load MRECad %@",error);
        }
    } else {
        [self updateButtonState:self.mrecCell2.loadButton02 enabled:NO];
    }
}
-(void)playVungleBannerAd {
    NSLog(@"ad view dimension is %@",self.bannerCell.adView);
     NSLog(@"Pressing the play banner button");
    NSError *error;
    if(![self.sdk addAdViewToView:self.bannerCell.adView withOptions:nil placementID:kVungleTestPlacementID07 error:&error]) {
        NSLog(@"The play error message is %@",error);
    }
    
}
-(void)playVungleMrecAd {
    NSError *error;
    if (![self.sdk addAdViewToView:self.mrecCell.mrecView withOptions:nil placementID:kVungleTestPlacementID05 error:&error]) {
        if (error) {
            NSLog(@"Error encountered trying to load ad %@",error);
        }
    }
    NSLog(@"mrec view dimension is %f",self.mrecCell.mrecView.bounds.size.width);
}
-(void)playVungleMrecAdBottom {
    NSError *error;
    if (![self.sdk addAdViewToView:self.mrecCell2.mrecView withOptions:nil placementID:kVungleTestPlacementID09 error:&error]) {
        if (error) {
            NSLog(@"Error encountered trying to load ad %@",error);
        }
    }
    NSLog(@"mrec view dimension is %f",self.mrecCell.mrecView.bounds.size.width);
}
-(void)loadVungleBannerAdBottom {
    NSLog(@"Attempting to load the bottom banner");
    NSError *error;
    if(![self.sdk loadPlacementWithID:kVungleTestPlacementID08 withSize:VungleAdSizeBanner error:&error]) {
        [self updateButtonState:self.bannerCell2.loadButton01 enabled:YES];
        if(error) {
            NSLog(@"Error encountered when attempting to load the bottom banner %@",error);
        }
    } else {
        [self updateButtonState:self.bannerCell2.loadButton01 enabled:NO];
    }
}
-(void)playVungleBannerAdBottom {
    NSError *error;
    if (![self.sdk addAdViewToView:self.bannerCell2.adView withOptions:nil placementID:kVungleTestPlacementID08 error:&error]) {
        if (error) {
            NSLog(@"Error encountered trying to load ad %@",error);
        }
    }
    NSLog(@"mrec view dimension is %f",self.bannerCell2.adView.bounds.size.width);
}
-(void)dismissVungleBanner {
    [self.sdk finishDisplayingAd:kVungleTestPlacementID07];
}
-(void)dismissVungleMrec {
    [self.sdk finishDisplayingAd:kVungleTestPlacementID05];
}
-(void)dismissVungleBannerBottom {
    [self.sdk finishDisplayingAd:kVungleTestPlacementID08];
}
-(void)dismissVungleMrecBottom {
    [self.sdk finishDisplayingAd:kVungleTestPlacementID09];
}
//- (void)dismissButtonAction:(UIButton *)sender
//{
//    [self performSelector:@selector(dismissVungleBanner:) withObject:k];
//}
- (void)updateButtons {
    [self updateButtonState:self.bannerCell.loadButton01 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID07]? NO:YES];
    [self updateButtonState:self.bannerCell.playButton01 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID07]? YES:NO];
    [self updateButtonState:self.mrecCell.loadButton02 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID05]? NO:YES];
    [self updateButtonState:self.mrecCell.playButton02 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID05]? YES:NO];
    [self updateButtonState:self.bannerCell2.loadButton01 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID08]? NO:YES];
    [self updateButtonState:self.bannerCell2.playButton01 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID08]? YES:NO];
    [self updateButtonState:self.mrecCell2.loadButton02 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID09]? NO:YES];
    [self updateButtonState:self.mrecCell2.playButton02 enabled:[self.sdk isAdCachedForPlacementID:kVungleTestPlacementID09]? YES:NO];
}

- (void)updateButtonState:(UIButton *) button enabled:(BOOL)enabled {
    button.enabled = enabled;
    button.alpha = (enabled? 1.0:.5);
}
@end
