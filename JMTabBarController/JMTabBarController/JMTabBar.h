//
//  JMTabBar.h
//  JMTabBarController
//
//  Created by JM on 2017/12/27.
//  Copyright © 2017年 JM. All rights reserved.
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
#import "JMConfig.h"

@class JMTabBar;
@protocol JMTabBarDelegate <NSObject>

- (void)tabBar:(JMTabBar *)tabBar didSelectIndex:(NSInteger)selectIndex;

@end

@interface JMTabBar : UITabBar

- (instancetype)initWithFrame:(CGRect)frame norImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(JMConfig *)config;

/** 代理 */
@property (nonatomic, weak) id <JMTabBarDelegate>myDelegate;

/** selectedIndex (默认为0) */
@property (nonatomic, assign) NSInteger selectedIndex;

@end
