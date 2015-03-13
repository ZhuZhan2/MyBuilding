//
//  AccountViewController.m
//  PersonalCenter
//
//  Created by Jack on 14-8-19.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginModel.h"
#import "GradientView.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "DatePickerView.h"
#import "BirthDay.h"
#import "LoginSqlite.h"
#import "RecordSqlite.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "EndEditingGesture.h"
#import "UpdataPassWordViewController.h"
#import "ProjectSqlite.h"
@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize userIcon,model,camera,userIdStr;

static int selectBtnTag =0;
static float textFieldFrame_Y_PlusHeight =0;
static bool isBirthday = NO;
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";
static int count =0;//记录生日textField 的时间被触发的次数

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=RGBCOLOR(237, 237, 237);
    self.tableView.tableFooterView=[self getLogoutView];
    [self.view addSubview:self.tableView];

    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    self.title = @"账号设置";

    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 40, 19.5)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(completePerfect) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200) bannerPlaceholderImageName:@"默认主图01"];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImageUrlString:[LoginSqlite getdata:@"backgroundImage"]];
    
    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userImage"]]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(125, -70, 70, 70)];
    [_pathCover setFootViewFrame:CGRectMake(0, 120, 320, 80)];
    [_pathCover.headImage.layer setMasksToBounds:YES];
    [_pathCover.headImage.layer setCornerRadius:35];
    [_pathCover setNameFrame:CGRectMake(0, 0, 320, 20) font:[UIFont systemFontOfSize:14]];
    
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[LoginSqlite getdata:@"userName"], XHUserNameKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    
    NSArray *colorArray = [@[[UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0.0],[UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0]] mutableCopy];
    GradientView *footView = [[GradientView alloc] initWithFrame:CGRectMake(0, 100, 320, 100) colorArr:colorArray];
    [_pathCover addSubview:footView];
    
    for (int i=0; i<2; i++) {
        UIButton *tempBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* tempImg=i?[GetImagePath getImagePath:@"人脉－账号设置_03a-05"]:[GetImagePath getImagePath:@"人脉－账号设置_03a"];
        tempBtn.frame=CGRectMake(0, 0, tempImg.size.width, tempImg.size.height);
        tempBtn.center=CGPointMake(80+160*i, footView.frame.size.height-tempBtn.frame.size.height*.5-10);
        [tempBtn setImage:tempImg forState:UIControlStateNormal];
        [footView addSubview:tempBtn];
        [tempBtn addTarget:self action:i?@selector(setuserIcon):@selector(setbackgroundImage) forControlEvents:UIControlEventTouchUpInside];
    }
    
    __weak AccountViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];

    model = [[ContactModel alloc] init];
    [self getUserInformation];
        
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [EndEditingGesture addGestureToView:self.tableView];
}

- (void)getUserInformation
{
    userIdStr = [LoginSqlite getdata:@"userId"];
    [LoginModel GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            if(posts.count !=0){
                model = posts[0];
                NSLog(@"industry ==> %@",model.industry);
                [self.tableView reloadData];
            }
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } userId:userIdStr noNetWork:^{
        self.tableView.scrollEnabled=NO;
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
            [self getUserInformation];
        }];
    }];
}

- (void)_refreshing {
    // refresh your data sources
    __weak AccountViewController *wself = self;
    [wself.pathCover stopRefresh];
//    double delayInSeconds = 4.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [wself.pathCover stopRefresh];
//    });
}

//*********************************************************************

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    float height = keyboardRect.size.height;
  
    //用来计算键盘还有相关textField的位置，一面textField被遮挡
    float nowTextFieldFrame_Y_PlusHeight =textFieldFrame_Y_PlusHeight+200-64-self.tableView.contentOffset.y;
    if ((nowTextFieldFrame_Y_PlusHeight>kContentHeight-height) || (nowTextFieldFrame_Y_PlusHeight == kContentHeight-height)) {
        float tabViewFrame_Y =kContentHeight - height- nowTextFieldFrame_Y_PlusHeight;
        NSLog(@"********self.tableView.contentOffset.y *** %f",self.tableView.contentOffset.y);
        [UIView animateWithDuration:.3 animations:^{
            self.tableView.frame = CGRectMake(0, tabViewFrame_Y- 10, 320, kScreenHeight);
        }];
    }
}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:.3 animations:^{
        self.tableView.frame =self.view.frame;
    }];
}



//***********************************

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

#pragma mark actionSheetDelegate---------------------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    if(isBirthday ==YES){
        isBirthday =NO;
        if (buttonIndex==1) {
            NSLog(@"传递生日");
            DatePickerView *dataView = (DatePickerView *)actionSheet;
               NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
               model.birthday = [formatter stringFromDate:dataView.datepicker.date];

            model.constellation = [BirthDay getConstellation:model.birthday];
            NSLog(@"*****model******%@",model);
            [self.tableView reloadData];
        }
        count=0;
        return;
    }
    camera = [[Camera alloc] init];
    camera.delegate = self;
    [self.tableView.superview addSubview:camera.view];
    [camera modifyUserIconWithButtonIndex:(int)buttonIndex WithButtonTag:selectBtnTag];
    
}

