//
//  LogViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/3.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "LogViewController.h"
#import "LLTabBar.h"
#import "LLTabBarItem.h"
#import "RegOneViewController.h"
#import "RegViewController.h"
#import "WJHomeViewController.h"
#import "WJSchoolViewController.h"
#import "WJSaleViewController.h"
#import "WJMessageViewController.h"
#import "WJPersonViewController.h"
#import "RetrievePswViewController.h"
#import "CDCommon.h"
#import "CDLoginVC.h"
#import "CDAbuseReport.h"
#import "CDCacheManager.h"
#import "CYLTabBarControllerConfig.h"
#import "CDUtils.h"
#import "CDAddRequest.h"
#import "CDIMService.h"
#import "LZPushManager.h"
#import <iRate/iRate.h>
#import <iVersion/iVersion.h>
#import <LeanCloudSocial/AVOSCloudSNS.h>
#import <AVOSCloudCrashReporting/AVOSCloudCrashReporting.h>
#import <OpenShare/OpenShareHeader.h>
#import "MBProgressHUD.h"
#import "CDAppDelegate.h"
#import "CDConvsVC.h"

@interface LogViewController ()<LLTabBarDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) CDLoginVC *loginVC;

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
};
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [CDAddRequest registerSubclass];
    [CDAbuseReport registerSubclass];
#if USE_US
    [AVOSCloud useAVCloudUS];
#endif
    
    // Enable Crash Reporting
    [AVOSCloudCrashReporting enable];
    //希望能提供更详细的日志信息，打开日志的方式是在 AVOSCloud 初始化语句之后加上下面这句：
    
    //Objective-C
#ifndef __OPTIMIZE__
    [AVOSCloud setAllLogsEnabled:YES];
#endif
    [AVOSCloud setApplicationId:@"x3o016bxnkpyee7e9pa5pre6efx2dadyerdlcez0wbzhw25g" clientKey:@"057x24cfdzhffnl3dzk14jh9xo2rq6w1hy1fdzt5tv46ym78"];
    //    [AVOSCloud setApplicationId:CloudAppId clientKey:CloudAppKey];
    //    [AVOSCloud setApplicationId:PublicAppId clientKey:PublicAppKey];
    
    [AVOSCloud setLastModifyEnabled:YES];
    
    if (SYSTEM_VERSION >= 7.0) {
        [[UINavigationBar appearance] setBarTintColor:NAVIGATION_COLOR];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }
    else {
        [[UINavigationBar appearance] setTintColor:NAVIGATION_COLOR];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    
    if ([AVUser currentUser]) {
        // Applications are expected to have a root view controller at the end of application launch
        [self toMain];
    }
    else {
        [self toLogin];
    }
    
    [[LZPushManager manager] registerForRemoteNotification];
    
    //[AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    [self initAnalytics];
    
#ifdef DEBUG
    [AVPush setProductionMode:NO];  // 如果要测试申请好友是否有推送，请设置为 YES
    //    [AVOSCloud setAllLogsEnabled:YES];
#endif

}
- (void)initAnalytics {
    [AVAnalytics setAnalyticsEnabled:YES];
#ifdef DEBUG
    [AVAnalytics setChannel:@"Debug"];
#else
    [AVAnalytics setChannel:@"App Store"];
#endif
    // 应用每次启动都会去获取在线参数，这里同步获取即可。可能是上一次启动获取得到的在线参数。不过没关系。
    NSDictionary *configParams = [AVAnalytics getConfigParams];
    DLog(@"configParams: %@", configParams);
}
- (void)toLogin {
    self.loginVC = [[CDLoginVC alloc] init];
    //self.window.rootViewController = self.loginVC;
}

- (void)toMain{
    [iRate sharedInstance].applicationBundleID = @"com.artisanSay";
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    [iRate sharedInstance].previewMode = NO;
    [iVersion sharedInstance].applicationBundleID = @"com.artisanSay";
    [iVersion sharedInstance].previewMode = NO;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[CDCacheManager manager] registerUsers:@[[AVUser currentUser]]];
    [CDChatManager manager].userDelegate = [CDIMService service];
    
#ifdef DEBUG
// #warning 使用开发证书来推送，方便调试，具体可看这个变量的定义处
    [CDChatManager manager].useDevPushCerticate = YES;
