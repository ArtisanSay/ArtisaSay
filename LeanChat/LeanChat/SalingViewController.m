//
//  SalingViewController.m
//  LeanChat
//
//  Created by Apple on 16/5/19.
//  Copyright © 2016年 lzwjava@LeanCloud QQ: 651142978. All rights reserved.
//

#import "SalingViewController.h"

@interface SalingViewController ()<UIScrollViewDelegate>
@property (nonatomic,retain)UIScrollView *sc;
@property (nonatomic,retain)NSTimer *tim;
@end

@implementation SalingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    //创建导航栏上的三个btn
    UIButton *leftBackBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    [leftBackBtn addTarget:self action:@selector(leftBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [leftBackBtn setBackgroundImage:[UIImage imageNamed:@"auction_03"] forState:UIControlStateNormal];
    [self.navigationController.view addSubview:leftBackBtn];
    [leftBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(28);
        make.left.mas_equalTo(18);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];

    UIButton *rightMessageBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    [rightMessageBtn addTarget:self action:@selector(rightMessageBtn) forControlEvents:UIControlEventTouchUpInside];
    [rightMessageBtn setBackgroundImage:[UIImage imageNamed:@"auction_07"] forState:UIControlStateNormal];
    [self.navigationController.view addSubview:rightMessageBtn];
    [rightMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(28);
        make.right.mas_equalTo(-18);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];

    UIButton *rightSearchBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    [rightSearchBtn addTarget:self action:@selector(rightSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    [rightSearchBtn setBackgroundImage:[UIImage imageNamed:@"auction_05"] forState:UIControlStateNormal];
    [self.navigationController.view addSubview:rightSearchBtn];
    [rightSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(28);
        make.right.mas_equalTo(-64);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];
    //创建广告的无限滚动
    _sc = [[UIScrollView alloc] init];
    [self.view addSubview:_sc];
    [_sc mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}
- (void)leftBackBtn{
    NSLog(@"leftBackBtn");
}
- (void)rightSearchBtn{
    NSLog(@"rightSearchBtn");
}
- (void)rightMessageBtn{
    NSLog(@"rightMessageBtn");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
