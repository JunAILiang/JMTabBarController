//
//  JMTabBar.m
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

#import "JMTabBar.h"
#import "JMTabBarButton.h"
#import "UIView+JM.h"
#import "CAAnimation+JMAnimation.h"

@interface JMTabBar()

/** 存放JMTabBarButton数组 */
@property (nonatomic, strong) NSMutableArray *saveTabBarArrM;
/** norImage */
@property (nonatomic, strong) NSMutableArray *norImageArrM;
/** SelImage */
@property (nonatomic, strong) NSMutableArray *selImageArrM;
/** titleArr */
@property (nonatomic, strong) NSMutableArray *titleImageArrM;

@end

@implementation JMTabBar

- (NSMutableArray *)norImageArrM {
    if (!_norImageArrM) {
        _norImageArrM = [NSMutableArray array];
    }
    return _norImageArrM;
}

- (NSMutableArray *)selImageArrM {
    if (!_selImageArrM) {
        _selImageArrM = [NSMutableArray array];
    }
    return _selImageArrM;
}

- (NSMutableArray *)titleImageArrM {
    if (!_titleImageArrM) {
        _titleImageArrM = [NSMutableArray array];
    }
    return _titleImageArrM;
}

- (NSMutableArray *)saveTabBarArrM {
    if (!_saveTabBarArrM) {
        _saveTabBarArrM = [NSMutableArray array];
    }
    return _saveTabBarArrM;
}

- (instancetype)initWithFrame:(CGRect)frame norImageArr:(NSArray *)norImageArr SelImageArr:(NSArray *)selImageArr TitleArr:(NSArray *)titleArr Config:(JMConfig *)config{
    if (self = [super initWithFrame:frame]) {        
        for (int i = 0; i < titleArr.count; i++) {
            JMTabBarButton *tbBtn = [[JMTabBarButton alloc] init];
            tbBtn.imageView.image = [UIImage imageNamed:norImageArr[i]];
            tbBtn.title.text = titleArr[i];
            tbBtn.title.textColor = [[JMConfig config] norTitleColor];
            tbBtn.typeLayout = config.typeLayout;
            tbBtn.tag = i;
            [self addSubview:tbBtn];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [tbBtn addGestureRecognizer:tap];
            
            [self.saveTabBarArrM addObject:tbBtn];
            self.titleImageArrM = [NSMutableArray arrayWithArray:titleArr];
            self.norImageArrM = [NSMutableArray arrayWithArray:norImageArr];
            self.selImageArrM = [NSMutableArray arrayWithArray:selImageArr];
            
        }
        
        //背景颜色处理
        self.backgroundColor = [[JMConfig config] tabBarBackground];
        
        //顶部线条处理
        if (config.isClearTabBarTopLine) {
            [self topLineIsClearColor:YES];
        } else {
            [self topLineIsClearColor:NO];
        }
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSMutableArray *tempArr = [NSMutableArray array];
    for (UIView *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButton removeFromSuperview];
        }
        if ([tabBarButton isKindOfClass:[JMTabBarButton class]] || [tabBarButton isKindOfClass:[UIButton class]]) {
            [tempArr addObject:tabBarButton];
        }
    }
    
    JMLog(@"%@",tempArr);
    
    //进行排序
    for (int i = 0; i < tempArr.count; i++) {
        UIView *view = tempArr[i];
        if ([view isKindOfClass:[UIButton class]]) {
            [tempArr insertObject:view atIndex:view.tag];
            [tempArr removeLastObject];
            break;
        }
    }

    CGFloat viewW = self.width / tempArr.count;
    CGFloat viewH = self.height;
    CGFloat viewY = 0;
    for (int i = 0; i < tempArr.count; i++) {
        CGFloat viewX = i * viewW;
        UIView *view = tempArr[i];
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    [self setUpSelectedIndex:tap.view.tag];
    
    if ([self.myDelegate respondsToSelector:@selector(tabBar:didSelectIndex:)]) {
        [self.myDelegate tabBar:self didSelectIndex:tap.view.tag];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    [self setUpSelectedIndex:selectedIndex];
}

#pragma mark - 设置选中的index进行操作
- (void)setUpSelectedIndex:(NSInteger)selectedIndex {
    for (int i = 0; i < self.saveTabBarArrM.count; i++) {
        JMTabBarButton *tbBtn = self.saveTabBarArrM[i];
        if (i == selectedIndex) {
            tbBtn.title.textColor = [[JMConfig config] selTitleColor];
            tbBtn.imageView.image = [UIImage imageNamed:self.selImageArrM[i]];
            
            JMConfigTabBarAnimType type = [[JMConfig config] tabBarAnimType];
            if (type == JMConfigTabBarAnimTypeRotationY) {
                 [tbBtn.imageView.layer addAnimation:[CAAnimation JM_TabBarRotationY] forKey:@"rotateAnimation"];
            } else if (type == JMConfigTabBarAnimTypeScale) {
                
                CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
                CGPoint point = tbBtn.imageView.frame.origin;
                point.y -= 15;
                anim.toValue = [NSNumber numberWithFloat:point.y];
                
                CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                anim1.toValue = [NSNumber numberWithFloat:1.3f];
                
                CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
                groupAnimation.fillMode = kCAFillModeForwards;
                groupAnimation.removedOnCompletion = NO;
                groupAnimation.animations = [NSArray arrayWithObjects:anim,anim1, nil];
                
                [tbBtn.imageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
            } else if (type == JMConfigTabBarAnimTypeBoundsMin) {
                [tbBtn.imageView.layer addAnimation:[CAAnimation JM_TabBarBoundsMin] forKey:@"min"];
            } else if (type == JMConfigTabBarAnimTypeBoundsMax) {
                [tbBtn.imageView.layer addAnimation:[CAAnimation JM_TabBarBoundsMax] forKey:@"max"];
            }
        } else {
            tbBtn.title.textColor = [[JMConfig config] norTitleColor];
            tbBtn.imageView.image = [UIImage imageNamed:self.norImageArrM[i]];
            [tbBtn.imageView.layer removeAllAnimations];
        }
    }
}

#pragma mark - 顶部线条处理(清除颜色)
- (void)topLineIsClearColor:(BOOL)isClearColor {
    UIColor *color = [UIColor clearColor];
    if (!isClearColor) {
        color = [[JMConfig config] tabBarTopLineColor];
    }
    
    CGRect rect = CGRectMake(0, 0, self.width, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self setBackgroundImage:[UIImage new]];
    [self setShadowImage:img];
}

@end
