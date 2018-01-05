//
//  JMTabBarController.h
//  JMTabBarController
//
//  Created by JM on 2017/12/26.
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
#import "JMTabBar.h"

@interface JMTabBarController : UITabBarController

- (instancetype)initWithTabBarControllers:(NSArray *)controllers NorImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(JMConfig *)config;

/** tabBar */
@property (nonatomic, strong) JMTabBar *JM_TabBar;

@end
