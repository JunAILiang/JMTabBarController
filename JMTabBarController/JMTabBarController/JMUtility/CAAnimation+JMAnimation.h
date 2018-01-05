//
//  CAAnimation+JMAnimation.h
//  JMTabBarController
//
//  Created by JM on 2018/1/3.
//  Copyright © 2018年 JM. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation (JMAnimation)

/** 注意: 此分类仅限于此项目用, 因为很多属性没有被抽出来, 以后抽空写一个动画的分类 */

/**
 抖动动画

 @param repeatTimes 重复次数
 @return 返回关键帧动画
 */
+ (CAKeyframeAnimation *)JM_ShakeAnimation_RepeatTimes:(float)repeatTimes;


/**
 透明过渡动画

 @param time 持续时间
 @return 返回透明过渡动画
 */
+ (CABasicAnimation *)JM_OpacityAnimatioinDurTimes:(float)time;


/**
 缩放动画

 @return 返回缩放动画
 */
+ (CABasicAnimation *)JM_ScaleAnimation;

+ (CABasicAnimation *)JM_TabBarRotationY;
+ (CABasicAnimation *)JM_TabBarBoundsMin;
+ (CABasicAnimation *)JM_TabBarBoundsMax;


@end
