//
//  MultiAdViewTableViewCell.h
//  Vungle Sample App
//
//  Created by John Mai on 4/6/20.
//  Copyright © 2020 Jordyn Chuhaloff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiAdViewController.h"
#import <VungleSDK/VungleSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiAdViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UIView *mrecView;
@property (weak, nonatomic) IBOutlet UIButton *loadButton01;
@property (weak, nonatomic) IBOutlet UIButton *playButton01;
@property (weak, nonatomic) IBOutlet UIButton *loadButton02;
@property (weak, nonatomic) IBOutlet UIButton *playButton02;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton01;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton02;

@end

NS_ASSUME_NONNULL_END
