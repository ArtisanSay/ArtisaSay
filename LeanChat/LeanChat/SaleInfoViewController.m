//
//  SaleInfoViewController.m
//  LeanChat
//
//  Created by 四川艺匠天诚科技有限公司 on 16/5/20.
//  Copyright © 2016年 lzwjava@LeanCloud QQ: 651142978. All rights reserved.
//

#import "SaleInfoViewController.h"
//#import "NetHelpers.h"
#import "SDCycleScrollView.h"
#import "ScrollViewCell.h"

@interface SaleInfoViewController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)NSArray *scrollArr;
@end

@implementation SaleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.backgroundColor = [UIColor whiteColor];
    
     self.navigationItem.title=@"拍卖详情";    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]}];
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:237/255.0 alpha:1];

    
    //右边的btn
    UIButton *rightMessageBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    //[rightMessageBtn addTarget:self action:@selector(other) forControlEvents:UIControlEventTouchUpInside];
    [rightMessageBtn setBackgroundImage:[UIImage imageNamed:@"auction_07"] forState:UIControlStateNormal];
    [self.navigationController.view addSubview:rightMessageBtn];
    [rightMessageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(28);
        make.right.mas_equalTo(-18);
        make.size.mas_equalTo(CGSizeMake(28, 28));
    }];

  //左边的返回的字体颜色
  self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:1];


  _scrollArr = @[@"01.png",@"02.png",@"03.png",@"04.png"];

}

#pragma mark --UITableViewDataSource,UITableViewDelegate

//对应的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return 1 ;
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {
            ScrollViewCell *theCell=[tableView dequeueReusableCellWithIdentifier:@"ScrollViewCell" forIndexPath:indexPath];
            
            
            NSMutableArray *array=[[NSMutableArray alloc]init];
            
            for (int i=0; i<_scrollArr.count; i++) {
                
                [array addObject:_scrollArr[i]];
                
            }
           SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:theCell.bounds imageNamesGroup:array];
            //加载网络图片
//             SDCycleScrollView *cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:theCell.bounds delegate:self placeholderImage:nil];
//            cycleScrollView.imageURLStringsGroup=array;
            //cycleScrollView.localizationImageNamesGroup = array;
            
            cycleScrollView.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter;
            cycleScrollView.currentPageDotColor=[UIColor whiteColor];
            [theCell.contentView addSubview:cycleScrollView];
            theCell.backgroundColor = [UIColor redColor];
            return theCell;

        }
    }
    
    [_tableView reloadData];
    return cell;
}

//区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

//区高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        
        return 0;
    }
  
    return 0;
    
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
