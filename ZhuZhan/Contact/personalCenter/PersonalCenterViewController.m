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
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 5, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 19.5)];
    [rightButton setTitle:@"帐户" forState:UIControlStateNormal];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    personaltableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, kContentHeight)];
    personaltableView.dataSource =self;
    personaltableView.delegate = self;
    
    [self.view addSubview:personaltableView];
    
    NSArray *array = @[@"项目名称显示在这里",@"用户名添加联系人赵钱孙李 职位",@"我发布的动态",@"我发布的动态"];
    personalArray = [NSMutableArray arrayWithArray:array];
}


-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    AccountViewController *accountVC = [[AccountViewController alloc] init];
    [self.navigationController pushViewController:accountVC animated:YES];
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
