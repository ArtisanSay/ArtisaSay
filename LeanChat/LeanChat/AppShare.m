//
//  AppShare.m
//  ArtisaSay
//
//  Created by Apple on 16/5/10.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "AppShare.h"
#import <Foundation/Foundation.h>

@implementation AppShare
+ (AppShare *)shareInstance {
    static dispatch_once_t onceToken;
    static AppShare *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [AppShare new];
    });
    return _instance;
}
+ (BOOL)checkNewForumContent:(NSString *)content {
    NSString *message = @"";
    
    if([AppShare filterMaterial:content]){
        message = @"你的说说内容中,包含敏感词汇,请更改后重试。";
    }
    
    if([message isEqualToString:@""]){
        return YES;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"你好" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    return NO;
}
+ (BOOL)filterMaterial:(NSString *)content {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Filter" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *materialArr = [dic objectForKey:@"words"];
    
    for(NSString *str in materialArr){
        if([content rangeOfString:str].length > 0){
            return YES;
        }
    }
    return NO;
}

@end
