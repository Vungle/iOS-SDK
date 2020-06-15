//
//  BannerTableViewCell.h
//  Vungle Sample App
//
//  Created by John Mai on 6/11/20.
//  Copyright © 2020 Jordyn Chuhaloff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *loadBannerButton;
@property (weak, nonatomic) IBOutlet UIButton *playBannerButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissBannerButton;
@property (retain, nonatomic) IBOutlet UIView *bannerView;

@end

NS_ASSUME_NONNULL_END
