//
//  RegOneViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/3.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "RegOneViewController.h"

#import "LogViewController.h"

#import "RegViewController.h"

@interface RegOneViewController ()

@end

@implementation RegOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)NextToLog:(id)sender {
    RegViewController *regViewController = [[RegViewController alloc] init];
    [self presentViewController:regViewController animated:YES completion:nil];
}
- (IBAction)goToLog:(id)sender {
    LogViewController *logViewController = [[LogViewController alloc] init];
    [self presentViewController:logViewController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
