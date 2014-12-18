//
//  VXPromotionCell.h
//  VXPromotion
//
//  Created by Graham Lancashire on 18.12.14.
//  Copyright (c) 2014 Swift Management AG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VXPromotionCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIView  *shadowView;
@property (strong, nonatomic) IBOutlet UIImageView  *iconView;
@property (strong, nonatomic) IBOutlet UILabel  *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel  *labelDescription;
@property (strong, nonatomic) IBOutlet UIButton  *buttonPurchase;
@property (strong, nonatomic) IBOutlet UILabel  *labelPrice;

@end

