//
//  RetrievePswViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/5.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "RetrievePswViewController.h"
#import "LogViewController.h"
#import "AlertPswViewController.h"

@interface RetrievePswViewController ()

@end

@implementation RetrievePswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view resignFirstResponder];
}
- (IBAction)AlertPswBtn:(id)sender {
    AlertPswViewController *alertPswViewController = [[ AlertPswViewController alloc] init];
    [self presentViewController:alertPswViewController animated:YES completion:nil];
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
