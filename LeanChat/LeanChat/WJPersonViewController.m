//
//  WJPersonViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/4.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "WJPersonViewController.h"

@interface WJPersonViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation WJPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSLog(@"000000");
    }
    if (indexPath.row == 1) {
        NSLog(@"111111111");
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            break;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
            break;
        case 4:
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
            break;
        case 5:
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
            break;
        default:
            break;
    }
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
