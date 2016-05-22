//
//  AddAlbumViewController.m
//  LeanChat
//
//  Created by Apple on 16/5/22.
//  Copyright © 2016年 lzwjava@LeanCloud QQ: 651142978. All rights reserved.
//

#import "AddAlbumViewController.h"
#import "AlbumViewCell.h"
@interface AddAlbumViewController (){
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
}
@property (strong, nonatomic)  UICollectionView *myCollectionView;
@property (nonatomic,strong) UIButton *uploadBtn;
@property (nonatomic,strong) NSMutableArray *uploadQueue;

@end

@implementation AddAlbumViewController

- (void)viewWillAppear:(BOOL)animated {
    
    
    if(self.uploadBtn){
        self.uploadBtn.hidden = NO;
    }else {
        [self initNavigationBut];
    }
    
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.uploadBtn.hidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_selectedPhotos.count > 0){
        _myCollectionView.hidden = NO;
    }else {
        _myCollectionView.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _uploadQueue    = [NSMutableArray array];
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self configCollectionView];
}
#pragma mark - Setup
- (void)initNavigationBut {
    self.uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.uploadBtn.frame = CGRectMake(self.view.frame.size.width - 42, 10, 40, 30);
    self.uploadBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.uploadBtn setEnabled:NO];
    [self.uploadBtn setTitle:@"上传" forState: UIControlStateNormal];
    [self.uploadBtn addTarget:self action:@selector(navigationBntDidClicked) forControlEvents:UIControlEventTouchUpInside];
    self.uploadBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self.navigationController.navigationBar addSubview:self.uploadBtn];
}
- (void)navigationBntDidClicked{
    
}
- (void)configCollectionView {
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    _margin = 4;
//    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
//    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
//    layout.minimumInteritemSpacing = _margin;
//    layout.minimumLineSpacing = _margin;
//    _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(_margin, 0, self.view.tz_width - 2 * _margin, self.view.tz_height-64) collectionViewLayout:layout];
    CGFloat rgb = 244 / 255.0;
    _myCollectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _myCollectionView.contentInset = UIEdgeInsetsMake(4, 0, 0, 2);
    _myCollectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
    _myCollectionView.dataSource = self;
    _myCollectionView.delegate = self;
    [self.view addSubview:_myCollectionView];
    [_myCollectionView registerClass:[AlbumViewCell class] forCellWithReuseIdentifier:@"AlbumViewCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(_selectedPhotos.count > 0){
        [_uploadBtn setEnabled:YES];
        return _selectedPhotos.count + 1;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AlbumViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumViewCell" forIndexPath:indexPath];
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn"];
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
    }
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
