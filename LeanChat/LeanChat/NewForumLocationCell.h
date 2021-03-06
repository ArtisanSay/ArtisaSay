//
//  NewForumLocationCell.h
//  LeanChat
//
//  Created by Apple on 16/5/17.
//  Copyright © 2016年 lzwjava@LeanCloud QQ: 651142978. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewForumLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *locationImgView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic) BOOL isAllowUseLocation;

- (void)updateContent:(NSString *)allow;

@end
