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
    
    self.navigationController.navigationBar.alpha =0;
    UIImageView *tabBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 64.5)];
    tabBar.image = [UIImage imageNamed:@"tabbar"];
    tabBar.userInteractionEnabled = YES;
    [self.view addSubview:tabBar];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.center =CGPointMake(160, 40);
    titleLabel.text = @"账户";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [tabBar addSubview:titleLabel];
    
    UIButton *completeBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    completeBtn.titleLabel.textColor = [UIColor whiteColor];
    completeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    completeBtn.frame = CGRectMake(250, 20, 60, 40);
    [completeBtn addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:completeBtn];


    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToFormerVC) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:backBtn];
    
    accountTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.5, 320, kContentHeight)];
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

-(void)backToFormerVC
{

    [self.navigationController popViewControllerAnimated:NO];
}

-(void)complete
{

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
