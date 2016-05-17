//
//  CustomPickerView.h
//  XiaoYuanMao
//
//  Created by 吴逢山 on 15/10/14.
//  Copyright © 2015年 wufengshan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDAppDelegate.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height

@protocol CustomPickerViewDelegate <NSObject>
@optional
- (void)pickView:(NSMutableArray*)list forSelectIndex:(NSIndexPath *)selectIndex;
@end

//初始化须对contentArr赋值
//若选择界面为cell 则初始化可获取cell对应index 在代理方法中返回对应位置cell内容
@interface CustomPickerView : UIView
<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView * pickView ;
    
}
@property (nonatomic)        NSIndexPath* selectIndex;
@property (nonatomic, strong)NSMutableArray *contentArr;

@property (nonatomic, weak  )id< CustomPickerViewDelegate > delegate;

- (void)show;

@end

