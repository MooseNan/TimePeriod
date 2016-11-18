//
//  NearEmpty.m
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/19.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

#import "NearEmpty.h"
#import "Masonry.h"
#import "UIColor+CreateMethod.h"

@interface NearEmpty (){
    UILabel *nearLabel;
}
@end
@implementation NearEmpty
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)initialize {
    self.layer.doubleSided = NO;
    self.backgroundColor = [UIColor whiteColor];
    nearLabel=[[UILabel alloc] initWithFrame:CGRectMake(12, 47/3, 40, 40)];
    nearLabel.text=@"附近";
    nearLabel.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    nearLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    [self addSubview:nearLabel];
    
    self.image = [[UIImageView alloc] init];
    //self.image.backgroundColor = [UIColor blueColor];
  //  self.image.contentMode = UIViewContentModeCenter;
    //self.image.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.image setImage:[UIImage imageNamed:@"home_icon.png"]];
    
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    //self.title.textAlignment = NSTextAlignmentCenter;
    self.title.text=@"前方高能！";
    //self.title.backgroundColor=[UIColor redColor];
    
    self.titleDetail=[[UILabel alloc]init];
    self.titleDetail.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    //self.titleDetail.textAlignment = NSTextAlignmentCenter;
    self.titleDetail.text=@"附近潮流新餐厅正在建设";
    //self.titleDetail.backgroundColor=[UIColor redColor];
    UIView *view=[[UIView alloc]init];
    [self addSubview:view];
    //view.backgroundColor=[UIColor blackColor];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
    }];
    [view addSubview:self.image];
    [view addSubview:self.title];
    [view addSubview:self.titleDetail];
    [_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(80);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.centerY.mas_equalTo(self);
       // make.bottom.equalTo(view).offset(-20);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_image.mas_right).offset(5);
        make.right.equalTo(view).offset(-10);
        make.height.mas_equalTo(20);
        make.top.equalTo(_image.mas_top).offset(0);
        //make.bottom.equalTo(_titleDetail.mas_top).offset(-5);
    }];
    
    [_titleDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_image.mas_right).offset(5);
        make.right.equalTo(view).offset(-10);
        make.top.equalTo(_title.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
        //make.bottom.equalTo(view).offset(-10);
    }];

}
@end
