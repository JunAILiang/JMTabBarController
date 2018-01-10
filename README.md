# JMTabBarController
超强自定义tabBar
* 支持自定义tabBar动画
* 支持自定义tabBar样式
* 支持自定义badgeValue动画
* 支持自定义badgeValue样式
* 完美支持横竖屏
* 支持iPhone X

# 版本
2018-1-9 -- 修复iPhone X底部间距问题<br/>
2018-1-6 -- 第一个版本

# 如何使用
* 通过CocoaPods导入 `pod 'JMTabBarController', '~> 0.2'`
* 手动导入 直接下载工程把 `JMTabBarController` 文件夹导入到自己工程中

# 演示
![](https://github.com/JunAILiang/JMTabBarController/raw/master/JMTabBarController/gif/JMTabBar1.gif)  ![](https://github.com/JunAILiang/JMTabBarController/raw/master/JMTabBarController/gif/JMTabBar2.gif)  ![](https://github.com/JunAILiang/JMTabBarController/raw/master/JMTabBarController/gif/JMTabBar3.gif)  ![](https://github.com/JunAILiang/JMTabBarController/raw/master/JMTabBarController/gif/JMTabBar4.gif)  ![](https://github.com/JunAILiang/JMTabBarController/raw/master/JMTabBarController/gif/JMTabBar5.gif)  

# 如何使用

### 初始化数组
```
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
```

### 参数配置并设置根视图控制器
```
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
```

# JMConfig说明
  JMConfig文件是整个tabBar以及BadgeValue的动画以及样式配置
```

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

```

### 联系我:
   * qq: 1245424073
[我的博客](https://ljmvip.cn)

