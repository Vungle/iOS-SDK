//
//  MRECTableViewCell.h
//  Vungle Sample App
//
//  Created by John Mai on 6/11/20.
//  Copyright © 2020 Jordyn Chuhaloff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MRECTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *loadMRECButton;
@property (weak, nonatomic) IBOutlet UIButton *playMRECButton;
@property (weak, nonatomic) IBOutlet UIButton *dismissMRECButton;
@property (weak, nonatomic) IBOutlet UILabel *mrecLabel;
@property (retain, nonatomic) IBOutlet UIView *mrecView;

@end

NS_ASSUME_NONNULL_END
