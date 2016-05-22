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
#import "WJSaleDetailVC.h"
#import "SaleInfoViewController.h"
#import "CDAppDelegate.h"
#import "WJHomeViewController.h"
#import "WJSchoolViewController.h"
#import "CDConvsVC.h"
#import "WJPersonViewController.h"
#import "LLTabBarItem.h"
#import "LLTabBar.h"

@interface SalingViewController ()<SDCycleScrollViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, LLTabBarDelegate>

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
    [_saleTabView registerNib:[UINib nibWithNibName:@"WJSaleThemeCell" bundle:nil] forCellReuseIdentifier:@"WJSaleThemeCell"];
    //[_saleTabView registerNib:[UINib nibWithNibName:@"WJSaleDetailCell" bundle:nil] forCellReuseIdentifier:@"WJSaleDetailCell"];
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
}
#pragma - mark 执行tableView的一系列方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }
    if (indexPath.section == 1) {
        return 120;
    }
    return 240;
}
#pragma - mark 区头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 30;
    }
    return 0;
}
#pragma - mark 区尾的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 5;
    }
    return 0;
}
#pragma - mark 表的区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
#pragma - mark 执行didSelectRow方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            WJSaleDetailVC *saleDetailVC = [[WJSaleDetailVC alloc] init];
            [self presentViewController:saleDetailVC animated:YES completion:nil];
        }
    }
}
#pragma - mark 区头的详细情况
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        float cellWidth=tableView.bounds.size.width;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        imgView.image = [UIImage imageNamed:@"auction_37"];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.text=@"拍卖区";
        nameLabel.font = [UIFont systemFontOfSize:16.f];
        nameLabel.textColor = [UIColor colorWithRed:0/255.f green:187/255.f blue:153/255.f alpha:1];
        nameLabel.userInteractionEnabled=YES;
        
        UIButton *timeSortBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [timeSortBtn setTitle:@"按时间排序" forState:UIControlStateNormal];
        [timeSortBtn setTitleColor:[UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1] forState:UIControlStateNormal];
        [timeSortBtn setTitleColor:[UIColor colorWithRed:0/255.f green:187/255.f blue:153/255.f alpha:1] forState:UIControlStateHighlighted];
        timeSortBtn.titleLabel.font=[UIFont systemFontOfSize:12.f];
        timeSortBtn.frame=CGRectMake(cellWidth-70, 5, 60, 20);
        [timeSortBtn addTarget:self action:@selector(timeSort:) forControlEvents:UIControlEventTouchUpInside];
        [nameLabel addSubview:timeSortBtn];
        
        UIButton *moodsSortBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [moodsSortBtn setTitle:@"按人气排序" forState:UIControlStateNormal];
        [moodsSortBtn setTitleColor:[UIColor colorWithRed:0/255.f green:187/255.f blue:153/255.f alpha:1] forState:UIControlStateNormal];
        [moodsSortBtn setTitleColor:[UIColor colorWithRed:102/255.f green:102/255.f blue:102/255.f alpha:1] forState:UIControlStateHighlighted];
        moodsSortBtn.titleLabel.font=[UIFont systemFontOfSize:12.f];
        moodsSortBtn.frame=CGRectMake(cellWidth-140, 5, 60, 20);
        [moodsSortBtn addTarget:self action:@selector(moodsSort:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView *verticalImgView = [[UIImageView alloc]initWithFrame:CGRectMake(cellWidth-70-5, 0, 1, 28)];
        verticalImgView.image = [UIImage imageNamed:@"auction_34"];
        [nameLabel addSubview:timeSortBtn];
        [nameLabel addSubview:moodsSortBtn];
        [nameLabel addSubview:imgView];
        [nameLabel addSubview:verticalImgView];
        return nameLabel;
    }
    return nil;
}
- (void)timeSort:(UIButton *)sender{
    NSLog(@"timeSort调用了");
}
- (void)moodsSort:(UIButton *)sender{
    NSLog(@"moodsSorts调用了");
}
#pragma - mark 表的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 3;
    }
    return 1;
}
#pragma - mark 执行cellForRow方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        WJSaleScrollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJSaleScrollViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        for (int i=3; i<9; i++) {
            UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake((i-3)*SCREEN_WIDTH, 0, SCREEN_WIDTH, 100)];
            imgView.image=[UIImage imageNamed:[NSString stringWithFormat:@"test00%d.png",i%4]];
            [_sc addSubview:imgView];
        }
        _sc.delegate=self;
        _sc.contentOffset=CGPointMake(SCREEN_WIDTH, 0);
        _sc.contentSize=CGSizeMake(6*SCREEN_WIDTH, 100);
        _sc.pagingEnabled=YES;
        _sc.showsHorizontalScrollIndicator=NO;
        [cell addSubview:_sc];
