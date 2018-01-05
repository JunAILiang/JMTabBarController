//
//  UIColor+JM.m
//  JMTabBarController
//
//  Created by JM on 2017/12/27.
//  Copyright © 2017年 JM. All rights reserved.
//

#import "UIColor+JM.h"

@implementation UIColor (JM)


+ (UIColor *)colorWithHexString:(NSString *)color {
    return [self colorWithHexString:color Alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    //判断前缀
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    //从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R G B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

@end
