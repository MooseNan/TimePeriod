//
//  HomeViewController.m
//  侧滑菜单
//
//  Created by apple on 14-5-27.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeMenuViewController.h"
#import "HomeCenterViewController.h"
#import "UIView+MJ.h"
#import "UIColor+CreateMethod.h"

#define HomeMenuWidth 250

@interface HomeViewController ()
{
    HomeCenterViewController *centerVc;
    BOOL isOpened;
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden=  NO;
   // [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHex:@"#864602" alpha:1.0]];
    UIColor * color = [UIColor whiteColor];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //大功告成
  //  self.navigationController.navigationBar.titleTextAttributes = dict;
   // [self setTitle:@"馋"];
    isOpened=false;
    // 1.初始化子控制器
    // 1.1.左侧菜单
    HomeMenuViewController *menuVc = [[HomeMenuViewController alloc] init];
    menuVc.view.width = HomeMenuWidth;
    menuVc.view.y = 0;
    menuVc.view.height = self.view.frame.size.height;
    [self.view addSubview:menuVc.view];
    [self addChildViewController:menuVc];
    
    // 1.2.中间内容
    centerVc = [[HomeCenterViewController alloc] init];
    centerVc.view.frame = self.view.frame;
    [self.view addSubview:centerVc.view];
    [self addChildViewController:centerVc];
   
    // 2.监听手势
    [centerVc.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragCenterView:)]];
    [centerVc.btnSlide addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationItem setHidesBackButton:YES];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"馋嘴"]forBarMetrics:UIBarMetricsDefault];

}

- (void)click
{
    if (isOpened) {
        [UIView animateWithDuration:0.5 animations:^{
            centerVc.view.transform =  CGAffineTransformIdentity;
        }];
        isOpened=false;
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            centerVc.view.transform =  CGAffineTransformMakeTranslation(HomeMenuWidth, 0);
        }];
        isOpened=true;
    }
    
}
// transform == 150
// １
// 用x来判断，用transform来控制
- (void)dragCenterView:(UIPanGestureRecognizer *)pan
{
    CGPoint point = [pan translationInView:pan.view];
    
    // 结束拖拽
    if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded) {
        if (pan.view.x >= HomeMenuWidth * 0.5) { // 往右边至少走动了75
            [UIView animateWithDuration:0.5 animations:^{
                pan.view.transform = CGAffineTransformMakeTranslation(HomeMenuWidth, 0);
            }];
        } else { // 走动距离的没有达到75
            [UIView animateWithDuration:0.5 animations:^{
                pan.view.transform = CGAffineTransformIdentity;
            }];
        }
    } else { // 正在拖拽中
        pan.view.transform = CGAffineTransformTranslate(pan.view.transform, point.x, 0);
        [pan setTranslation:CGPointZero inView:pan.view];
        
        if (pan.view.x >= HomeMenuWidth) {
            pan.view.transform = CGAffineTransformMakeTranslation(HomeMenuWidth, 0);
        } else if (pan.view.x <= 0) {
            pan.view.transform = CGAffineTransformIdentity;
        }
    }
}

@end
