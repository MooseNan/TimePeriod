//
//  MenuTableViewCell.m
//  TimePeriod
//
//  Created by linan on 16/4/21.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame =CGRectMake(10,15,30,30);
    self.imageView.contentMode =UIViewContentModeScaleAspectFit;
    self.textLabel.frame = CGRectMake(50, 15, self.contentView.frame.size.width-50, 30);
}

@end
