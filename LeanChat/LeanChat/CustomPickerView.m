//
//  CustomPickerView.m
//  XiaoYuanMao
//
//  Created by 吴逢山 on 15/10/14.
//  Copyright © 2015年 wufengshan. All rights reserved.
//

#import "CustomPickerView.h"

@implementation CustomPickerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //        self .backgroundColor = [UIColor lightGrayColor];
        
        //        self.alpha = .5;
        
        self.contentArr = [NSMutableArray array];
                
        pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenH-200, frame.size.width, 220)];
        
        pickView.backgroundColor = [UIColor whiteColor];
        
        pickView.dataSource = self;
        
        pickView.delegate = self;
        
        [self addSubview:pickView];
        
        UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(pickView.frame.origin.x, kScreenH-200, 60, 40);
        
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:cancelBtn];
        
        UIButton * okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        okBtn.frame = CGRectMake(kScreenW-60, kScreenH-200, 60, 40);
        
        [okBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        [okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [okBtn addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:okBtn];
        
        //        [pickView selectRow:24 inComponent:0 animated:NO];
        //        [pickView selectRow:[mo intValue]-1 inComponent:1 animated:NO];
    }
    
    return self;
}
#pragma  mark -- <UIPickerViewDataSource,UIPickerViewDelegate>

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.contentArr.count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [[_contentArr objectAtIndex:component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [[_contentArr objectAtIndex:component] objectAtIndex:row];
    
}
- (void)show{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    view.alpha =0.3;
    //此处绑定tag值目的是删除
    view.tag =10000;
    view.backgroundColor =[UIColor grayColor];
    
    CDAppDelegate * app = [UIApplication sharedApplication].delegate;
    [app.window addSubview:view];
    [app.window addSubview:self];
    
}
- (void)removeDatePickView
{
    CDAppDelegate *app =[UIApplication sharedApplication].delegate;
    
    [[app.window viewWithTag:10000]removeFromSuperview];
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    [self removeDatePickView];
}


//确定
- (void)ok{
    
    NSLog(@"d");
    
    if ([_delegate respondsToSelector:@selector(pickView:forSelectIndex:)]) {
        
        NSMutableArray *list = [[NSMutableArray alloc]init];
        for(NSInteger i=0 ;i < _contentArr.count ;i++){
            NSInteger mom = [pickView selectedRowInComponent:i];
            //输出选择内容的对应位置
            [list addObject:[[_contentArr objectAtIndex:i] objectAtIndex:mom]];
        }
        [self.delegate pickView:list forSelectIndex:self.selectIndex];
        
        [self removeDatePickView];
    }
}
- (void)cancel{
    
    [self removeDatePickView];
}

@end
