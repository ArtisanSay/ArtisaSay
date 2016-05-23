//
//  WJSchoolViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/3.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "WJSchoolViewController.h"

@interface WJSchoolViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *adImgView;

@end

@implementation WJSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)deleteImgBtn:(UIButton *)sender {
    [_adImgView removeFromSuperview];
    [sender removeFromSuperview];
    [_tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
    }];
    [_tabView updateConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
