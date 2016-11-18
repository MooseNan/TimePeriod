//
//  DiscountView.m
//  TimePeriod
//
//  Created by linan on 16/4/19.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "DiscountView.h"
#import "Masonry.h"
#import "UIColor+CreateMethod.h"

@interface DiscountView ()
{

}
@end
@implementation DiscountView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame
{
   self =  [super initWithFrame:frame];
    _discountBG = [UIImageView new];
    _title = [UILabel new];
    _discountType = [UILabel new];
    _validity = [UILabel new];
    _getBtn = [UIButton new];
    _usingTime = [UILabel new];
    _useType = [UILabel new];
    _money = [UILabel new];
    [self addSubview:_discountBG];
    [self addSubview:_discountType];
    [self addSubview:_money];
    [self addSubview:_title];
    [self addSubview:_getBtn];
    [self addSubview:_usingTime];
    [self addSubview:_useType];
    [self addSubview:_validity];
    [_discountBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.left.equalTo(self).with.offset(22);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(42);
    }];
    _discountBG.image= [UIImage imageNamed:@"detail_gift.png"];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_discountBG.mas_left).offset(18);
        make.top.equalTo(_discountBG.mas_top).offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(22);
    }];
    [_discountType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_discountBG.mas_right).offset(-10);
        make.top.equalTo(_discountBG.mas_top).offset(10);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(15);
    }];
    [_discountType  setFont:[UIFont fontWithName:nil size:12]];
    [_getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(0);
        make.right.equalTo(self).with.offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(50);
    }];
    [_getBtn setTitleColor:[UIColor colorWithHex:@"#864602" alpha:1.0] forState:UIControlStateNormal];
   
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(_discountBG.mas_right).with.offset(13);
        make.right.equalTo(_getBtn.mas_left).with.offset(0);
        make.height.mas_equalTo(14);
    }];
    _title.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    [_validity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_discountBG.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(22);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(14);
    }];
    [_validity setFont:[UIFont fontWithName:nil size:14]];
    _validity.textColor= [UIColor colorWithHex:@"#864602" alpha:1.0];
    [_usingTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_validity.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(22);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(14);
    }];
    [_usingTime setFont:[UIFont fontWithName:nil size:14]];
    _usingTime.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
   //_usingTime.text=@"领取";
    [_useType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_usingTime.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(22);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(14);
    }];
    [_useType setFont:[UIFont fontWithName:nil size:14]];
    _useType.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
//_useType.text=@"SASAS";
    
    return  self;
}
@end
