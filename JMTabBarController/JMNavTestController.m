//
//  JMNavTestController.m
//  JMTabBarController
//
//  Created by JM on 2018/1/8.
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

#import "JMNavTestController.h"
#import "UIView+JM.h"

@interface JMNavTestController ()

@end

@implementation JMNavTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.title = @"超强自定义导航栏";
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"JMTabBarBundle" ofType:@"bundle"]];
    NSString *path = [bundle pathForResource:@"back" ofType:@"png"];
    [btn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateHighlighted];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
//    btn.imageEdgeInsets = UIEdgeInsetsMake(4, 30, 4, 0);
    btn.imageView.frame = CGRectMake(0, 0, 10, 10);
    btn.frame = CGRectMake(0, 0, 50, 20);
    btn.backgroundColor = [UIColor redColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end



















