//
//  WJHomeViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/4.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//
#import "CDAppDelegate.h"
#import "WJHomeViewController.h"
#import "WJPersonViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WJHomeTableViewCell.h"
#import "MJRefresh.h"
#import "WJSendViewController.h"
#import "JHCustomMenu.h"

@interface WJHomeViewController ()<AVCaptureMetadataOutputObjectsDelegate, UITableViewDataSource, UITableViewDelegate, JHCustomMenuDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, strong) UIButton *sendMessageBtn;
@property (nonatomic, strong) JHCustomMenu *jhmenu;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;


@end

@implementation WJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tabView registerNib:[UINib nibWithNibName:@"WJHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
//    self.tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [_tabView reloadData];
//    }];
//    [self.tabView.mj_header beginRefreshing];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
#pragma - mark  执行tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WJHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (IBAction)showPerson:(id)sender {
    WJPersonViewController *personViewController = [[WJPersonViewController alloc] init];
    [self presentViewController:personViewController animated:YES completion:nil];
}
#pragma - mark 自定义封装tableView
- (IBAction)sweepBtn:(id)sender {
    __weak typeof(self) weakSelf = self;
    if (!self.jhmenu) {
        self.jhmenu = [[JHCustomMenu alloc] initWithDataArr:@[ @"发消息",@"发视频",@"扫一扫"] origin:CGPointMake(_addBtn.center.x , 55) width:100 rowHeight:44];
        _jhmenu.delegate = self;
        _jhmenu.tag = 1;
        _jhmenu.dismiss = ^() {
            weakSelf.jhmenu = nil;
        };
        _jhmenu.arrImgName = @[];
        [self.view addSubview:_jhmenu];
    } else {
        [_jhmenu dismissWithCompletion:^(JHCustomMenu *object) {
            weakSelf.jhmenu = nil;
        }];
    }
}
- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *sendViewController = [storyBoard instantiateViewControllerWithIdentifier:@"sendMessageNav"];
        [self presentViewController:sendViewController animated:YES completion:nil];
    }
    if (indexPath.row == 1) {
        NSLog(@"发视频");
    }
    if (indexPath.row == 2) {
        NSLog(@"扫一扫");
    }
}

- (IBAction)clearImgBtn:(id)sender {
    [_imgView removeFromSuperview];
    [sender removeFromSuperview];
    [_tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@80);
    }];
    [_tabView updateConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
