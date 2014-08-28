//
//  AccountViewController.m
//  PersonalCenter
//
//  Created by Jack on 14-8-19.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "AccountViewController.h"
#import "AccountImgCell.h"
#import "LoginModel.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

@synthesize accountTableView,userDic;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"地图搜索_01.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    self.title = @"帐户";
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 80, 19.5)];
    [rightButton setTitle:@"帐户设置" forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    accountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kContentHeight)];
    accountTableView.dataSource =self;
    accountTableView.delegate = self;
    accountTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:accountTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
[LoginModel GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
    NSDictionary *responseObject = [posts objectAtIndex:0];
    NSLog(@"dfffdfd*****   %@",responseObject);
//    NSDictionary *data = [[responseObject objectForKey:@"d"] objectForKey:@"data"];
//    NSString *fullName = [NSString stringWithFormat:@"%@",[data objectForKey:@"fullName"]];
//    NSString *sex =[NSString stringWithFormat:@"%@",[data objectForKey:@"sex"]];
//    NSString *department = [NSString stringWithFormat:@"%@",[data objectForKey:@"department"]];
//    userDic = [[NSMutableDictionary alloc] init];
    
    
   } userId:userId];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        static  NSString *identifier1 = @"ImgCell";
        AccountImgCell * cell1 = (AccountImgCell *)[tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell1) {
            cell1 = [[AccountImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
    cell1.bgImgview.image = [UIImage imageNamed:@"首页_16"];
    cell1.userIcon.image = [UIImage imageNamed:@"面部采集_12"];
    cell1.userLabel.text = @"张三";
    cell1.companyLabel.text = @"2年，512个瞬间";
//    cell1.positionLabel.text = @"512个瞬间";
    
    return cell1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 550;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
