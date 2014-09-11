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
#import "UserModel.h"
@interface AccountViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableView;
@end

@implementation AccountViewController

@synthesize userDic,KindIndex,userIcon,model,camera;

static int selectBtnTag =0;
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=RGBCOLOR(237, 237, 237);
    [self.view addSubview:self.tableView];
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    self.title = @"账号设置";
//    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 40, 19.5)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    KindIndex = @[@"账号信息",@"个人资料",@"联系方式"];
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    _pathCover.delegate = self;
    
    [_pathCover setBackgroundImage:[UIImage imageNamed:@"首页_16.png"]];
    UserModel *userModel = [UserModel sharedUserModel];
    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%s%@",serverAddress,userModel.userImageUrl]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(120, -50, 70, 70)];
    [_pathCover.headImage.layer setMasksToBounds:YES];
    [_pathCover.headImage.layer setCornerRadius:35];
    [_pathCover setNameFrame:CGRectMake(145, 20, 100, 20) font:[UIFont systemFontOfSize:14]];
    _pathCover.userNameLabel.textAlignment = NSTextAlignmentCenter;
    _pathCover.userNameLabel.center = CGPointMake(155, 30);
    
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    
    
    
    
    NSArray *colorArray = [@[[UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:0.0],[UIColor colorWithRed:(0/255.0)  green:(0/255.0)  blue:(0/255.0)  alpha:.5]] mutableCopy];
    GradientView *footView = [[GradientView alloc] initWithFrame:CGRectMake(0, 100, 320, 100) colorArr:colorArray];
    [_pathCover addSubview:footView];
    
    for (int i=0; i<2; i++) {
        UIButton *tempBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* tempImg=[UIImage imageNamed:i?@"人脉－账号设置_03a-05.png":@"人脉－账号设置_03a.png"];
        tempBtn.frame=CGRectMake(0, 0, tempImg.size.width*.5, tempImg.size.height*.5);
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
    model.userName =@"张三";
    model.password =@"123456";
    model.realName = @"张天天";
    model.sex = @"男";
    model.email = @"929097264@qq.com";
    model.cellPhone = @"13938439093";
    model.companyName = @"上海某公司";
    model.position = @"总经理";

    NSString *userIdStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    NSLog(@"********userId******* %@",userIdStr);
    [LoginModel GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        
        NSDictionary *dic = [posts objectAtIndex:0];
        
        userDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        
         NSLog(@"********userDic******* %@",userDic);
       
        
    } userId:userIdStr];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    camera = [[Camera alloc] init];
    camera.delegate = self;
    [self.tableView.superview addSubview:camera.view];
    [camera modifyUserIconWithButtonIndex:buttonIndex WithButtonTag:selectBtnTag];
    
}

//cameraDelegate
-(void)changeUserIcon:(NSString *)imageStr AndImage:(UIImage *)image
{
    NSString *userIdStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *identifier = @"AccountCell";
    AccountCell *accountCell =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!accountCell) {
        accountCell = [[AccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier WithModel:model];
    }
    accountCell.delegate =self;
    return accountCell;

}

-(void)rightBtnClicked:(UIButton *)button
{
    
    
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 780;
    
}

-(void)ModifyPassword:(NSString *)password
{
    NSLog(@"开始修改密码");
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotoMyCenter{

}
@end
