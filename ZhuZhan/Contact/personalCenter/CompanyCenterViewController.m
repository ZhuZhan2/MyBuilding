//
//  CompanyCenterViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/11/4.
//
//

#import "CompanyCenterViewController.h"
#import "LoginModel.h"
#import "LoginSqlite.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "RecordSqlite.h"
#import "EndEditingGesture.h"
#import "CompanyApi.h"
#import "UpdataPassWordViewController.h"
#import "ContactModel.h"
#import "GTMBase64.h"
@interface CompanyCenterViewController ()

@end
@implementation CompanyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataDic = [[NSMutableDictionary alloc] init];
    [self.dataDic setValue:@"" forKey:@""];
    
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.tableFooterView=[self getLogoutView];
    [self.view addSubview:self.tableView];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
    
    self.title = @"账号设置";
    
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton setFrame:CGRectMake(0, 0, 40, 19.5)];
//    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
//    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
//    rightButton.titleLabel.textColor = [UIColor whiteColor];
//    [rightButton addTarget:self action:@selector(completePerfect) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 130) bannerPlaceholderImageName:@"默认主图01"];
    _pathCover.delegate = self;
    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userImage"]]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(125, -40, 70, 70)];
    [_pathCover setFootViewFrame:CGRectMake(0, -190, 320, 320)];
    [_pathCover.headImage.layer setMasksToBounds:YES];
    [_pathCover.headImage.layer setCornerRadius:35];
    self.tableView.tableHeaderView = self.pathCover;
    
    UIButton *tempBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* tempImg=[GetImagePath getImagePath:@"公司－账号设置_03a-05"];
    tempBtn.frame=CGRectMake(115, 100, tempImg.size.width, tempImg.size.height);
    [tempBtn setImage:tempImg forState:UIControlStateNormal];
    [_pathCover addSubview:tempBtn];
    [tempBtn addTarget:self action:@selector(setuserIcon)forControlEvents:UIControlEventTouchUpInside];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [EndEditingGesture addGestureToView:self.tableView];
    
    [CompanyApi GetCompanyDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            if(posts.count !=0){
                self.model = posts[0];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } companyId:[LoginSqlite getdata:@"userId"] noNetWork:^{
        [ErrorCode alert];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)leftBtnClick{//退出到前一个页面
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)completePerfect{//完成修改后触发的方法
//    if (![ConnectionAvailable isConnectionAvailable]) {
//        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
//        return;
//    }
//    
//    NSMutableDictionary  *parameter = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userIdStr,@"userId",model.userName,@"userName",model.realName,@"realName",model.sex,@"sex",model.locationCity,@"locationCity",model.birthday,@"birthday",model.constellation,@"constellation",model.bloodType,@"bloodType",model.email,@"email",model.companyName,@"department",model.position,@"duties",nil];
//    NSLog(@"parameter==%@",parameter);
//    [LoginModel PostInformationImprovedWithBlock:^(NSMutableArray *posts, NSError *error) {
//        
//    } dic:parameter noNetWork:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView isMyDynamicList:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
}

-(UIView*)getLogoutView{
    UIView* logoutView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 55+30)];
    logoutView.backgroundColor = RGBCOLOR(237, 237, 237);
    UIView* separatorLine=[self getSeparatorLine];
    [logoutView addSubview:separatorLine];
    
    UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 30, 320, 55)];
    btn.backgroundColor=RGBCOLOR(235, 114, 114);
    [btn setTitle:@"退出当前账号" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [logoutView addSubview:btn];
    return logoutView;
}

-(UIView*)getSeparatorLine{
    UIImageView* separatorLine=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 3.5)];
    separatorLine.image=[GetImagePath getImagePath:@"Shadow-bottom"];
    return separatorLine;
}

-(void)logout{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    [LoginSqlite deleteAll];
    [RecordSqlite deleteAll];
    HomePageViewController* homeVC=(HomePageViewController*)self.view.window.rootViewController;
    UIButton* btn=[[UIButton alloc]init];
    btn.tag=0;
    [homeVC BtnClick:btn];
//    [LoginModel LogoutWithBlock:^(NSMutableArray *posts, NSError *error) {
//        if (!error) {
//            [LoginSqlite deleteAll];
//            [RecordSqlite deleteAll];
//            HomePageViewController* homeVC=(HomePageViewController*)self.view.window.rootViewController;
//            UIButton* btn=[[UIButton alloc]init];
//            btn.tag=0;
//            [homeVC BtnClick:btn];
//        }
//    } noNetWork:nil];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CompanyTableViewCell"];
    CompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[CompanyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = NO;
    cell.delegate = self;
    cell.model = self.model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

-(void)gotoUpdataPassWord{
    UpdataPassWordViewController *updataPassWordView = [[UpdataPassWordViewController alloc] init];
    [self.navigationController pushViewController:updataPassWordView animated:YES];
}

-(void)setuserIcon{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册", nil];
    [actionSheet showInView:self.tableView.superview];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    //呼出的菜单按钮点击后的响应
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

//开始拍照
-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImageWriteToSavedPhotosAlbum(image, self,nil, nil);
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    
    //NSString* imageStr = [[NSString alloc] initWithData:[GTMBase64 encodeData:imageData] encoding:NSUTF8StringEncoding];
    [self gotoAddImage:imageData image:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)gotoAddImage:(NSData *)imageData image:(UIImage *)image{
    [LoginModel AddUserImageWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [_pathCover addImageHead:image];
            [LoginSqlite insertData:posts[0] datakey:@"userImage"];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changHead" object:nil];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    }data:imageData dic:nil noNetWork:nil];
}

-(void)gotoMyCenter{

}

-(void)dealloc{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}
@end
