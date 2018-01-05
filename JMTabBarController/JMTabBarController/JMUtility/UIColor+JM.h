//
//  UIColor+JM.h
//  JMTabBarController
//
//  Created by JM on 2017/12/27.
//  Copyright © 2017年 JM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JM)

//16进制颜色转换
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (UIColor *)colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha;

@end
