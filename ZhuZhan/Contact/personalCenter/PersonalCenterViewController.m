//
//  PersonalCenterViewController.m
//  PersonalCenter
//
//  Created by Jack on 14-8-18.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "ImgCell.h"
#import "CommonCell.h"
#import "AccountViewController.h"
@interface PersonalCenterViewController ()

@end

@implementation PersonalCenterViewController

@synthesize personaltableView,personalArray;
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

//    [self.navigationController.navigationBar removeFromSuperview];
    self.navigationController.navigationBar.alpha =0;
    UINavigationBar *tabBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64.5)];
    [tabBar setBackgroundImage:[UIImage imageNamed:@"地图搜索_01.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:tabBar];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.center =CGPointMake(160, 40);
    titleLabel.text = @"个人中心";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [tabBar addSubview:titleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToFormerVC) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:backBtn];
    
    UIButton *accountBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [accountBtn setTitle:@"帐户" forState:UIControlStateNormal];
    accountBtn.titleLabel.textColor = [UIColor whiteColor];
    accountBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    accountBtn.frame = CGRectMake(250, 20, 60, 40);
    [accountBtn addTarget:self action:@selector(account) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:accountBtn];
    
    personaltableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.5, 320, kContentHeight)];
    personaltableView.dataSource =self;
    personaltableView.delegate = self;
    
    [self.view addSubview:personaltableView];
    
    NSArray *array = @[@"项目名称显示在这里",@"用户名添加联系人赵钱孙李 职位",@"我发布的动态",@"我发布的动态"];
    personalArray = [NSMutableArray arrayWithArray:array];
}

-(void)backToFormerVC
{
    self.navigationController.navigationBar.alpha =1;
    [self.navigationController popViewControllerAnimated:NO];
}



-(void)account{//账户
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    [self.navigationController pushViewController:accountVC animated:NO];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [personalArray count]+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
      static  NSString *identifier1 = @"ImgCell";
        ImgCell * cell1 = (ImgCell *)[tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell1) {
            cell1 = [[ImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        
        cell1.bgImgview.image = [UIImage imageNamed:@"首页_16"];
        cell1.userIcon.image = [UIImage imageNamed:@"面部采集_12"];
        cell1.userLabel.text = @"张三";
        cell1.companyLabel.text = @"上海深集科技有限公司";
        cell1.positionLabel.text = @"销售经理";
        
        return cell1;
    }
    static NSString *identifier2 = @"commonCell";
        CommonCell *cell2 = (CommonCell*)[tableView dequeueReusableCellWithIdentifier:identifier2];
        if (!cell2) {
            cell2 = [[CommonCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:identifier2];
        }
   
    cell2.userIcon.image = [UIImage imageNamed:@"面部采集_12"];
    cell2.contentLabel.text = [personalArray objectAtIndex:indexPath.row-1];
    
    return cell2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 250;
    }
    
    return 50;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
