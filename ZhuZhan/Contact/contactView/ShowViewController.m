//
//  PanViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-28.
//
//

#import "ShowViewController.h"

@interface ShowViewController ()

@end

@implementation ShowViewController

@synthesize conFriendTableView;
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

//    self.view.frame = CGRectMake(30, 80, 260, 300);
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.layer.cornerRadius = 10;//设置那个圆角的有多圆
//    self.view.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果

   
    
    
    UIImageView  *tempImageView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 260, 240)];
    tempImageView.image = [UIImage imageNamed:@"首页_16.png"];
    tempImageView.userInteractionEnabled = YES;
    [self.view addSubview:tempImageView];
    
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    icon.image = [UIImage imageNamed:@"面部识别登录1_03"];
    icon.center = CGPointMake(130, 80);
    [tempImageView addSubview:icon];
    
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    userName.center = CGPointMake(130, 130);
    userName.text = @"用户名显示";
    userName.textAlignment = NSTextAlignmentCenter;
    userName.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:18];
    userName.textColor = [UIColor whiteColor];
    [tempImageView addSubview:userName];
    
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    message.center = CGPointMake(130, 150);
    message.text = @"512个项目，7条动态";
    message.textAlignment = NSTextAlignmentCenter;
    message.font = [UIFont fontWithName:@"GurmukhiMN-Bold" size:12];
    message.textColor = [UIColor whiteColor];
    [tempImageView addSubview:message];
    
    
    UIButton *visitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    visitBtn.frame = CGRectMake(40, 200, 70, 25);
    [visitBtn setBackgroundImage:[UIImage imageNamed:@"visit"] forState:UIControlStateNormal];
    [visitBtn addTarget:self action:@selector(goToDetail) forControlEvents:UIControlEventTouchUpInside];
    [tempImageView addSubview:visitBtn];
    
    UIButton *concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    concernBtn.frame = CGRectMake(150, 200, 70, 25);
    [concernBtn setBackgroundImage:[UIImage imageNamed:@"concern"] forState:UIControlStateNormal];
    [concernBtn addTarget:self action:@selector(gotoConcern) forControlEvents:UIControlEventTouchUpInside];
    [tempImageView addSubview:concernBtn];
    
    conFriendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 240, 260, 120)];
    conFriendTableView.delegate =self;
    conFriendTableView.dataSource =self;
    [conFriendTableView setSeparatorInset:UIEdgeInsetsZero];//设置tableViewcell下划线的位置没有偏移
    [self.view addSubview:conFriendTableView];
    
//    UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.frame];
//    [image setImage:[UIImage imageNamed:@"首页_16.png"]];
//    [self.view addSubview:image];

}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        static NSString *identifier1 = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
        }
        
        UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 20)];
        label1.text = @"共同好友";
        label1.font = [UIFont systemFontOfSize:12];
        [cell addSubview:label1];
        UILabel *label2 =[[UILabel alloc] initWithFrame:CGRectMake(220, 5,30, 30)];
        label2.text = @"1";
        [cell addSubview:label2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        

    }
static NSString *identifier2 = @"cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
    }
    
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 20)];
    label1.text = @"张三";
    label1.font = [UIFont systemFontOfSize:12];
    [cell addSubview:label1];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(190, 0, 60, 30);
    [button setTitle:@"获得推荐" forState:UIControlStateNormal];
    button.tag = 20140828+indexPath.row;
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(getRecommend:) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)viewWillDisappear:(BOOL)animated{
//    conFriendTableView =nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goToDetail
{
    [_delegate jumpToGoToDetail];
}
- (void)gotoConcern
{
    [_delegate jumpToGotoConcern];
}

-(void)getRecommend:(UIButton *)button
{
    [_delegate jumpToGetRecommend:nil];

}
@end
