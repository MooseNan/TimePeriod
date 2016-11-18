//
//  UIColor+Hex.h
//  TimePeriod
//
//  Created by dhc1256436519 on 16/4/17.
//  Copyright © 2016年 dhc1256436519. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (UIColor*) colorWithHex:(NSInteger)hexValue;
+ (NSString *) hexFromUIColor: (UIColor*) color;
@end
