//
//  RegViewController.h
//  ArtisaSay
//
//  Created by Apple on 16/5/3.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *regName;
- (IBAction)manBtn:(id)sender;
- (IBAction)womanBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@property (weak, nonatomic) IBOutlet UITextField *regPsw;
@property (weak, nonatomic) IBOutlet UITextField *regComPsw;
- (IBAction)goToReg:(id)sender;
- (IBAction)goToLog:(id)sender;


@end
