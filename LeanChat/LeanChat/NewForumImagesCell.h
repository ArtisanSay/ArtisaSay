//
//  NewForumImagesCell.h
//  ArtisaSay
//
//  Created by Apple on 16/5/13.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellImgDidClickedBlock)(NSInteger index);

@interface NewForumImagesCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>{
    
    NSMutableArray *_myPhotos;
    CGFloat _itemWH;
    CGFloat _margin;
}

@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (nonatomic,copy) CellImgDidClickedBlock imgDidClicked;
- (void)updateCellContent :(NSArray *)images;

@end