//cameraDelegate
-(void)changeUserIcon:(NSString *)imageStr AndImage:(UIImage *)image imageData:(NSData *)imageData//更该用户头像
{
    NSLog(@"********userId******* %@",userIdStr);
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

-(void)changeBackgroundImage:(NSString *)imageStr AndImage:(UIImage *)image imageData:(NSData *)imageData{
    [LoginModel AddBackgroundImageWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [LoginSqlite insertData:posts[0] datakey:@"backgroundImage"];
            [_pathCover setBackgroundImageUrlString:posts[0]];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changBackground" object:nil];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    }data:imageData dic:nil noNetWork:nil];
}

/**********************************************************************/
//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
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

-(void)leftBtnClick{//退出到前一个页面
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)completePerfect{//完成修改后触发的方法
    [self.view endEditing:YES];
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    NSMutableDictionary  *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:model.realName forKey:@"realName"];
    [parameter setValue:model.email forKey:@"email"];
    if([model.sex isEqualToString:@"男"]){
        [parameter setValue:@"00" forKey:@"sex"];
    }else if([model.sex isEqualToString:@"女"]){
        [parameter setValue:@"01" forKey:@"sex"];
    }
    [parameter setValue:model.constellation forKey:@"constel"];
    [parameter setValue:model.birthday forKey:@"birthday"];
    if([model.bloodType isEqualToString:@"A型"]){
        [parameter setValue:@"01" forKey:@"bloodType"];
    }else if ([model.bloodType isEqualToString:@"B型"]){
        [parameter setValue:@"02" forKey:@"bloodType"];
    }else if ([model.bloodType isEqualToString:@"AB型"]){
        [parameter setValue:@"03" forKey:@"bloodType"];
    }else if ([model.bloodType isEqualToString:@"O型"]){
        [parameter setValue:@"04" forKey:@"bloodType"];
    }else{
        [parameter setValue:@"05" forKey:@"bloodType"];
    }
    [parameter setValue:model.provice forKey:@"landProvince"];
    [parameter setValue:model.city forKey:@"landCity"];
    [parameter setValue:model.district forKey:@"landDistrict"];
    [LoginModel PostInformationImprovedWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [LoginSqlite insertData:model.userName datakey:@"userName"];
            [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[LoginSqlite getdata:@"userName"], XHUserNameKey, nil]];
            [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil]show];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changName" object:nil];
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } dic:parameter noNetWork:nil];
}

#pragma mark  AccountCellDelegate----------
-(void)ModifyPassword:(NSString *)password
{
    UpdataPassWordViewController *updataPassWordView = [[UpdataPassWordViewController alloc] init];
    [self.navigationController pushViewController:updataPassWordView animated:YES];
}

-(void)getTextFieldFrame_yPlusHeight:(float)y
{
    textFieldFrame_Y_PlusHeight =y;
}

-(void)AddDataToModel:(int)flag WithTextField:(UITextField *)textField
{
    NSLog(@"textField*******%@",textField.text);
    NSLog(@"===>%d",flag);
    switch (flag) {
        case 0:
            model.userName = textField.text;
            break;
        case 1:
            model.realName = textField.text;
            break;
        case 2:
            model.sex = textField.text;
            break;
        case 3:
            model.city = textField.text;
            break;
        case 4:
            model.constellation = textField.text;
            break;
        case 5:
            model.bloodType = textField.text;
            break;
        case 6:
            model.email = textField.text;
            break;
        case 7:
            model.companyName = textField.text;
            break;
        case 8:
            model.position = textField.text;
            break;
        default:
            break;
    }
}


-(void) AddBirthdayPicker:(UILabel *)label
{
    if (count==1) {
        return;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    model.birthday = model.birthday;
    NSLog(@"*******model.birthday*******%@",model.birthday);
    NSDate* birthdayDate = [formatter dateFromString:model.birthday];
    DatePickerView *dataView = [[DatePickerView alloc] initWithTitle:CGRectMake(0, 120, 320, 240) delegate:self date:birthdayDate];
    [dataView showInView:self.view];
    isBirthday =YES;
    count++;
    
}

-(void)addLocation:(NSDictionary *)dic{
    model.provice = dic[@"provice"];
    model.city = dic[@"city"];
    model.district = dic[@"district"];
}

//tableView
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
    NSString *CellIdentifier = [NSString stringWithFormat:@"AccountCell"];
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.delegate = self;
    cell.model = self.model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 780;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotoMyCenter{

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

-(void)logout{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    [LoginSqlite deleteAll];
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

-(UIView*)getSeparatorLine{
    UIImageView* separatorLine=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 3.5)];
    separatorLine.image=[GetImagePath getImagePath:@"Shadow-bottom"];
    return separatorLine;
}

-(void)dealloc{
    NSLog(@"dealloc");
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    
}
@end
