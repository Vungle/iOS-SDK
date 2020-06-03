//
//  BannerList.h
//  Vungle Sample App
//
//  Created by John Mai on 2/6/20.
//  Copyright © 2020 Jordyn Chuhaloff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VungleSDK/VungleSDK.h>
//NS_ASSUME_NONNULL_BEGIN

@interface BannerList : UIViewController<UITableViewDelegate,UITableViewDataSource,VungleSDKDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

//NS_ASSUME_NONNULL_END
