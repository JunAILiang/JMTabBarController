//
//  JMTabBarButton.h
//  JMTabBarController
//
//  Created by JM on 2017/12/28.
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
#import "JMBadgeValue.h"

@interface JMTabBarButton : UIView

/** UIImageView */
@property (nonatomic, strong) UIImageView *imageView;
/** Title */
@property (nonatomic, strong) UILabel *title;
/** badgeValue */
@property (nonatomic, strong) JMBadgeValue *badgeValue;
/** type */
@property (nonatomic, assign) JMConfigTypeLayout typeLayout;

@end
