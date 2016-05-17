//
//  AlbumViewCell.h
//  sc
//
//  Created by 吴逢山 on 18/02/16.
//  Copyright © 2016年 wufengshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIActivityIndicatorView *loadIndicatorView;
- (void)startAnimate;
- (void)stopAnimate;
@end
