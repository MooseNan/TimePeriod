//
//  DiscountCell.m
//  TimePeriod
//
//  Created by linan on 16/4/21.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "DiscountCell.h"
#import "UIColor+CreateMethod.h"
#import "Masonry.h"
@implementation DiscountCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubviews];
    }
    return self;
}
- (void)setUpSubviews
{
    self.layer.doubleSided = NO;
    
    
    self.discountBG = [[UIImageView alloc] init];
    self.discountBG.image = [UIImage imageNamed:@"detail_gift.png"];
  
    self.discountMoney = [[UILabel alloc] init];
    self.discountMoney.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    self.discountMoney.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    //self.title.textAlignment = NSTextAlignmentCenter;
    ///self.title.text=@"ok雷";

    self.discountType=[[UILabel alloc]init];
    self.discountType.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    self.discountType.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    
    self.discountTitle=[[UILabel alloc]init];
    self.discountTitle.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    self.discountTitle.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    
    self.discountTime=[[UILabel alloc]init];
    self.discountTime.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    self.discountTime.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    //self.address.textAlignment = NSTextAlignmentCenter;
    //  self.address.text=@"ok雷";
    [self.contentView addSubview:self.discountBG];
    [self.contentView addSubview:self.discountMoney];
    [self.contentView addSubview:self.discountType];
    [self.contentView addSubview:self.discountTitle];
    [self.contentView addSubview:self.discountTime];
    [_discountBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(27);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(42);
    }];
    
    [_discountMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_discountBG.mas_left).offset(20);
        make.top.equalTo(_discountBG.mas_top).offset(10);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(22);
    }];
    [_discountType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_discountBG.mas_right).offset(-5);
        make.top.equalTo(_discountBG.mas_top).offset(15);
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(15);
    }];
    [_discountTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_discountBG.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(7);
        make.width.mas_equalTo(self.contentView.frame.size.width-115);
        make.height.mas_equalTo(10);
    }];
    [_discountTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_discountBG.mas_right).offset(10);
        make.top.equalTo(_discountTitle.mas_bottom).offset(13);
        make.width.mas_equalTo(self.contentView.frame.size.width-115);
        make.height.mas_equalTo(10);
    }];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"DiscountCell";
    DiscountCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell=[[DiscountCell
               alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}
@end
