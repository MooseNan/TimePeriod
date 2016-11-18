//
//  HomeHeaderView.h
//  TimePeriod
//
//  Created by linan on 16/4/24.
//  Copyright (c) 2016年 dhc1256436519. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NearScrollView.h"

@interface HomeHeaderView : UIView
{
    NearScrollView *scrollView;
    
}
-(void)loadData;
@property (nonatomic,strong) NSArray *arrNear;

@end