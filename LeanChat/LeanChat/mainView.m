//
//  mainView.m
//  LeanChat
//
//  Created by Apple on 16/5/22.
//  Copyright © 2016年 lzwjava@LeanCloud QQ: 651142978. All rights reserved.
//

#import "mainView.h"
#import "WJHomeViewController.h"
#import "WJSchoolViewController.h"
#import "CDConvsVC.h"
#import "WJPersonViewController.h"
#import "LLTabBar.h"
#import "CDAppDelegate.h"
#import "LLTabBarItem.h"

@implementation mainView
+ (void)goToMain{
    WJHomeViewController *homeViewController = [[WJHomeViewController alloc] init];
    WJSchoolViewController *schoolCityViewController = [[WJSchoolViewController alloc] init];
    
    CDConvsVC *messageViewController = [[CDConvsVC alloc] init];
    UINavigationController *messageNav = [[UINavigationController alloc]initWithRootViewController:messageViewController];
    
    UIStoryboard *personStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WJPersonViewController *personViewController = [personStoryboard instantiateViewControllerWithIdentifier:@"Person"];
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.viewControllers = @[homeViewController, schoolCityViewController,messageNav, personViewController];
    
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
    //tabBar.delegate = self;
    
    [tabbarController.tabBar addSubview:tabBar];
    
    CDAppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = tabbarController;
}
+ (LLTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LLTabBarItemType)tabBarItemType {
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

@end
