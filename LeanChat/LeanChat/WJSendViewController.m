//
//  WJSendViewController.m
//  ArtisaSay
//
//  Created by Apple on 16/5/10.
//  Copyright © 2016年 YiJiangTianCheng. All rights reserved.
//

#import "WJSendViewController.h"
#import "AppShare.h"
#import "NewForumContentCell.h"
#import "NewForumImagesCell.h"
//#import "SSPictureViewer.h"

@interface WJSendViewController ()<UITextFieldDelegate,UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, TZImagePickerControllerDelegate,CustomPickerViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *infoDic;
@property (nonatomic, strong) NSMutableArray *mutablePhoto;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *selectedPhotos;

@end

@implementation WJSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _selectedPhotos = [NSMutableArray array];
    [self configTableView];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]}];
    self.view.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:237/255.0 alpha:1];
#pragma - mark 调用定位
    //[[CheckLocation sharedManager] startGetLocation];
    
    _mutablePhoto = [NSMutableArray array];
    _infoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"forumContent":@"", @"locationStr":@"", @"isAllowLocation":@"0",@"picture":@[]}];
#pragma - mark 创建ToolBar以及Item
    _toolBar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, SCREEN_HEIGHT-44, SCREEN_WIDTH, 44)];

    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 8, 28, 28)];
    imgView1.image = [UIImage imageNamed:@"issue_10"];
    UIBarButtonItem *barBtnItem1 = [[UIBarButtonItem alloc]initWithImage:imgView1.image style:UIBarButtonItemStylePlain target:self action:@selector(locationBarBtn)];
    barBtnItem1.tintColor = [UIColor lightGrayColor];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 28, 28)];
    imgView2.image = [UIImage imageNamed:@"issue_12"];
    UIBarButtonItem *barBtnItem2 = [[UIBarButtonItem alloc]initWithImage:imgView2.image style:UIBarButtonItemStylePlain target:self action:@selector(sendPhotoBarBtn)];
    barBtnItem2.tintColor = [UIColor lightGrayColor];
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 28, 28)];
    imgView3.image = [UIImage imageNamed:@"issue_15"];
    UIBarButtonItem *barBtnItem3 = [[UIBarButtonItem alloc]initWithImage:imgView3.image style:UIBarButtonItemStylePlain target:self action:@selector(sendFaceBarBtn)];
    barBtnItem3.tintColor = [UIColor lightGrayColor];
    
    UIImageView *imgView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 28, 28)];
    imgView4.image = [UIImage imageNamed:@"issue_17"];
    UIBarButtonItem *barBtnItem4 = [[UIBarButtonItem alloc]initWithImage:imgView4.image style:UIBarButtonItemStylePlain target:self action:@selector(attentionBarBtn)];
    barBtnItem4.tintColor = [UIColor lightGrayColor];
    
    _toolBar.items = @[barBtnItem1, space, barBtnItem2, space, barBtnItem3, space, barBtnItem4, space, space, space,space];
    [self.view addSubview:_toolBar];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(frameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
#pragma - mark 初始化配置TableView
- (void)configTableView {
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.myTableView];
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"NewForumContentCell" bundle:nil] forCellReuseIdentifier:@"NewForumContentCell"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"NewForumImagesCell" bundle:nil] forCellReuseIdentifier:@"NewForumImagesCell"];
}

#pragma - mark 监听键盘，自动改变ToolBar高度
- (void)frameChange:(NSNotification *)nofi{
    CGRect keyBoarfRect=[nofi.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGRect rect=_toolBar.frame;
    rect.origin.y=keyBoarfRect.origin.y-_toolBar.bounds.size.height;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve: [nofi.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]];
    [UIView setAnimationDuration:[nofi.userInfo[UIKeyboardAnimationDurationUserInfoKey]floatValue]];
    _toolBar.frame=rect;
    [UIView commitAnimations];
}
- (void)locationBarBtn{
    
}
#pragma - mark 发送图片
- (void)sendPhotoBarBtn{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
    imagePickerVc.allowPickingVideo         = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    [imagePickerVc.navigationBar setBarTintColor:[UIColor colorWithRed:231/255.0 green:109/255.0 blue:110/255.0 alpha:1]];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
        [_selectedPhotos addObjectsFromArray:photos];
        [_myTableView reloadData];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - UITextField UITextView
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_infoDic setObject:textField.text forKey:@"title"];
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [_infoDic setValue:textView.text forKey:@"forumContent"];
}
/*
- (void)uploadImageBeforCreate {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"YYYYMMddHHmmssSSS";
    NSString *filePath2 =[NSString stringWithFormat:@"%@_%@",[AppShare shareInstance].user.account,[formate stringFromDate:date]];
    [_infoDic setObject:filePath2 forKey:@"picture"];
    
    NSString *filePath1 = _type == CreatNewTypeForum ? @"VCP" : @"schoolTaobao";
    
    for(NSInteger i = 0 ; i < _selectedPhotos.count ; i ++){
        [_uploadQueue addObject:[_selectedPhotos objectAtIndex:i]];
        [self uploadImgae:[_selectedPhotos objectAtIndex:i] filePath1:filePath1 filePath2:filePath2 imgName:nil location:i];
    }
}
- (void)createNewForum {
    [[AppShare shareInstance] showPregressView:@"正在创建"];
    [_adl createNewForum:[AppShare shareInstance].user.userId text:[_infoDic objectForKey:@"forumContent"] picture:[_infoDic objectForKey:@"picture"] school:@"" launchplace:[_infoDic objectForKey:@"locationStr"]];
}

- (void)uploadImgae:(UIImage *)img filePath1:(NSString *)filePath1 filePath2:(NSString *)filePath2 imgName:(NSString *)imgName location:(NSInteger)location {
    //get photo name by mobileNum _ time
    NSDate *date = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    formate.dateFormat = @"YYYYMMddHHmmssSSS";
    NSString *timeStr = [[formate stringFromDate:date] stringByAppendingString:@".jpg"];
    
    //    schoolTaobao/USER_PHONE_yyyyMMddHHmmssSSS/img.jpg
    
    NSData *data = UIImageJPEGRepresentation(img, 0.5);
    
    [_adl uploadFile:timeStr filePath1:filePath1 filePath2:filePath2 fileData:data location:location];
}
*/

