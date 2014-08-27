//
//  PersonalDetailViewController.m
//  ZhuZhan
//
//  Created by Jack on 14-8-27.
//
//

#import "PersonalDetailViewController.h"
#import "PImgCell.h"
@interface PersonalDetailViewController ()

@end

@implementation PersonalDetailViewController

@synthesize myTableView,KindIndex,kImgArr;
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
    self.navigationController.navigationBar.alpha =0;
    UINavigationBar *tabBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64.5)];
    [tabBar setBackgroundImage:[UIImage imageNamed:@"地图搜索_01.png"] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:tabBar];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    titleLabel.center =CGPointMake(160, 40);
    titleLabel.text = @"人的详情";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [tabBar addSubview:titleLabel];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    backBtn.frame = CGRectMake(0, 20, 40, 40);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_icon"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backToFormerVC) forControlEvents:UIControlEventTouchUpInside];
    [tabBar addSubview:backBtn];
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,64.5, 320, kContentHeight) style:UITableViewStyleGrouped];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    
    KindIndex = @[@"联系方式",@"个人背景",@"关联项目"];
    kImgArr = @[@"message",@"telephone"];
    
}

-(void)backToFormerVC
{
    self.navigationController.navigationBar.alpha =1;
    [self.navigationController popViewControllerAnimated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;//决定tableview的section
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1) {
        return 2;
    }
    if (section ==2) {
        return 1;
    }
    return 3;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            static  NSString *identifier3 = @"PImgCell";
            PImgCell * cell1 = (PImgCell *)[tableView dequeueReusableCellWithIdentifier:identifier3];
            if (!cell1) {
                cell1 = [[PImgCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier3];
            }
            cell1.bgImgview.image = [UIImage imageNamed:@"123"];
            cell1.userIcon.image = [UIImage imageNamed:@"1"];
            cell1.userLabel.text = @"Jack";
            cell1.companyLabel.text =@"miminfhiufdiu";
            cell1.positionLabel.text = @"ihihuuhuhuhu";
            return cell1;

        }if (indexPath.row==1) {
            static NSString *identifier = @"Cell";
            UITableViewCell *cell2 =[tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell2) {
                cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            
            UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 150, 30)];
            companyLabel.textAlignment = NSTextAlignmentLeft;
            companyLabel.text = @"上海深即网络";
            companyLabel.font = [UIFont systemFontOfSize:14];
            [cell2 addSubview:companyLabel];
            
            
            UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 80, 30)];
            positionLabel.textAlignment = NSTextAlignmentLeft;
            positionLabel.textColor = [UIColor grayColor];
            positionLabel.text = @"lisis";
            positionLabel.font = [UIFont systemFontOfSize:14];
            [cell2 addSubview:positionLabel];
            return cell2;

        }
    }
    if (indexPath.section ==1) {
        static NSString *identifier = @"Cell1";
        UITableViewCell *cell3 =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell3) {
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        UILabel *commonLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 150, 30)];
        commonLabel.textAlignment = NSTextAlignmentCenter;
        commonLabel.text = [kImgArr objectAtIndex:indexPath.row];
        commonLabel.font = [UIFont systemFontOfSize:14];
        [cell3 addSubview:commonLabel];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame = CGRectMake(250, 10, 30, 30);
        [rightBtn setBackgroundImage:[UIImage imageNamed:[kImgArr objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        rightBtn.tag = indexPath.row;
        [rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell3 addSubview:rightBtn];
        return cell3;

    }
    if (indexPath.section ==2) {
        static NSString *identifier = @"Cell2";
        UITableViewCell *cell4 =[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell4) {
            cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        UITextView *background = [[UITextView alloc] initWithFrame:CGRectMake(20, 0, 280, 150)];
        background.editable =NO;
        background.textAlignment = NSTextAlignmentLeft;
        background.text = @"oifdjbfddgk;lkhlfgljfdgjfshrfndkjfndiosdhfdfihdiufhudhfidfudfufifhi";
        background.font = [UIFont systemFontOfSize:14];
        [cell4 addSubview:background];
        return cell4;
        
    }

    static NSString *identifier = @"Cell3";
    UITableViewCell *cell5 =[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell5) {
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UIImageView  *icon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 10, 30, 30)];
    icon.image = [UIImage imageNamed:@"read"];
    [cell5 addSubview:icon];
    
    
    UILabel *ProjectLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 150, 30)];
    ProjectLabel.textAlignment = NSTextAlignmentLeft;
    ProjectLabel.text = @"项目名称";
    ProjectLabel.font = [UIFont systemFontOfSize:14];
    [cell5 addSubview:ProjectLabel];
    
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 80, 30)];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.text = @"项目地址";
    addressLabel.font = [UIFont systemFontOfSize:14];
    [cell5 addSubview:addressLabel];
    return cell5;

    
}

-(void)rightBtnClicked:(UIButton *)button
{

    
    
}

-(void)isSelected
{
//    notifyVC = [[NotificationViewController alloc] init];
//    notifyVC.delegate = self;
//    [self.navigationController pushViewController:notifyVC animated:NO];
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.001;
    }
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    if (section==0) {
        UIView *view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 0)];
        
        return view;
    }
    UIView *view = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, -7, 80, 30)];
    label.center = CGPointMake(160, 11.5);
    label.backgroundColor = [UIColor clearColor];
    label.text = [KindIndex objectAtIndex:section-1];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 250;
        }
        else{
            return 50;
        }
    }
    if (indexPath.section==1) {
        return 50;
    }
    if (indexPath.section==2) {
        return 150;
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
