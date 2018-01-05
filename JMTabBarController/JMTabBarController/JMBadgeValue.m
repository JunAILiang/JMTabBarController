//
//  JMBadgeValue.m
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

#import "JMBadgeValue.h"
#import "UIColor+JM.h"
#import "JMConfig.h"
#import "UIView+JM.h"
#import "CAAnimation+JMAnimation.h"

@interface JMBadgeValue()

@end

@implementation JMBadgeValue

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.badgeL = [[UILabel alloc] initWithFrame:self.bounds];
        self.badgeL.textColor = [[JMConfig config] badgeTextColor];
        self.badgeL.font = [UIFont systemFontOfSize:11.f];
        self.badgeL.textAlignment = NSTextAlignmentCenter;
        self.badgeL.layer.cornerRadius = 8.f;
        self.badgeL.layer.masksToBounds = YES;
        self.badgeL.backgroundColor = [[JMConfig config] badgeBackgroundColor];
        [self addSubview:self.badgeL];
    }
    return self;
}

- (void)setType:(JMBadgeValueType)type {
    _type = type;
    if (type == JMBadgeValueTypePoint) {
        self.badgeL.size = CGSizeMake(10, 10);
        self.badgeL.layer.cornerRadius = 5.f;
        self.badgeL.x = 0;
        self.badgeL.y = self.height * 0.5 - self.badgeL.size.height * 0.5;
    } else if (type == JMBadgeValueTypeNew) {
        self.badgeL.size = CGSizeMake(self.width, self.height);
    } else if (type == JMBadgeValueTypeNumber) {
        CGSize size = CGSizeZero;
        CGFloat radius = 8.f;
        if (self.badgeL.text.length <= 1) {
            size = CGSizeMake(self.height, self.height);
            radius = self.height * 0.5;
        } else if (self.badgeL.text.length > 1) {
            size = self.bounds.size;
            radius = 8.f;
        }
        self.badgeL.size = size;
        self.badgeL.layer.cornerRadius = radius;
    }

    JMConfigBadgeAnimType animType = [[JMConfig config] animType];
    if (animType == JMConfigBadgeAnimTypeShake) {   //抖动
        [self.badgeL.layer addAnimation:[CAAnimation JM_ShakeAnimation_RepeatTimes:5] forKey:@"shakeAnimation"];
    } else if (animType == JMConfigBadgeAnimTypeOpacity) { //透明过渡动画
        [self.badgeL.layer addAnimation:[CAAnimation JM_OpacityAnimatioinDurTimes:0.3] forKey:@"opacityAniamtion"];
    } else if (animType == JMConfigBadgeAnimTypeScale) { //缩放动画
        [self.badgeL.layer addAnimation:[CAAnimation JM_ScaleAnimation] forKey:@"scaleAnimation"];
    }
}

- (CGSize)sizeWithAttribute:(NSString *)text {
    return [text sizeWithAttributes:@{NSFontAttributeName:self.badgeL.font}];
}

@end







