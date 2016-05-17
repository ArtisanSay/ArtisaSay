//
//  NewForumLocationCell.m
//  LeanChat
//
//  Created by Apple on 16/5/17.
//  Copyright © 2016年 lzwjava@LeanCloud QQ: 651142978. All rights reserved.
//

#import "NewForumLocationCell.h"

@implementation NewForumLocationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateContent:(NSString *)allow {
    if([allow integerValue] == 1){
        _locationImgView.image = [UIImage imageNamed:@"home_18"];
        self.locationLabel.text = @"使用定位";
        
    }else {
        _locationImgView.image = [UIImage imageNamed:@"issue_10"];
        self.locationLabel.text = @"没有显示";
    }
}

@end
