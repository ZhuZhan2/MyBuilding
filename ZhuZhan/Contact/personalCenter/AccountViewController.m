//
//  AccountViewController.m
//  PersonalCenter
//
//  Created by Jack on 14-8-19.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginModel.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize userDic,KindIndex;

static int selectBtnTag =0;
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    self.title = @"帐户";
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 80, 19.5)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    KindIndex = @[@"账号信息",@"个人资料",@"联系方式"];
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"首页_16.png"]];
    [_pathCover setAvatarImage:[UIImage imageNamed:@"首页侧拉栏_03.png"]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadFrame:CGRectMake(120, -50, 70, 70)];
    [_pathCover setNameFrame:CGRectMake(145, 20, 100, 20) font:[UIFont systemFontOfSize:14]];
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    
    UIButton *setBgBtn =nil;
    UIButton *setIconBtn =nil;
    [_pathCover setButton:setBgBtn WithFrame:CGRectMake(0, 160, 160, 40) WithBackgroundImage:[UIImage imageNamed:@"setBg"] AddTarget:self WithAction:@selector(setbackgroundImage)];
    [_pathCover setButton:setIconBtn WithFrame:CGRectMake(160, 160, 160, 40) WithBackgroundImage:[UIImage imageNamed:@"setIcon"] AddTarget:self WithAction:@selector(setuserIcon)];
    
    self.tableView.tableHeaderView = self.pathCover;
    
    
    __weak AccountViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    [LoginModel GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        
        NSLog(@"**** %@",posts);
//        NSDictionary *dic = [posts objectAtIndex:0];

            NSLog(@"23rgfdg");
        
        
        
    } userId:@"f6cbf226-ebcb-42e1-94ce-acda4fce00d4"];
    
}




- (void)_refreshing {
    // refresh your data sources
    __weak AccountViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wself.pathCover stopRefresh];
    });
}

//***********************************************************************************************************


//*************************************************************************************************************

-(void)setbackgroundImage//设置背景颜色
{
    NSLog(@"设置背景图片");
    selectBtnTag = 2014090201;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册", nil];
    [actionSheet showInView:self.tableView.superview];
    
}

-(void)setuserIcon
{
    NSLog(@"设置用户头像");
    selectBtnTag = 2014090202;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册", nil];
    [actionSheet showInView:self.tableView.superview];
   
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex==0) {
        NSLog(@"拍照获取图片");
        BOOL isCamera =  [UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceRear];
        
        if (!isCamera) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此设备无摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            
            return;
        }
        

        //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = sourceType;
        imagePicker.delegate = self;
        
        
        AppDelegate* app=[AppDelegate instance];
        HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
        [homeVC homePageTabBarHide];
 [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        
        
        
    }
    if (buttonIndex==1) {
        NSLog(@"通过相册获取图片");
        

        //用户相册
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIButton *button = (UIButton*)[self.view viewWithTag:4];
        button.hidden = NO;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = sourceType;
        imagePicker.delegate = self;
        
        AppDelegate* app=[AppDelegate instance];
        HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
        [homeVC homePageTabBarHide];
        [self.view.window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
        //        [self presentViewController:imagePicker animated:YES completion:nil];
        
        
    }
    if (buttonIndex==2) {
        
        //取消

        return;
    }
    
    
    
}

#pragma mark ----UIImagePickerController delegate----
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * imge =  [info objectForKey:UIImagePickerControllerOriginalImage];
    if (selectBtnTag == 2014090201) {
        [_pathCover setBackgroundImage:imge];
        
    }
    if (selectBtnTag == 2014090202) {
        [_pathCover setAvatarImage:imge];
    }
    
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}



/******************************************************************************************************************/
//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView];
    
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
/******************************************************************************************************************/




-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{//完成修改后触发的方法
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSMutableDictionary  *parameter = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userId,@"userId",@"company",@"company",@"industry",@"industry",@"position",@"position",@"locationProvince",@"locationProvince",@"locationCity",@"locationCity",@"introduction",@"introduction",nil];
    [LoginModel PostInformationImprovedWithBlock:^(NSMutableArray *posts, NSError *error) {
        NSDictionary *responseObject = [posts objectAtIndex:0];
        NSString *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1300"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"更新失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        
    } dic:parameter];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *identifier = @"Cell";
    UITableViewCell *cell2 =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell2) {
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 70, 30)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"邮箱地址";
    label1.font = [UIFont systemFontOfSize:14];
    [cell2 addSubview:label1];
    UITextField *emailField = [[UITextField alloc] initWithFrame:CGRectMake(90, 5, 200, 30)];
    emailField.textAlignment = NSTextAlignmentLeft;
    emailField.text = @"222222233445@qq.com";
    emailField.font = [UIFont systemFontOfSize:14];
    emailField.delegate = self;
    [cell2 addSubview:emailField];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 45, 70, 30)];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = @"电      话";
    label2.font = [UIFont systemFontOfSize:14];
    [cell2 addSubview:label2];
    UITextField *cellPhoneFiled = [[UITextField alloc] initWithFrame:CGRectMake(90, 45, 200, 30)];
    cellPhoneFiled.textAlignment = NSTextAlignmentLeft;
    cellPhoneFiled.text = @"123434556657";
    cellPhoneFiled.font = [UIFont systemFontOfSize:14];
    cellPhoneFiled.delegate  =self;
    [cell2 addSubview:cellPhoneFiled];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 85, 70, 30)];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.text = @"在职公司";
    label3.font = [UIFont systemFontOfSize:14];
    [cell2 addSubview:label3];
    UITextField *companyField = [[UITextField alloc] initWithFrame:CGRectMake(90, 85, 200, 30)];
    companyField.textAlignment = NSTextAlignmentLeft;
    companyField.text = @"巴拉巴拉公司";
    companyField.font = [UIFont systemFontOfSize:14];
    companyField.delegate = self;
    [cell2 addSubview:companyField];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, 125, 70, 30)];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.text = @"职      位";
    label4.font = [UIFont systemFontOfSize:14];
    [cell2 addSubview:label4];
    UITextField *positionField = [[UITextField alloc] initWithFrame:CGRectMake(90, 125, 200, 30)];
    positionField.textAlignment = NSTextAlignmentLeft;
    positionField.text = @"总监";
    positionField.font = [UIFont systemFontOfSize:14];
    positionField.delegate =self;
    [cell2 addSubview:positionField];
    
    for (int i=0; i<3; i++) {
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 39+40*i, 300, 2)];
        line.image = [UIImage imageNamed:@"我的任务_05"];
        [cell2 addSubview:line];
    }
    
    
    cell2.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell2;
    
    
    
}

-(void)rightBtnClicked:(UIButton *)button
{
    
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 40;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"grayColor"]];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 80, 30)];
    label.center = CGPointMake(160, 20);
    label.backgroundColor = [UIColor clearColor];
    label.text = [KindIndex objectAtIndex:section];
    label.textColor = BlueColor;
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 160;
    
}

#pragma mark textFieldDelelgate----------
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
