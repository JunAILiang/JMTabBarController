//
//  JMBadgeValue.h
//  JMTabBarController
//
//  Created by JM on 2018/1/2.
//  Copyright © 2018年 JM. All rights reserved.
//
/*
 .----------------. .----------------.
 | .--------------. | .--------------. |
 | |     _____    | | | ____    ____ | |
 | |    |_   _|   | | ||_   \  /   _|| |
 | |      | |     | | |  |   \/   |  | |
 | |   _  | |     | | |  | |\  /| |  | |
 | |  | |_' |     | | | _| |_\/_| |_ | |
 | |  `.___.'     | | ||_____||_____|| |
 | |              | | |              | |
 | '--------------' | '--------------' |
 '----------------' '----------------'
 github: https://github.com/JunAILiang
 blog: https://www.ljmvip.cn
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JMBadgeValueType) {
    JMBadgeValueTypePoint, //点
    JMBadgeValueTypeNew, //new
    JMBadgeValueTypeNumber, //number
};

@interface JMBadgeValue : UIView

/** badgeL */
@property (nonatomic, strong) UILabel *badgeL;

/** type */
@property (nonatomic, assign) JMBadgeValueType type;

@end
