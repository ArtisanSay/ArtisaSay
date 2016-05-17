//
//  AppShare.h
//  ArtisaSay
//
//  Created by Apple on 16/5/10.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppShare : NSObject
+ (AppShare *)shareInstance;
+ (BOOL)checkNewForumContent:(NSString *)content;
+ (BOOL)filterMaterial:(NSString *)content;

@end
