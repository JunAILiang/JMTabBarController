//
//  JMTabBarButton.m
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

#import "JMTabBarButton.h"
#import "UIView+JM.h"

@interface JMTabBarButton()

@end

@implementation JMTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
    
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:10.f];
        [self addSubview:self.title];
        
        self.badgeValue = [[JMBadgeValue alloc] init];
        self.badgeValue.hidden = YES;
        [self addSubview:self.badgeValue];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize imageSize = [[JMConfig config] imageSize];
    CGFloat imageY = 5;
    if ([[JMConfig config] typeLayout] == JMConfigTypeLayoutImage) {
        imageY = self.height * 0.5 - imageSize.height * 0.5;
    }
    CGFloat iamgeX = self.width * 0.5 - imageSize.width * 0.5;
    self.imageView.frame = CGRectMake(iamgeX, imageY, imageSize.width, imageSize.height);
    
    CGFloat titleX = 4;
    CGFloat titleH = 14.f;
    CGFloat titleW = self.width - 8;
    CGFloat titleY = self.height - 14.f;
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat badgeX = CGRectGetMaxX(self.imageView.frame) - 6;
    CGFloat badgeY = CGRectGetMinY(self.imageView.frame) - 2;
    CGFloat badgeH = 16;
    CGFloat badgeW = 24;
    self.badgeValue.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
}

- (void)setTypeLayout:(JMConfigTypeLayout)typeLayout {
    _typeLayout = typeLayout;
    
    if (typeLayout == JMConfigTypeLayoutImage) {
        self.title.hidden = YES;
        
        CGSize imageSize = [[JMConfig config] imageSize];
        
        CGFloat imageX = self.width * 0.5 - imageSize.width * 0.5;
        CGFloat imageY = self.height * 0.5 - imageSize.height * 0.5;
        self.imageView.frame = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
    }
}

@end





