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

@synthesize pan,conFriendTableView,transparent;
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

    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 10;//设置那个圆角的有多圆
    self.view.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    transparent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 200)];
    transparent.backgroundColor = [UIColor blackColor];
    transparent.alpha = 0.4;
    [self.view addSubview:transparent];
    
    pan = [[Pan alloc] initWithFrame:CGRectMake(0, 0, 260, 200)];
    pan.backgroundColor = [UIColor clearColor];

    
    pan.delegate = self;
    pan.layer.cornerRadius = 0;
    [self.view addSubview:pan];
    
    conFriendTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 260, 100)];
    conFriendTableView.delegate =self;
    conFriendTableView.dataSource =self;
    
//    conFriendTableView.layer.cornerRadius = 10;//设置那个圆角的有多圆
//    conFriendTableView.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    
    [conFriendTableView setSeparatorInset:UIEdgeInsetsZero];//设置tableViewcell下划线的位置没有偏移
    [pan addSubview:conFriendTableView];
    
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
        return cell;

    }
static NSString *identifier2 = @"cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
    }
    
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 60, 20)];
    label1.text = @"韩海龙好友";
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
    [_delegate jumpToGetRecommend:button.tag];

}
@end