#pragma - mark 发送表情
- (void)sendFaceBarBtn{
    NSLog(@"发送表情");
}
#pragma - mark 关注@
- (void)attentionBarBtn{
    NSLog(@"关注");
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *sendImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //    UIImage *oringinal = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [_selectedPhotos addObject:sendImage];
    [_myTableView reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)dismissBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sendBtn:(id)sender {
    NSString *forumContent = [_infoDic objectForKey:@"forumContent"];
    if (forumContent.length > 0 && forumContent) {
        if(![AppShare checkNewForumContent:[_infoDic objectForKey:@"forumContent"]]){
            return;
        }
        if (_mutablePhoto.count > 0) {
            [self uploadImageBeforCreate];
        }

    }
}
- (void)remindUserAboutNewWithoutImages {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新建内容中没有添加图片,你是否继续上传?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:nil style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
}
- (void)uploadImageBeforCreate {
    
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
//    formate.dateFormat = @"YYYYMMddHHmmssSSS";
//    NSString *filePath2 =[NSString stringWithFormat:@"%@_%@",[AppShare shareInstance].user.account,[formate stringFromDate:date]];
//    [_infoDic setObject:filePath2 forKey:@"picture"];
//    
//    NSString *filePath1 = _type == CreatNewTypeForum ? @"VCP" : @"schoolTaobao";
//    
//    for(NSInteger i = 0 ; i < _selectedPhotos.count ; i ++){
//        [_uploadQueue addObject:[_selectedPhotos objectAtIndex:i]];
//        [self uploadImgae:[_selectedPhotos objectAtIndex:i] filePath1:filePath1 filePath2:filePath2 imgName:nil location:i];
//    }
}
#pragma - mark 执行tableView的一系列方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 140;
    }
    CGFloat height = 0;
    CGFloat itemHeight = (SCREEN_WIDTH - 2 * 4 - 4) / 3 - 4;
    if(_selectedPhotos.count <= 3){
            height = itemHeight;
    }
    else if(_selectedPhotos.count%3 != 0){
        height = (_selectedPhotos.count/3 + 1) *itemHeight;
    }else {
        height = (_selectedPhotos.count/3) *itemHeight;
    }
    return height;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if(section == 0){
//        return 0;
//    }
//    return 10;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewForumContentCell *forumContentCell = [_myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [forumContentCell.forumContent resignFirstResponder];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if(indexPath.section == 0){
        NewForumContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewForumContentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.forumContent.delegate = self;
        cell.forumContent.text = [_infoDic objectForKey:@"forumContent"];
        return cell;
    }
    if(indexPath.section == 1)
    {
    NewForumImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewForumImagesCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//  __block typeof(self) weakSelf = self;
    if(_selectedPhotos.count > 0){
        [cell updateCellContent:_selectedPhotos];
        
        cell.imgDidClicked = ^(NSInteger index){
            NSLog(@"终于调用了");
//            SSPictureViewer *viewer = [[SSPictureViewer alloc]initWithSourceType:SourceTypePhoto sourceArr:_selectedPhotos isAllowEditImage:YES currentIndex:index];
//            
//            viewer.returnNewSelectedPhotoArrBlock = ^(NSMutableArray *seletedPhoto, BOOL isOranginal){
//                _selectedPhotos = seletedPhoto;
//                [self.myTableView reloadData];
//            };
//            [self presentViewController:viewer animated:YES completion:nil];
        };
    }
        return cell;
    }
    return cell;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
