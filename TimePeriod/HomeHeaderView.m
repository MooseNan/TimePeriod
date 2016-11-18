//
//  HomeHeaderView.m
//  TimePeriod
//
//  Created by linan on 16/4/24.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import "HomeHeaderView.h"
#import "NearScrollView.h"
#import "UIColor+CreateMethod.h"
#import "GlobalConstant.h"
#import "NearShopModel.h"
#import "AppDelegate.h"
#define defaultWidth  (SCREEN_WIDTH/3)
@class HomeCenterViewController;
@implementation HomeHeaderView
-(id)initWithFrame:(CGRect)frame
{
    //_arrNear=arrNear;1
    self =  [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled =YES;
    UILabel *nearLabel=[[UILabel alloc] initWithFrame:CGRectMake(12, 16, 40, 40)];
    nearLabel.text=@"附近";
    nearLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    nearLabel.textColor = [UIColor colorWithHex:@"#864602" alpha:1.0];
    [self addSubview:nearLabel];
   
    scrollView = [[NearScrollView alloc]initWithFrame:CGRectMake(0, 57, self.frame.size.width, 93)];
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectView:)]];
    scrollView.contentSize = CGSizeMake(self.frame.size.width, 0);
    [self addSubview:scrollView];
   
    return self;
}
-(void)selectView:(UITapGestureRecognizer*)ges
{
    CGPoint point = [ges locationInView:ges.view];
    int index = point.x/defaultWidth;
    
    NSError *error;
    NearShopModel *model = [[NearShopModel alloc]initWithDictionary:[self.arrNear objectAtIndex:index] error:&error];
    NSNumber *num = [NSNumber numberWithInteger:model.rticleaID];
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    [appdelegate.centerView getDetailInfo:num];
}

-(void)loadData
{
     scrollView.arrNear = self.arrNear;
     [scrollView loadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
