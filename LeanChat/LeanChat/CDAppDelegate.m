//
//  CDAppDelegate.m
//  LeanChat
//
//  Created by Qihe Bian on 7/23/14.
//  Copyright (c) 2014 LeanCloud. All rights reserved.
//

#import "CDAppDelegate.h"
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
#import "ViewController.h"
@interface CDAppDelegate()

@property (nonatomic, strong) CDLoginVC *loginVC;

@end

@implementation CDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self.window makeKeyAndVisible];
    
    UIStoryboard *stordBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *viewController = [stordBoard instantiateViewControllerWithIdentifier:@"main"];
    self.window.rootViewController = viewController;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.window addSubview:imgView];
    NSMutableArray *mutableArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 48; i++) {
        NSString *str = [NSString stringWithFormat:@"animation00%d.png", i+1];
        UIImage *img=[UIImage imageNamed:str];
        [mutableArr addObject:img];
    }
    [imgView setAnimationImages:mutableArr];
    imgView.animationRepeatCount=1;
    [imgView setAnimationDuration:2.f];
    [imgView startAnimating];
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    [[LZPushManager manager] syncBadge];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //[[LZPushManager manager] cleanBadge];
    [application cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[LZPushManager manager] syncBadge];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [AVOSCloudIM handleRemoteNotificationsWithDeviceToken:deviceToken];
    [[LZPushManager manager] saveInstallationWithDeviceToken:deviceToken userId:[AVUser currentUser].objectId];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    DLog(@"%@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    if (application.applicationState == UIApplicationStateActive) {
        // 应用在前台时收到推送，只能来自于普通的推送，而非离线消息推送
    }
    else {
//  当使用 https://github.com/leancloud/leanchat-cloudcode 云代码更改推送内容的时候
//        {
//            aps =     {
//                alert = "lzwios : sdfsdf";
//                badge = 4;
//                sound = default;
//            };
//            convid = 55bae86300b0efdcbe3e742e;
//        }
        [[CDChatManager manager] didReceiveRemoteNotification:userInfo];
        [AVAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
    DLog(@"receiveRemoteNotification");
}


#pragma mark -

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [AVOSCloudSNS handleOpenURL:url];
    [OpenShare handleOpenURL:url];
    return YES;
}

@end
