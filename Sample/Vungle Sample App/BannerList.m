//
//  BannerList.m
//  Vungle Sample App
//
//  Created by John Mai on 2/6/20.
//  Copyright © 2020 Jordyn Chuhaloff. All rights reserved.
//

#import "BannerList.h"
#import "Constants.h"
#import "DisplayTableViewCell.h"

@interface BannerList () {
    CGFloat screenHeight;
    CGFloat screenWidth;
}
@property (strong, nonatomic) IBOutlet UIView *view;
@property const int totalSize;
@property const int AD_PER_ITEM;
@property NSMutableArray* adArr;
@property (nonatomic, strong) VungleSDK *sdk;
@end

@implementation BannerList
- (void)viewDidLoad {
    [super viewDidLoad];
    self.adArr = [[NSMutableArray alloc] init];
    self.totalSize = 40;
    self.AD_PER_ITEM = 4;
    [self startVungle];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}
-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = 50.0;
    if (indexPath.row == (self.totalSize - 4)) {
        height = 250.0;
    }
    return height;
}
-(UITableViewCell *)tableView:(UITableView*) tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSError *error = nil;
    UITableViewCell *cell;
        if ((indexPath.row == 0) || (indexPath.row == (self.totalSize / 2)) || (indexPath.row == 1)) {
           
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"adCell" forIndexPath:indexPath];
                    CGFloat cellWidth = cell.contentView.frame.size.width;
            DisplayTableViewCell *bannerCell = (DisplayTableViewCell*) cell;
            bannerCell.adView.frame = CGRectMake((cellWidth - 320)/2.0, 10, 320.0, 50.0);
            [self displayBannerAd:kVungleTestPlacementID07];
            [self.sdk addAdViewToView:bannerCell.adView withOptions:@{} placementID:kVungleTestPlacementID07 error:&error];
             NSLog(@"The ID is: %@",kVungleTestPlacementID07);
                   
                   
        }
//        else if (indexPath.row == 3) {
//            cell = [self.tableView dequeueReusableCellWithIdentifier:@"adCell" forIndexPath:indexPath];
//                    CGFloat cellWidth = cell.contentView.frame.size.width;
//            DisplayTableViewCell *bannerCell = (DisplayTableViewCell*) cell;
//            bannerCell.adView.frame = CGRectMake((cellWidth - 320)/2.0, 10, 320.0, 50.0);
//            [self displayBannerAd:kVungleTestPlacementID07];
//            [self.sdk addAdViewToView:bannerCell.adView withOptions:@{} placementID:kVungleTestPlacementID08 error:&error];
//            NSLog(@"The ID is: %@",kVungleTestPlacementID06);
//        }
        else if (indexPath.row == (self.totalSize - 4)) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"mrecCell" forIndexPath:indexPath];
                    CGFloat cellWidth = cell.contentView.frame.size.width;
            DisplayTableViewCell *bannerCell = (DisplayTableViewCell*) cell;
            
            bannerCell.mrecView.frame = CGRectMake((cellWidth - 320)/2.0, 10, 300.0, 250.0);
            if (![self.sdk loadPlacementWithID:kVungleTestPlacementID05 error:&error]) {
                NSLog(@"Failed to load MREC");
            }
            [self.sdk addAdViewToView:bannerCell.mrecView withOptions:nil placementID:kVungleTestPlacementID05 error:&error];
            NSLog(@"The ID is %s",kVungleTestPlacementID05);
            
        }
        else {
            NSLog(@"It will load a picture ad");
            cell = [self.tableView dequeueReusableCellWithIdentifier:@"displayCell" forIndexPath:indexPath];
            cell.imageView.image = [UIImage imageNamed:@"vungle_logo_aqua_mango_banner"];
        }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.totalSize;
}

- (void)startVungle {
    NSLog(@"Starting the VungleSDK in banner");
    self.sdk = [VungleSDK sharedSDK];
    [self.sdk setDelegate:self];
    [self.sdk setLoggingEnabled:YES];
    NSError *error = nil;
    if(![self.sdk startWithAppId:kVungleTestAppID error:&error]) {
        NSLog(@"Error while starting VungleSDK %@", [error localizedDescription]);
        return;
    }
    NSLog(@"Attempting to load banner ad in startVungle");
}

-(void) displayBannerAd: (NSString *)placementId {
    NSError* error = nil;
    NSLog(@"Attempting to load banner ad");
    if ([self.sdk loadPlacementWithID:placementId withSize:VungleAdSizeBanner error:&error]) {
        NSLog(@"Playing the banner ad");
    }
    
}

#pragma mark - VungleSDKDelegate Methods
- (void)vungleSDKDidInitialize {
    NSLog(@"-->> Delegate Callback: vungleSDKDidInitialize - SDK initialized SUCCESSFULLY");
//    [self updateButtons];
}
-(void)vungleWillShowAdForPlacementID:(NSString *)placementID {
    NSLog(@"VungleWillShowAdForPlacement is called");
}
-(void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(NSString *)placementID error:(NSError *)error {
    if (isAdPlayable) {
        NSLog(@"vungleAdPlayabilityUpdate is available to be played");
    }
    
}

#pragma mark - AdTableViewControllerDelegate
- (void)presentedViewControllerWillDismiss:(NSDictionary *)selectedPlacement {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
