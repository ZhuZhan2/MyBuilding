//
//  AccountViewController.m
//  PersonalCenter
//
//  Created by Jack on 14-8-19.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginModel.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize userDic,KindIndex,userIcon,model,camera;

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
    [_pathCover setHeadImageUrl:@"http://www.faceplusplus.com.cn/wp-content/themes/faceplusplus/assets/img/demo/1.jpg"];

    [_pathCover hidewaterDropRefresh];
    [_pathCover setHeadImageFrame:CGRectMake(120, -50, 70, 70)];
    [_pathCover.headImage.layer setMasksToBounds:YES];
    [_pathCover.headImage.layer setCornerRadius:35];
    [_pathCover setNameFrame:CGRectMake(145, 20, 100, 20) font:[UIFont systemFontOfSize:14]];
    _pathCover.userNameLabel.textAlignment = NSTextAlignmentCenter;
    _pathCover.userNameLabel.center = CGPointMake(155, 30);
    
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"Jack", XHUserNameKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    
    UIButton *setBgBtn =nil;
    UIButton *setIconBtn =nil;
    [_pathCover setButton:setBgBtn WithFrame:CGRectMake(0, 160, 158, 40) WithBackgroundImage:[UIImage imageNamed:@"setBg"] AddTarget:self WithAction:@selector(setbackgroundImage)WithTitle:@"设置封面"];
    [_pathCover setButton:setIconBtn WithFrame:CGRectMake(162, 160, 158, 40) WithBackgroundImage:[UIImage imageNamed:@"setIcon"] AddTarget:self WithAction:@selector(setuserIcon)WithTitle:@"设置头像"];

    
    
    
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
    
    [LoginModel GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
        
        NSLog(@"**** %@",posts);
//        NSDictionary *dic = [posts objectAtIndex:0];

            NSLog(@"23rgfdg");
        
        
        
    } userId:@"cfa78e37-a16c-49fe-9370-04f2879cbc88"];
    
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
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"cfa78e37-a16c-49fe-9370-04f2879cbc88",@"userId",imageStr,@"userImageStrings", nil];
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
    
    return 590;
    
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



@end
