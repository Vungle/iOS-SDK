//
//  DisplayTableViewCell.h
//  Vungle Sample App
//
//  Created by John Mai on 2/26/20.
//  Copyright © 2020 Jordyn Chuhaloff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisplayTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *adView;
@property (strong, nonatomic) IBOutlet UIView *mrecView;

@end

NS_ASSUME_NONNULL_END
