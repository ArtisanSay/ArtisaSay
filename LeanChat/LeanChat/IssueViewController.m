//
//  IssueViewController.m
//  LeanChat
//
//  Created by Apple on 16/5/19.
//  Copyright © 2016年 lzwjava@LeanCloud QQ: 651142978. All rights reserved.
//

#import "IssueViewController.h"
#import "SaleInfoViewController.h"
@interface IssueViewController ()

@end

@implementation IssueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.navigationItem.backBarButtonItem = item;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SaleInform" bundle:nil];
    SaleInfoViewController *info = [sb instantiateViewControllerWithIdentifier:@"SaleInfoViewController"];
    [self.navigationController pushViewController:info animated:YES];
    
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
