//
//  UIColor+CreateMethod.m
//  WishMark
//
//  Created by EvanZ on 13-11-1.
//  Copyright (c) 2013年 EvanZ. All rights reserved.
//

#import "UIColor+CreateMethod.h"

@implementation UIColor (CreateMethod)

+ (UIColor*)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}

+ (UIColor*)colorWithHex:(NSString*)hex alpha:(CGFloat)alpha {
    
    assert(7 == [hex length]);
    assert('#' == [hex characterAtIndex:0]);
    
    NSString *redHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(1, 2)]];
    NSString *greenHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(3, 2)]];
    NSString *blueHex = [NSString stringWithFormat:@"0x%@", [hex substringWithRange:NSMakeRange(5, 2)]];
    
    
    unsigned redInt = 0;
    NSScanner *rScanner = [NSScanner scannerWithString:redHex];
    [rScanner scanHexInt:&redInt];
    
    unsigned greenInt = 0;
    NSScanner *gScanner = [NSScanner scannerWithString:greenHex];
    [gScanner scanHexInt:&greenInt];
    
    unsigned blueInt = 0;
    NSScanner *bScanner = [NSScanner scannerWithString:blueHex];
    [bScanner scanHexInt:&blueInt];
    
    return [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];
}

+(UIColor *)tintColorWithColor:(UIColor *)color{
    CGColorRef colorRef = color.CGColor;
    const CGFloat *oldComponentColors = CGColorGetComponents(colorRef);
    int numberOfComponents = CGColorGetNumberOfComponents(colorRef);
    CGFloat newComponentColors[numberOfComponents];
    int i = numberOfComponents - 1;
    newComponentColors[i] = oldComponentColors[i]; // alpha
    CGFloat temp;
    while (--i >= 0) {
        CGFloat oldColor = oldComponentColors[i] * 255;
        temp = -0.0016 * powf(oldColor, 2);
        temp += (1.2686 * oldColor + 33.97);
        newComponentColors[i] = temp / 255.0;
    }
    CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(colorRef), newComponentColors);
    UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
    CGColorRelease(newCGColor);
    
    return newColor;
}



@end