//        _page=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 100-20, SCREEN_WIDTH, 20)];
//        _page.pageIndicatorTintColor = [UIColor redColor];
//        _page.currentPageIndicatorTintColor = [UIColor greenColor];
//        _page.numberOfPages=4;
//        [_page addTarget:self action:@selector(pagePress:) forControlEvents:UIControlEventValueChanged];
//        [cell addSubview:_page];
        _tim=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(move) userInfo:nil repeats:YES];
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
        WJSaleScrollViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WJSaleThemeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
#pragma - mark scroller执行的一系列方法
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
#pragma - mark 返回到首页
- (void)leftBackBtn{
    WJHomeViewController *homeViewController = [[WJHomeViewController alloc] init];
    WJSchoolViewController *schoolCityViewController = [[WJSchoolViewController alloc] init];
    
    CDConvsVC *messageViewController = [[CDConvsVC alloc] init];
    UINavigationController *messageNav = [[UINavigationController alloc]initWithRootViewController:messageViewController];
    
    UIStoryboard *personStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WJPersonViewController *personViewController = [personStoryboard instantiateViewControllerWithIdentifier:@"Person"];
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.viewControllers = @[homeViewController, schoolCityViewController,messageNav, personViewController];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabbarController.tabBar.bounds];
    
    CGFloat normalButtonWidth = (SCREEN_WIDTH * 3 / 4) / 4;
    CGFloat tabBarHeight = CGRectGetHeight(tabBar.frame);
    CGFloat publishItemWidth = (SCREEN_WIDTH / 4);
    
    LLTabBarItem *homeItem = [self tabBarItemWithFrame:CGRectMake(0, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"首页"
                                       normalImageName:@"home1_35"
                                     selectedImageName:@"home_35" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *sameCityItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth, 0, normalButtonWidth, tabBarHeight)
                                                     title:@"校内"
                                           normalImageName:@"home_37"
                                         selectedImageName:@"home1_37" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *publishItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2, 0, publishItemWidth, tabBarHeight)
                                                    title:@"拍卖"
                                          normalImageName:@"home_32"
                                        selectedImageName:@"home_32" tabBarItemType:LLTabBarItemRise];
    LLTabBarItem *messageItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                    title:@"消息"
                                          normalImageName:@"home_40"
                                        selectedImageName:@"home1_40" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *mineItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 3 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"我的"
                                       normalImageName:@"home_43"
                                     selectedImageName:@"home1_43" tabBarItemType:LLTabBarItemNormal];
    
    tabBar.tabBarItems = @[homeItem, sameCityItem, publishItem, messageItem, mineItem];
    tabBar.delegate = self;
    
    [tabbarController.tabBar addSubview:tabBar];
    
    CDAppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = tabbarController;
}

- (LLTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LLTabBarItemType)tabBarItemType {
    LLTabBarItem *item = [[LLTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:12];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setImage:selectedImage forState:UIControlStateHighlighted];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    return item;
}

- (void)rightSearchBtn{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"SaleInform" bundle:nil];
    SaleInfoViewController *info = [sb instantiateViewControllerWithIdentifier:@"SaleInfoViewController"];
    [self.navigationController pushViewController:info animated:YES];
}
- (void)rightMessageBtn{
    NSLog(@"rightMessageBtn");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
