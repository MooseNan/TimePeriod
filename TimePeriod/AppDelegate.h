//
//  AppDelegate.h
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/16.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "HomeCenterViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件


@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic,strong) HomeCenterViewController *centerView;
@end

