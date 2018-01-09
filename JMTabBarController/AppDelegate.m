//
//  AppDelegate.m
//  JMTabBarController
//
//  Created by JM on 2017/12/26.
//  Copyright © 2017年 JM. All rights reserved.
//

#import "AppDelegate.h"
#import "JMTabBarController.h"
#import "JMConfig.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];

    //初始化标题数组, 未选择图片数组, 选择图片数组, 控制器数组
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"首页",@"热点",@"doki",@"个人中心", nil];
    NSMutableArray *imageNormalArr = [NSMutableArray arrayWithObjects:@"tab1_nor",@"tab2_nor",@"tab3_nor",@"tab4_nor", nil];
    NSMutableArray *imageSelectedArr = [NSMutableArray arrayWithObjects:@"tab1_sel",@"tab2_sel",@"tab3_sel",@"tab4_sel", nil];
    NSMutableArray *controllersArr = [NSMutableArray array];
    for (int i = 0; i < titleArr.count; i++) {
        
        if (i == 0) {
            ViewController *vc = [[ViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            [controllersArr addObject:nav];
        } else {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = kRandomColor;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
            
            [controllersArr addObject:nav];
        }
    }
    
    //初始化配置信息
    JMConfig *config = [JMConfig config];
    
    JMTabBarController *tabBarVc = [[JMTabBarController alloc] initWithTabBarControllers:controllersArr NorImageArr:imageNormalArr SelImageArr:imageSelectedArr TitleArr:titleArr Config:config];
    

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
    [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [config addCustomBtn:btn AtIndex:2 BtnClickBlock:^(UIButton *btn, NSInteger index) {
        JMLog(@"点击了我");
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor orangeColor];
        [[JMConfig config].tabBarController presentViewController:vc animated:YES completion:nil];

        //测试代码 (两秒后自动关闭)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    
    self.window.rootViewController = tabBarVc;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
