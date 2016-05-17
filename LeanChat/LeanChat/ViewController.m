//
//  ViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/3.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "ViewController.h"
#import "LLTabBar.h"
#import "LLTabBarItem.h"
#import "WJHomeViewController.h"
#import "WJSchoolViewController.h"
#import "WJSaleViewController.h"
#import "WJMessageViewController.h"
#import "LogAndRegViewController.h"
#import "JHCustomMenu.h"

static int FNumberOfPage = 3;

@interface ViewController () <UIScrollViewDelegate, JHCustomMenuDelegate>

@property (nonatomic, assign) CGRect screenRect;
@property (nonatomic, strong) JHCustomMenu *jhmenu;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _screenRect = [[UIScreen mainScreen] bounds];
    for (int i = 0; i < FNumberOfPage; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_screenRect.size.width*i, 0, _screenRect.size.width, _screenRect.size.height)];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d.jpg",i+1]];
        imgView.userInteractionEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        [_scrollView addSubview:imgView];
        if (i == FNumberOfPage - 1) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn addTarget:self action:@selector(showLogAndReg:) forControlEvents:UIControlEventTouchUpInside];
            [imgView addSubview: btn];
            [btn setBackgroundImage:[UIImage imageNamed:@"enter1"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"enter2"] forState:UIControlStateHighlighted];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(imgView);
                make.size.mas_equalTo(CGSizeMake(100, 40));
                make.bottom.equalTo(@-40);
            }];
        }
    }
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_screenRect.size.width*FNumberOfPage, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.contentOffset = CGPointZero;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.numberOfPages = FNumberOfPage;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_pageControl];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.bottom.equalTo(@-60);
    }];
}
- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)showLogAndReg:(UIButton *)btn{
    LogAndRegViewController *logAndRegViewController = [[LogAndRegViewController alloc] init];
    [self presentViewController:logAndRegViewController animated:YES completion:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    unsigned num = _scrollView.contentOffset.x/_screenRect.size.width;
    _pageControl.currentPage = num;
}

- (void)changePage:(UIPageControl *)pageControl{
    [_scrollView setContentOffset:CGPointMake(_pageControl.currentPage * _screenRect.size.width, 0) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
