//
//  UIView+Toast.h
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/23.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

//
//  UIView+Toast.m
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/23.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//



//Toast+UIView.h
//Toast




#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Toast)

// each makeToast method creates a view and displays it as toast
- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position;
- (void)makeToast:(NSString *)message withPosition:(CGPoint)position;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position image:(UIImage *)image;

// displays toast with an activity spinner
- (void)makeToastActivity;
- (void)makeToastActivity:(id)position;
- (void)hideToastActivity;

// the showToast methods display any view as toast
- (void)showToast:(UIView *)toast;
- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point;
- (void)showToastWithPoint:(UIView *)toast duration:(CGFloat)interval position:(CGPoint)point;

@end
