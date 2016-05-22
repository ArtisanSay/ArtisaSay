//
//  AlbumViewCell.m
//  Created by 王健 on 18/05/16.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "AlbumViewCell.h"

@implementation AlbumViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0) blue:(34/255.0) alpha:1.0];
        _bgView.contentMode = UIViewContentModeScaleAspectFill;
        
        _loadIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        _loadIndicatorView.center = self.contentView.center;
        [_bgView addSubview:_loadIndicatorView];
        
        [self addSubview:_bgView];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _bgView.frame = self.bounds;
    _loadIndicatorView.center = _bgView.center;
    _bgView.hidden = YES;
}

- (void)startAnimate {
    _bgView.hidden = NO;
    [_loadIndicatorView startAnimating];
}

- (void)stopAnimate {
    _bgView.hidden = YES;
    [_loadIndicatorView stopAnimating];
}
-(void)deleteState {
    _bgView.hidden = YES;
}
- (void)cancelDelete{
    _bgView.hidden = NO;
}
@end
