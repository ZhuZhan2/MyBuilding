//
//  MoreCompanyViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-9-4.
//
//

#import "MoreCompanyViewController.h"
#import "MoreCompanyViewCell.h"
@interface MoreCompanyViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate>
@property(nonatomic)NSInteger memberNumber;
@property(nonatomic,strong)UITableView* tableView;
@property(nonatomic,strong)UISearchBar* searchBar;
@end

@implementation MoreCompanyViewController
-(id)initWithMemberNumber:(NSInteger)number{
    if ([self init]) {
        self.memberNumber=number;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.memberNumber=25;
    [self initSearchView];
    [self initMyTableViewAndNavi];
}

-(UIImage*)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)changeButtonImage:(UIButton*)button{
    [button setImage:[UIImage imageNamed:@"bg-addbutton-highlighted"] forState:UIControlStateNormal];
}
//===========================================================================
//UIScrollViewDelegate
//===========================================================================
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self.searchBar isFirstResponder]) {
        [self.searchBar resignFirstResponder];
    }
}

//===========================================================================
//UITableViewDataSource,UITableViewDelegate
//===========================================================================

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%d",indexPath.row-1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.memberNumber+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.row?94:50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreCompanyViewCell* cell=[MoreCompanyViewCell getCellWithTableView:tableView style:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    if (cell.contentView.subviews.count) {
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    //搜索栏
    if (indexPath.row==0) {
        [cell.contentView addSubview:self.searchBar];
        cell.myImageView.image=nil;
        cell.companyNameLabel.text=nil;
        cell.companyBusiness.text=nil;
        cell.companyIntroduce.text=nil;
        cell.accessoryView=nil;
    }
    //公司内容部分
    if (indexPath.row!=0) {
        UIView* separatorLine=[self getSeparatorLine];
        [cell.contentView addSubview:separatorLine];
        cell.myImageView.image=[UIImage imageNamed:@"公司－公司组织_12a.png"];
        cell.companyNameLabel.text=[NSString stringWithFormat:@"公司名称:上海%d有限公司",indexPath.row];
        cell.companyBusiness.text=[NSString stringWithFormat:@"公司行业:%d建筑",indexPath.row];
        cell.companyIntroduce.text=[NSString stringWithFormat:@"000%d位关注者",indexPath.row];
        cell.accessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"公司－公司组织_03a.png"]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(UIView*)getSeparatorLine{
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    separatorLine.backgroundColor=RGBCOLOR(229, 229, 229);
    separatorLine.center=CGPointMake(160, 93.5);
    return separatorLine;
}

//===========================================================================
//===========================================================================
//===========================================================================

-(void)initSearchView{
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.backgroundColor=[UIColor redColor];
    self.searchBar.tintColor = [UIColor grayColor];
    self.searchBar.backgroundImage=[self imageWithColor:RGBCOLOR(223, 223, 223)];
    self.searchBar.delegate=self;
}

-(void)initMyTableViewAndNavi{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-49) style:UITableViewStylePlain];
    [self.tableView registerClass:[MoreCompanyViewCell class] forCellReuseIdentifier:@"Cell"];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    self.title = @"公司组织";
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,nil]];
    
    
    //左back button
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,0,29,28.5)];
    [button setImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
}

-(void)dealloc{
    NSLog(@"more dealloc");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
