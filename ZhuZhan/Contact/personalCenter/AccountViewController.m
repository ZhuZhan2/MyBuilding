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
    [self.view addSubview:self.tableView];

    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    self.title = @"账号设置";

    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 40, 19.5)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(completePerfect) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    _pathCover.delegate = self;
    
    [_pathCover setBackgroundImage:[GetImagePath getImagePath:@"首页_16"]];
    
    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%s%@",serverAddress,[LoginSqlite getdata:@"userImageUrl" defaultdata:@"userImageUrl"]]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(125, -70, 70, 70)];
    [_pathCover.headImage.layer setMasksToBounds:YES];
    [_pathCover.headImage.layer setCornerRadius:35];
    [_pathCover setNameFrame:CGRectMake(145, 0, 100, 20) font:[UIFont systemFontOfSize:14]];
    
    
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    
    
    
    
    NSArray *colorArray = [@[[UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0.0],[UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:.5]] mutableCopy];
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
}

- (void)getUserInformation
{

    userIdStr = [LoginSqlite getdata:@"userId" defaultdata:@""];
    
    NSLog(@"********userId******* %@",userIdStr);
    [LoginModel GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        model = posts[0];
        [self.tableView reloadData];
    } userId:userIdStr];
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
        self.tableView.frame = CGRectMake(0, tabViewFrame_Y- 10, 320, kScreenHeight);
    }
    

}


//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.tableView.frame = CGRectMake(0, 0, 320, kScreenHeight);
}



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

#pragma mark actionSheetDelegate---------------------
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
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
    [camera modifyUserIconWithButtonIndex:buttonIndex WithButtonTag:selectBtnTag];
    
}

//cameraDelegate
-(void)changeUserIcon:(NSString *)imageStr AndImage:(UIImage *)image//更该用户头像
{

    
    NSLog(@"********userId******* %@",userIdStr);
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"a8909c12-d40e-4cdb-b834-e69b7b9e13c0",@"userId",imageStr,@"userImageStrings", nil];
    [LoginModel AddUserImageWithBlock:^(NSMutableArray *posts, NSError *error) {
        
        [_pathCover addImageHead:image];
        
    } dic:parameter];
    
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




-(void)leftBtnClick{//退出到前一个页面
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)completePerfect{//完成修改后触发的方法
    

    NSMutableDictionary  *parameter = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userIdStr,@"userId",model.userName,@"UserName",model.realName,@"FullName",model.sex,@"Sex",model.locationCity,@"LocationCity",model.birthday,@"Birthday",model.constellation,@"Constellation",model.bloodType,@"BloodType",model.email,@"Email",model.companyName,@"Company",model.position,@"Duties",nil];
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
#pragma mark  AccountCellDelegate----------
-(void)ModifyPassword:(NSString *)password
{
    NSLog(@"开始修改密码");
    
    
}

-(void)getTextFieldFrame_yPlusHeight:(float)y
{
    textFieldFrame_Y_PlusHeight =y;
}

-(void)AddDataToModel:(int)flag WithTextField:(UITextField *)textField
{
    
    NSLog(@"textField*******%@",textField.text);
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
            model.locationCity = textField.text;
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

/*********  tableView   *************************************************************************************************/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSLog(@"numberOfRowsInSection");
    return 1;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"AccountCell"];
    AccountCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell removeFromSuperview];
    cell = nil;
    if(!cell){
        cell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier WithModel:model];
    }
    cell.delegate = self;
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


-(void)dealloc{
    NSLog(@"dealloc");
}
@end
