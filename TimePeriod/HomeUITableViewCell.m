//
//  HomeUITableViewCell.m
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/19.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

#import "HomeUITableViewCell.h"
#import "Masonry.h"
#import "UIColor+CreateMethod.h"
@implementation HomeUITableViewCell
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
    
    
    self.image = [[UIImageView alloc] init];
    self.image.backgroundColor = [UIColor clearColor];
    self.addressImg = [[UIImageView alloc]init];
    self.addressImg.image = [UIImage imageNamed:@"detail_position.png"];
    //self.image.contentMode = UIViewContentModeCenter;
    //self.image.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //[self.image setImage:[UIImage imageNamed:@"ok雷"]];
    
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont fontWithName:@"Helvetica Neue" size:16];
    self.title.textColor = [UIColor colorWithHex:@"#4b2700" alpha:1.0];
    //self.title.textAlignment = NSTextAlignmentCenter;
    ///self.title.text=@"ok雷";
    
    self.address=[[UILabel alloc]init];
    self.address.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    self.address.textColor = [UIColor colorWithHex:@"#9b7d5d" alpha:1.0];
    //self.address.textAlignment = NSTextAlignmentCenter;
  //  self.address.text=@"ok雷";
    [self.contentView addSubview:self.image];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.address];
    [self.contentView addSubview:self.addressImg];
  
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(390);
        make.height.mas_equalTo(183);
    }];
    _image.contentMode = UIViewContentModeScaleAspectFill;
    _image.clipsToBounds =YES;

    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(_image.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    [_addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(_title.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(16);
    }];
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addressImg.mas_right).offset(3);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(_title.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];

}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"HomeUITableViewCell";
    HomeUITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell=[[HomeUITableViewCell
               alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}
@end