#endif
    
    //提示正在登陆
    [self toast:@"正在登陆" duration:MAXFLOAT];
    [[CDChatManager manager] openWithClientId:[AVUser currentUser].objectId callback: ^(BOOL succeeded, NSError *error) {
        [self hideProgress];
        if (succeeded) {
            //CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
            //self.window.rootViewController = tabBarControllerConfig.tabBarController;
        } else {
            [self toLogin];
            DLog(@"%@", error);
        }
        
    }];
}

- (void)toast:(NSString *)text duration:(NSTimeInterval)duration {
    [AVAnalytics event:@"toast" attributes:@{@"text": text}];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    hud.labelText=text;
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];
    hud.detailsLabelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud hide:YES afterDelay:duration];
}

-(void)showProgress {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideProgress {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (IBAction)goToLog:(id)sender {
     WJHomeViewController *homeViewController = [[WJHomeViewController alloc] init];
     WJSchoolViewController *schoolCityViewController = [[WJSchoolViewController alloc] init];
     CDConvsVC *messageViewController = [[CDConvsVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:messageViewController];
    
    UIStoryboard *personStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WJPersonViewController *personViewController = [personStoryboard instantiateViewControllerWithIdentifier:@"Person"];
    
     UITabBarController *tabbarController = [[UITabBarController alloc] init];
     tabbarController.viewControllers = @[homeViewController, schoolCityViewController, nav, personViewController];
     
     [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
     [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
     
     LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabbarController.tabBar.bounds];
     
     CGFloat normalButtonWidth = (SCREEN_WIDTH * 3 / 4) / 4;
     CGFloat tabBarHeight = CGRectGetHeight(tabBar.frame);
     CGFloat publishItemWidth = (SCREEN_WIDTH / 4);
     
     LLTabBarItem *homeItem = [self tabBarItemWithFrame:CGRectMake(0, 0, normalButtonWidth, tabBarHeight)
     title:@"首页"
     normalImageName:@"home1_35"
     selectedImageName:@"home_35" tabBarItemType:LLTabBarItemNormal];
     LLTabBarItem *sameCityItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth, 0, normalButtonWidth, tabBarHeight)
     title:@"校内"
     normalImageName:@"home_37"
     selectedImageName:@"home1_37" tabBarItemType:LLTabBarItemNormal];
     LLTabBarItem *publishItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2, 0, publishItemWidth, tabBarHeight)
     title:@"拍卖"
     normalImageName:@"home_32"
     selectedImageName:@"home_32" tabBarItemType:LLTabBarItemRise];
     LLTabBarItem *messageItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
     title:@"消息"
     normalImageName:@"home_40"
     selectedImageName:@"home1_40" tabBarItemType:LLTabBarItemNormal];
     LLTabBarItem *mineItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 3 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
     title:@"我的"
     normalImageName:@"home_43"
     selectedImageName:@"home1_43" tabBarItemType:LLTabBarItemNormal];
    
     tabBar.tabBarItems = @[homeItem, sameCityItem, publishItem, messageItem, mineItem];
     tabBar.delegate = self;
     
     [tabbarController.tabBar addSubview:tabBar];
     
     CDAppDelegate *app = [UIApplication sharedApplication].delegate;
     app.window.rootViewController = tabbarController;
     
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (LLTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LLTabBarItemType)tabBarItemType {
    LLTabBarItem *item = [[LLTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:12];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setImage:selectedImage forState:UIControlStateHighlighted];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    return item;
}
- (IBAction)forgetPswBtn:(id)sender {
    RetrievePswViewController *retrievePswViewController = [[RetrievePswViewController alloc] init];
    [self presentViewController:retrievePswViewController animated:YES completion:nil];
}
- (IBAction)goToReg:(id)sender {
    RegViewController *regViewController = [[RegViewController alloc] init];
    [self presentViewController:regViewController animated:YES completion:nil];
}

#pragma mark - LLTabBarDelegate

- (void)tabBarDidSelectedRiseButton {

    CDAppDelegate *app = (CDAppDelegate *)[UIApplication sharedApplication].delegate;
    UIStoryboard *saleStoryboard = [UIStoryboard storyboardWithName:@"Sale" bundle:nil];
    WJSaleViewController *saleViewController = [saleStoryboard instantiateViewControllerWithIdentifier:@"Sale"];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:saleViewController];
    app.window.rootViewController = nav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
