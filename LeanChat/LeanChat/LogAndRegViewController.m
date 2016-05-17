//
//  LogAndRegViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/5.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "LogAndRegViewController.h"

#import "LogViewController.h"

#import "RegViewController.h"

@interface LogAndRegViewController ()

@end

@implementation LogAndRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goToLog:(id)sender {
    LogViewController *logViewController = [[LogViewController alloc] init];
    [self presentViewController:logViewController animated:YES completion:nil];
}
- (IBAction)goToReg:(id)sender {
    RegViewController *regViewController = [[RegViewController alloc] init];
    [self presentViewController:regViewController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
