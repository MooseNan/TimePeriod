//
//  HomeCenterViewController.h
//  侧滑菜单
//
//  Created by apple on 14-5-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeaderView.h"
@interface HomeCenterViewController : UIViewController
{
    
}
-(void)getDetailInfo:(NSNumber *)articleID;
-(void)nearShopInfo;
-(void)getMapInfo;
@property (strong, nonatomic) UIButton* btnSlide;
@end
