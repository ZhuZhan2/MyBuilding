//
//  RecommendContactViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14/12/18.
//
//

#import "RecommendContactViewController.h"
#import "WelcomeViewController.h"
#import "LoadingView.h"
#import "CompanyApi.h"
#import "CompanyMemberCell.h"
#import "EmployeesModel.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "LoginModel.h"
#import "LoginSqlite.h"
#import "ContactModel.h"
@interface RecommendContactViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)LoadingView *loadingView;

@end

@implementation RecommendContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNaviBar];
    [self initMyTableView];

//    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 64, 320, 568) superView:self.view];
    [self firstNetWork];
}

-(void)firstNetWork{
    if (!self.showArr) self.showArr=[NSMutableArray array];
    
    [LoginModel GetRecommendUsersWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self.showArr addObjectsFromArray:posts];
            [self.tableView reloadData];
            [self removeMyLoadingView];
            NSLog(@"showArray====%@",self.showArr);
        }
    } startIndex:0 noNetWork:^{
        [self firstNetWork];
    }];
}

-(void)removeMyLoadingView{
    [LoadingView removeLoadingView:self.loadingView];
    self.loadingView = nil;
}

- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//===============================================================
//UITableViewDataSource,UITableViewDelegate
//===============================================================

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompanyMemberCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[CompanyMemberCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell" needRightBtn:YES];
        [cell.rightBtn addTarget:self action:@selector(chooseApprove:) forControlEvents:UIControlEventTouchUpInside];
    }
    [cell setModel:self.showArr[indexPath.row] indexPathRow:indexPath.row];
    return cell;
}

-(void)chooseApprove:(UIButton*)btn{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }

    btn.enabled=NO;
    EmployeesModel *model = self.showArr[btn.tag];
    BOOL isFocused=[model.a_isFocused isEqualToString:@"1"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if (isFocused) {
        [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
        [dic setValue:model.a_id forKey:@"FocusId"];
        [CompanyApi DeleteFocusWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                model.a_isFocused=@"0";
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
            btn.enabled=YES;
        } dic:dic noNetWork:nil];
    }else{
        [dic setValue:[LoginSqlite getdata:@"userId"] forKey:@"UserId"];
        [dic setValue:model.a_id forKey:@"FocusId"];
        [dic setValue:@"Personal" forKey:@"FocusType"];
        [dic setValue:@"Personal" forKey:@"UserType"];
        [ContactModel AddfocusWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                model.a_isFocused=@"1";
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
            btn.enabled=YES;
        } dic:dic noNetWork:nil];
    }
}

//===============================================================
//===============================================================
//===============================================================
-(void)initNaviBar{
    self.title = @"推荐联系人";
    //返还按钮
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 30)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitle:@"继续" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    WelcomeViewController* vc=[[WelcomeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initMyTableView{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection=NO;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.tableHeaderView=[self headerView];
    [self.view addSubview:self.tableView];
}

-(UIView*)headerView{
    UIView* headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 77)];
    headerView.backgroundColor=RGBCOLOR(235,235,235);
    
    UIImageView* imageView=[[UIImageView alloc]initWithImage:[GetImagePath getImagePath:@"推荐页面02a"]];
    imageView.center=CGPointMake(59, 39);
    [headerView addSubview:imageView];
    
    for (int i=0; i<2; i++) {
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake( 96, 22+(i?19:0), 200, 15)];
        label.font=[UIFont systemFontOfSize:14];
        label.text=i?@"关注他们随时查看个人动态!":@"找到你感兴趣的人，";
        label.textColor=RGBCOLOR(163, 163, 163);
        [headerView addSubview:label];
    }

    UIImageView* lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 73, 320, 5)];
    lineImageView.image=[GetImagePath getImagePath:@"推荐页面06a"];
    [headerView addSubview:lineImageView];
    return headerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    self.tableView.delegate=nil;
    self.tableView.dataSource=nil;
}
@end
