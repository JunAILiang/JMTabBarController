//
//  ViewController.m
//  JMTabBarController
//
//  Created by JM on 2018/1/4.
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

#import "ViewController.h"
#import "UIView+JM.h"
#import "JMTabBarController.h"
#import "JMConfig.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** dataArrM */
@property (nonatomic, strong) NSMutableArray *dataArrM;
/** tableView */
@property (nonatomic, weak) UITableView *tableView;
/** 倒计时 */
@property (nonatomic, weak) NSTimer *timer;
/** 数值 */
@property (nonatomic, strong) UILabel *timerL;
/** 倒计时时间 */
@property (nonatomic, assign) NSInteger secondsCountDown;
/** 关闭按钮 */
@property (nonatomic, strong) UIButton *closeBtn;
/** tabbar */
@property (nonatomic, strong) JMTabBarController *tabBarVc;
/** 强引用 */
@property (nonatomic, strong) ViewController *vc;

@end

@implementation ViewController

- (NSMutableArray *)dataArrM {
    if (!_dataArrM) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 49)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = [UIView new];
        _tableView = tableView;
        [self.view addSubview:tableView];
    }
    return _tableView;
}

- (UILabel *)timerL {
    if (!_timerL) {
        self.timerL = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 30)];
        self.timerL.textAlignment = NSTextAlignmentCenter;
        self.timerL.font = [UIFont systemFontOfSize:20.f];
    }
    return _timerL;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setTitle:@"手动关闭" forState:UIControlStateNormal];
        _closeBtn.backgroundColor = kRandomColor;
        _closeBtn.frame = CGRectMake(40, 160, self.view.width - 80, 50);
        [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    self.title = @"超强自定义TabBar组合";
    
    self.vc.secondsCountDown = 10;
    
    self.dataArrM = [NSMutableArray arrayWithObjects:@[@"默认样式",@"只有图片",@"自定义tabBar图标大小",@"tabBar动画1",@"tabBar动画2",@"tabBar动画3",@"tabBar动画4",@"自定义tabBar文字颜色",@"更改TabBar背景颜色"],@[@"badgeValue样式1",@"badgeValue样式2",@"badgeValue样式3",@"badgeValue动画1",@"badgeValue动画2",@"badgeValue动画3"], nil];
    
    [self.view addSubview:self.tableView];
    
}

- (void)countDown {
    self.vc.secondsCountDown--;
    self.timerL.text = [NSString stringWithFormat:@"%zd 秒后自动关闭",self.vc.secondsCountDown];
    
    if (self.vc.secondsCountDown == 0) {
        [self dismiss];
    }
    JMLog(@"%zd",self.vc.secondsCountDown);
    JMLog(@"一直在走吗");
}

- (void)dismiss {
    [self.tabBarVc dismissViewControllerAnimated:YES completion:nil];
    [self.vc.timer invalidate];
    self.vc.timer = nil;
    
    //恢复默认配置
    [[JMConfig config] configNormal];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArrM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArrM[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    
    cell.textLabel.text = self.dataArrM[indexPath.section][indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"tabBar自定义样式";
    } else if (section == 1) {
        return @"自定义badgeValue";
    } else {
        return @"呵呵";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //初始化配置信息
    JMConfig *config = [JMConfig config];
    //因为config是单例,在demo工程中需要重新设置图片大小, 在实际应用中不用设置该属性(因为尺寸会有默认值)
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) { //默认样式(不做任何配置)
        } else if (indexPath.row == 1) {
            config.typeLayout = JMConfigTypeLayoutImage;
        } else if (indexPath.row == 2) {
            config.typeLayout = JMConfigTypeLayoutImage;
            config.imageSize = CGSizeMake(38, 38);
        } else if (indexPath.row == 3) {
            config.tabBarAnimType = JMConfigTabBarAnimTypeRotationY;
        } else if (indexPath.row == 4) {
            config.tabBarAnimType = JMConfigTabBarAnimTypeScale;
        } else if (indexPath.row == 5) {
            config.tabBarAnimType = JMConfigTabBarAnimTypeBoundsMax;
        } else if (indexPath.row == 6) {
            config.tabBarAnimType = JMConfigTabBarAnimTypeBoundsMin;
        } else if (indexPath.row == 7) {
            config.norTitleColor = [UIColor blueColor];
            config.selTitleColor = [UIColor redColor];
        } else if (indexPath.row == 8) {
            config.tabBarBackground = [UIColor greenColor];
        }
    } else if (indexPath.section == 1) {
        //关于badgeValue的样式可全局配置 ,所以这里就return了
        if (indexPath.row == 0) {
//            [config showNewBadgeAtIndex:0];
            [config showNewBadgeAtIndex:1];
        } else if (indexPath.row == 1) {
            [config showPointBadgeAtIndex:2];
        } else if (indexPath.row == 2) {
            [config showNumberBadgeValue:@"6" AtIndex:3];
            [config showNumberBadgeValue:@"99" AtIndex:4];
        } else if (indexPath.row == 3) {
            config.animType = JMConfigBadgeAnimTypeShake;
            [config showNumberBadgeValue:@"99" AtIndex:4];
        } else if (indexPath.row == 4) {
            config.animType = JMConfigBadgeAnimTypeOpacity;
            [config showNumberBadgeValue:@"99" AtIndex:4];
        } else if (indexPath.row == 5) {
            config.animType = JMConfigBadgeAnimTypeScale;
            [config showNumberBadgeValue:@"99" AtIndex:4];
        }
        
        return;
    }
    
    NSMutableArray *titleArr = [NSMutableArray arrayWithObjects:@"首页",@"热点",@"doki",@"个人中心", nil];
    NSMutableArray *imageNormalArr = [NSMutableArray arrayWithObjects:@"tab1_nor",@"tab2_nor",@"tab3_nor",@"tab4_nor", nil];
    NSMutableArray *imageSelectedArr = [NSMutableArray arrayWithObjects:@"tab1_sel",@"tab2_sel",@"tab3_sel",@"tab4_sel", nil];
    NSMutableArray *controllersArr = [NSMutableArray array];
    for (int i = 0; i < titleArr.count; i++) {
        if (i == 0) {
            self.vc = [[ViewController alloc] init];
            self.vc.view.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
            self.vc.secondsCountDown = 10;
            [self.vc.timer invalidate];
            self.vc.timer = nil;
            self.vc.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            [self.vc.view addSubview:self.timerL];
            [self.vc.view addSubview:self.closeBtn];
            [self.vc.tableView removeFromSuperview];
            [controllersArr addObject:self.vc];

        } else {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = kRandomColor;
            [controllersArr addObject:vc];
        }
    }
    
    
     self.tabBarVc = [[JMTabBarController alloc] initWithTabBarControllers:controllersArr NorImageArr:imageNormalArr SelImageArr:imageSelectedArr TitleArr:titleArr Config:config];
    
    [self presentViewController:self.tabBarVc animated:YES completion:nil];

}





@end















