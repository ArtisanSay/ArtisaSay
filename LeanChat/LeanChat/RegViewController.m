//
//  RegViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/3.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "RegViewController.h"
#import "LogViewController.h"

@interface RegViewController ()
@property (nonatomic, assign) BOOL orChange;

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)manBtn:(id)sender {
    if (!_orChange) {
        [_manBtn setBackgroundImage:[UIImage imageNamed:@"register_16.png"] forState:UIControlStateNormal];
        [_womanBtn setBackgroundImage:[UIImage imageNamed:@"register_18.png"] forState:UIControlStateNormal];
    }
    else{
        [_manBtn setBackgroundImage:[UIImage imageNamed:@"register_15.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)womanBtn:(id)sender {
    if (!_orChange) {
        [_womanBtn setBackgroundImage:[UIImage imageNamed:@"register_17.png"] forState:UIControlStateNormal];
        [_manBtn setBackgroundImage:[UIImage imageNamed:@"register_15.png"] forState:UIControlStateNormal];
    }
    else{
        [_womanBtn setBackgroundImage:[UIImage imageNamed:@"register_18.png"] forState:UIControlStateNormal];
    }
}
- (IBAction)goToReg:(id)sender {
    [self.view endEditing:YES];
    NSString *errorMsg = nil;
    if (_regName.text.length == 0) {
    errorMsg = @"用户名不能为空";
    }
    else if (_regPsw.text.length == 0 || _regComPsw.text.length == 0){
    errorMsg = @"注册密码不能为空";
    }
    else if (![_regPsw.text isEqualToString:_regComPsw.text]){
    errorMsg = @"两次密码不一致";
    }
    else{
    errorMsg = @"注册成功";
   }
   if (errorMsg) {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
     }
   
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
