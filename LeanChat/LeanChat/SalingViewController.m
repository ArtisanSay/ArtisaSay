//
//  SalingViewController.m
//  LeanChat
//
//  Created by Apple on 16/5/19.
//  Copyright © 2016年 lzwjava@LeanCloud QQ: 651142978. All rights reserved.
//

#import "SalingViewController.h"
#import "WJSaleScrollViewCell.h"
#import "WJSaleSortCell.h"
#import "WJSaleThemeCell.h"
#import "SaleInfoViewController.h"
#import "CDAppDelegate.h"
@interface SalingViewController ()<SDCycleScrollViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *saleTabView;
@property (nonatomic,retain)UIScrollView *sc;
@property (nonatomic,retain)UIPageControl *page;
@property (nonatomic,retain)NSTimer *tim;

@end

@implementation SalingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.automaticallyAdjustsScrollViewInsets = YES;
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
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    self.navigationItem.backBarButtonItem = item;

}
#pragma - mark 执行tableView的一系列方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    if (indexPath.section == 1) {
        return 120;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 5;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 3;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        WJSaleScrollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJSaleScrollViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100-20)];
        for (int i=3; i<9; i++) {
            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake((i-3)*SCREEN_WIDTH, 0, SCREEN_WIDTH, 100-20)];
            imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"test00%d.png",i%4]];
            [_sc addSubview:imgView];
        }
        _sc.delegate=self;
        _sc.contentOffset=CGPointMake(SCREEN_WIDTH, 0);
        _sc.contentSize=CGSizeMake(6*SCREEN_WIDTH, 100-20);
        _sc.pagingEnabled=YES;
        _sc.showsHorizontalScrollIndicator=NO;
        [cell addSubview:_sc];
        _page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 100-20, SCREEN_WIDTH, 20)];
        _page.pageIndicatorTintColor = [UIColor redColor];
        _page.currentPageIndicatorTintColor = [UIColor greenColor];
        _page.numberOfPages=4;
        [_page addTarget:self action:@selector(pagePress:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:_page];
        _tim=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(move) userInfo:nil repeats:YES];
        return cell;
    }
    if (indexPath.section == 1) {
        WJSaleSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJSaleSortCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        float width=SCREEN_WIDTH;
        float height=120;
        
        float col=(width-44*4)/5.f;
        float row=(height-44*2)/3.f;
        
        NSMutableArray *titleArr=[[NSMutableArray alloc]initWithObjects:@"书画", @"石料", @"玉器", @"篆刻", @"木艺", @"紫砂壶", @"碑帖", @"其他" , nil];
//        NSMutableArray *tagArr=[[NSMutableArray alloc] init];
        for (int i=0; i<8; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame=CGRectMake(col+(col+44)*(i%4), 5+(row+44)*(i/4), 44, 44);
            [btn setBackgroundImage:[UIImage imageNamed: [NSString stringWithFormat:@"auction_00%d", i+1]] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
            
            UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(col+(col+44)*(i%4)-5, 5+(row+44)*(i/4)+28, 44+10, 44)];
            lab.text=titleArr[i];
            lab.font=[UIFont systemFontOfSize:10.f];
            lab.textAlignment=NSTextAlignmentCenter;
            [cell.contentView addSubview:lab];
        }
        return cell;
    }

    if (indexPath.section == 2) {
        WJSaleThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJSaleThemeCell"];
        cell.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }
    return cell;
}
- (void)buttonPress:(UIButton *)btn {
    NSLog(@"调用了");
}
-(void)move{
    int num=_sc.contentOffset.x/SCREEN_WIDTH;
    [_sc setContentOffset:CGPointMake((num+1)*SCREEN_WIDTH, 0) animated:YES];
}
-(void)pagePress:(UIPageControl *)page{
    
    [_sc setContentOffset:CGPointMake((_page.currentPage+1)*SCREEN_WIDTH, 0) animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float num=scrollView.contentOffset.x/SCREEN_WIDTH;
    if(num>5){
        _sc.contentOffset=CGPointMake(SCREEN_WIDTH+(num-5)*SCREEN_WIDTH, 0);
    }
    if(num<0){
        _sc.contentOffset=CGPointMake(SCREEN_WIDTH*4+num*SCREEN_WIDTH, 0);
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //num表示sc的哪一页
    float num=scrollView.contentOffset.x/SCREEN_WIDTH;
    if(num==5){
        num=1;
    }
    if(num==0){
        num=4;
    }
    _page.currentPage=num-1;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //num表示sc的哪一页
    float num=scrollView.contentOffset.x/SCREEN_WIDTH;
    if(num==5){
        num=1;
    }
    if(num==0){
        num=4;
    }
    _page.currentPage=num-1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_tim setFireDate:[NSDate distantFuture]];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_tim setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
}

- (void)leftBackBtn{
    NSLog(@"leftBackBtn");
}
- (void)rightSearchBtn{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SaleInform" bundle:nil];
    SaleInfoViewController *info = [sb instantiateViewControllerWithIdentifier:@"SaleInfoViewController"];
    CDAppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = info;
}
- (void)rightMessageBtn{
    NSLog(@"rightMessageBtn");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
