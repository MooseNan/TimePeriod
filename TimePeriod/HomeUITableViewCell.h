//
//  HomeUITableViewCell.h
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/19.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeUITableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) UIImageView *image;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UIImageView *addressImg;
@end
