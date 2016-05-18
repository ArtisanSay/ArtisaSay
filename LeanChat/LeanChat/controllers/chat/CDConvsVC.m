//
//  CDConvsVC.m
//  LeanChat
//
//  Created by lzw on 15/4/10.
//  Copyright (c) 2015年 LeanCloud. All rights reserved.
//

#import "CDConvsVC.h"
#import "CDUtils.h"
#import "CDIMService.h"
#import "CDFriendListVC.h"

@interface CDConvsVC ()<CDChatListVCDelegate>
{
    CDFriendListVC *friendListVC;
    UIBarButtonItem *friendListItem;
}

@end

@implementation CDConvsVC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"消息";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chatListDelegate = self;
    UIButton *friendListButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 60)];
    friendListButton.titleLabel.font = [UIFont systemFontOfSize:12];
    //[friendListButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    [friendListButton setTitle:@"通讯录" forState:UIControlStateNormal];
    [friendListButton addTarget:self action:@selector(friendListAction) forControlEvents:UIControlEventTouchUpInside];
    friendListItem = [[UIBarButtonItem alloc] initWithCustomView:friendListButton];
    self.navigationItem.rightBarButtonItem = friendListItem;
}

//压栈到好友列表
- (void)friendListAction{
    friendListVC = [[CDFriendListVC alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:friendListVC animated:YES];
}
#pragma mark - CDChatListVCDelegate

- (void)viewController:(UIViewController *)viewController didSelectConv:(AVIMConversation *)conv {
    [[CDIMService service] pushToChatRoomByConversation:conv fromNavigation:viewController.navigationController completion:nil];
}

- (void)setBadgeWithTotalUnreadCount:(NSInteger)totalUnreadCount {
    if (totalUnreadCount > 0) {
        [[self navigationController] tabBarItem].badgeValue = [NSString stringWithFormat:@"%ld", (long)totalUnreadCount];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:totalUnreadCount];
    } else {
        [[self navigationController] tabBarItem].badgeValue = nil;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}

- (UIImage *)defaultAvatarImage {
    UIImage *defaultAvatarImageView = [UIImage imageNamed:@"lcim_conversation_placeholder_avator"];
    defaultAvatarImageView = [CDUtils roundImage:defaultAvatarImageView toSize:CGSizeMake(100, 100) radius:5];
    return defaultAvatarImageView;
}

@end
