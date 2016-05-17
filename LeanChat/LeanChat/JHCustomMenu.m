//
//  SecondMenuView.m
//  LoveBB
//
//  Created by AngelLL on 15/10/22.
//  Copyright © 2015年 Daniel_Li. All rights reserved.
//

#import "JHCustomMenu.h"

#define TopToView 4.0f
#define LeftToView 6.0f
#define CellLineEdgeInsets UIEdgeInsetsMake(0, 10, 0, 10)
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight        [UIScreen mainScreen].bounds.size.height

@interface JHCustomMenu()
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat rowHeight;
@end
@implementation JHCustomMenu

- (instancetype)initWithDataArr:(NSArray *)dataArr origin:(CGPoint)origin width:(CGFloat)width rowHeight:(CGFloat)rowHeight
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        if (rowHeight <= 0) {
            rowHeight = 44;
        }
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        self.origin = origin;
        self.rowHeight = rowHeight;
        self.arrData = [dataArr copy];
        //根据输入的控件位置 初始化tableview
        if(origin.x+0.5*width+5>kScreenWidth){
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth-width-5, origin.y + TopToView+4, width, rowHeight * dataArr.count) style:UITableViewStylePlain];
        }else {
            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x - 0.5*width, origin.y + TopToView+4, width, rowHeight * dataArr.count) style:UITableViewStylePlain];
        }
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
        _tableView.backgroundColor = [UIColor whiteColor];        _tableView.layer.cornerRadius = 2;
        _tableView.bounces = NO;
        _tableView.separatorColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"JHCustomMenu"];
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [self.tableView setSeparatorInset:CellLineEdgeInsets];
            
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [self.tableView setLayoutMargins:CellLineEdgeInsets];
            
        }

    }
    return self;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JHCustomMenu"];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.arrData[indexPath.row];
    if (self.arrImgName.count > indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:self.arrImgName[indexPath.row]];
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.delegate respondsToSelector:@selector(jhCustomMenu:didSelectRowAtIndexPath:)]){
        [self.delegate jhCustomMenu:tableView didSelectRowAtIndexPath:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissWithCompletion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:CellLineEdgeInsets];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:CellLineEdgeInsets];
        
    }
    
}

- (void)dismissWithCompletion:(void (^)(JHCustomMenu *object))completion
{
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.alpha = 0;
        weakSelf.tableView.frame = CGRectMake(weakSelf.origin.x + LeftToView, weakSelf.origin.y + TopToView, 0, 0);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
        if (completion) {
            completion(weakSelf);
        }
        if (weakSelf.dismiss) {
            weakSelf.dismiss();
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.tableView]) {
        [self dismissWithCompletion:nil];
    }
}

- (void)drawRect:(CGRect)rect

{
    
    
//    [colors[serie] setFill];
    
    //拿到当前视图准备好的画板
    
    CGContextRef
    context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    
    CGContextMoveToPoint(context,
                         _origin.x, _origin.y+4);//设置起点
    
    CGContextAddLineToPoint(context,
                            _origin.x-LeftToView, _origin.y + TopToView+5);
    
    CGContextAddLineToPoint(context,
                            _origin.x+LeftToView, _origin.y + TopToView+5);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [self.tableView.backgroundColor setFill]; //设置填充色
    [self.tableView.backgroundColor setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
}

@end
