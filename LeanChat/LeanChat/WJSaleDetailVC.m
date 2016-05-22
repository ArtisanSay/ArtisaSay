//
//  WJSaleDetailVC.m
//  LeanChat
//
//  Created by Apple on 16/5/22.
//  Copyright © 2016年 lzwjava@LeanCloud QQ: 651142978. All rights reserved.
//

#import "WJSaleDetailVC.h"
#import "WJSaleDetailCell.h"

@interface WJSaleDetailVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation WJSaleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _saleDetailTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_saleDetailTabView registerNib:[UINib nibWithNibName:@"WJSaleDetailCell" bundle:nil] forCellReuseIdentifier:@"WJSaleDetailCell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WJSaleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJSaleDetailCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
