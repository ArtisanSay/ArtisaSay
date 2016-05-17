//
//  NewForumImagesCell.m
//  ArtisaSay
//
//  Created by Apple on 16/5/13.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "NewForumImagesCell.h"
#import "AlbumViewCell.h"

@implementation NewForumImagesCell

- (void)awakeFromNib {
    [self configCollectionView];
}
- (void)updateCellContent :(NSArray *)images{
    _myPhotos = [NSMutableArray arrayWithArray:images];
    [_imageCollectionView reloadData];
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (SCREEN_WIDTH -20 - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _imageCollectionView.collectionViewLayout = layout;
    CGFloat rgb = 244 / 255.0;
    _imageCollectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    self.contentView.backgroundColor = _imageCollectionView.backgroundColor;
    _imageCollectionView.contentInset = UIEdgeInsetsMake(4, 0, 0, 2);
    _imageCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    
    [_imageCollectionView registerClass:[AlbumViewCell class] forCellWithReuseIdentifier:@"AlbumViewCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(_myPhotos.count > 0){
        return _myPhotos.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumViewCell" forIndexPath:indexPath];
    if (_myPhotos.count > 0) {
        
        [cell.imageView setImage:[_myPhotos objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.imgDidClicked){
        self.imgDidClicked(indexPath.row);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
