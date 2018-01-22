//
//  JMConfig.h
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

//自定义log
#ifdef DEBUG
#define JMLog(...) NSLog(__VA_ARGS__)
#else
#define JMLog(...)
#endif

//随机颜色+RGB颜色+RBGA颜色+16进制颜色
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

#import <Foundation/Foundation.h>
#import "UIColor+JM.h"
@class JMTabBarController;

/** 布局枚举 */
typedef NS_ENUM(NSInteger, JMConfigTypeLayout) {
    JMConfigTypeLayoutNormal, //默认布局 图片在上 文字在下
    JMConfigTypeLayoutImage,  //只有图片 (图片居中)
};

typedef NS_ENUM(NSInteger, JMConfigTabBarAnimType) {
    JMConfigTabBarAnimTypeNormal, //无动画
    JMConfigTabBarAnimTypeRotationY, //Y轴旋转
    JMConfigTabBarAnimTypeBoundsMin, //缩小
    JMConfigTabBarAnimTypeBoundsMax, //放大
    JMConfigTabBarAnimTypeScale, //缩放动画
};

/** badgeValue 动画枚举 */
typedef NS_ENUM(NSInteger, JMConfigBadgeAnimType) {
    JMConfigBadgeAnimTypeNormal, //无动画
    JMConfigBadgeAnimTypeShake, //抖动动画
    JMConfigBadgeAnimTypeOpacity, //透明过渡动画
    JMConfigBadgeAnimTypeScale, //缩放动画
};

typedef void (^JMConfigCustomBtnBlock) (UIButton *btn, NSInteger index);

@interface JMConfig : NSObject


/**
 单例模式
 */
+ (instancetype)config;

/**
 * 恢复默认配置 (此选项用于demo工程中,实际开发中请忽略)
 */
- (void)configNormal;

/******************************** tabBar 基本配置 ********************************/

/** 布局类型 (默认是 图片在上, 文字在下) */
@property (nonatomic, assign) JMConfigTypeLayout typeLayout;

/** 标题的默认颜色 (默认为 #808080) */
@property (nonatomic, strong) UIColor *norTitleColor;
/** 标题的选中颜色 (默认为 #d81e06)*/
@property (nonatomic, strong) UIColor *selTitleColor;
/** 图片的size (默认 28*28) */
@property (nonatomic, assign) CGSize imageSize;
/** 标题文字大小 (默认 12.f) */
@property (nonatomic, assign) CGFloat titleFont;
/** 标题的偏移值 (标题距离底部的距离 默认 2.f) */
@property (nonatomic, assign) CGFloat titleOffset;
/** 图片的偏移值 (图片距离顶部的距离 默认 2.f) */
@property (nonatomic, assign) CGFloat imageOffset;

/** tabBar */
@property (nonatomic, assign) JMConfigTabBarAnimType tabBarAnimType;
/** 是否显示tabBar顶部线条颜色 (默认 YES) */
@property (nonatomic, assign) BOOL isClearTabBarTopLine;
/** tabBar顶部线条颜色 (默认亮灰色) */
@property (nonatomic, strong) UIColor *tabBarTopLineColor;
/** tabBar的背景颜色 (默认白色) */
@property (nonatomic, strong) UIColor *tabBarBackground;



/** tabBarController */
@property (nonatomic, strong) JMTabBarController *tabBarController;




/******************************** badgeValue 基本配置 ********************************/

/** badgeColor(默认 #FFFFFF) */
@property (nonatomic, strong) UIColor *badgeTextColor;
/** badgeBackgroundColor (默认 #FF4040)*/
@property (nonatomic, strong) UIColor *badgeBackgroundColor;
/** badgeSize (如没有特殊需求, 请勿修改此属性, 此属性只有在控制器加载完成后有效)*/
@property (nonatomic, assign) CGSize badgeSize;
/** badgeOffset (如没有特殊需求, 请勿修改此属性, 此属性只有在控制器加载完成后有效) */
@property (nonatomic, assign) CGPoint badgeOffset;
/** badge圆角大小 (如没有特殊需求, 请勿修改此属性, 此属性只有在控制器加载完成后有效, 一般配合badgeSize或badgeOffset使用) */
@property (nonatomic, assign) CGFloat badgeRadius;
/**
 对单个进行圆角设置
 @param radius 圆角值
 @param index 下标
 */
- (void)badgeRadius:(CGFloat)radius AtIndex:(NSInteger)index;
/** badge动画 (默认无动画) */
@property (nonatomic, assign) JMConfigBadgeAnimType animType;

/**
 显示圆点badgevalue  (以下关于badgeValue的操作可以在app全局操作)  使用方法 [[JMConfig config] showPointBadgeValue: AtIndex: ]
 @param index 显示的下标
 */
- (void)showPointBadgeAtIndex:(NSInteger)index;

/**
 显示newBadgeValue (以下关于badgeValue的操作可以在app全局操作)
 @param index 下标
 */
- (void)showNewBadgeAtIndex:(NSInteger)index;

/**
 显示带数值的下标  (注意: 此方法可以全局重复调用)
 @param badgeValue 数值
 @param index 下标
 */
- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index;

/**
 隐藏下标的badgeValue

 @param index 下标
 */
- (void)hideBadgeAtIndex:(NSInteger)index;



/******************************** 自定义按钮 基本配置 ********************************/

/** btnClickBlock */
@property (nonatomic, weak) JMConfigCustomBtnBlock btnClickBlock;

/**
 添加自定义按钮 (目前只支持自定义按钮, 如果需要自定义view或者对加号按钮有更多需求的请联系我)
 @param btn 自定义btn
 @param index 添加的下标位置
 @param btnClickBlock 按钮点击事件的回调
 */
- (void)addCustomBtn:(UIButton *)btn AtIndex:(NSInteger)index BtnClickBlock:(JMConfigCustomBtnBlock)btnClickBlock;

@end





