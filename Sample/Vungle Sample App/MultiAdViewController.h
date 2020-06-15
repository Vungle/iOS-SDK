//
//  MultiAdViewController.h
//  Vungle Sample App
//
//  Created by John Mai on 4/6/20.
//  Copyright © 2020 Jordyn Chuhaloff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VungleSDK/VungleSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiAdViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,VungleSDKDelegate>
@property (weak, nonatomic) IBOutlet UITableView *multiAdTableView;
@property (weak, nonatomic) IBOutlet UIButton *playFullScreen;
@property (weak, nonatomic) IBOutlet UIButton *loadFullScreen;

@end

NS_ASSUME_NONNULL_END
