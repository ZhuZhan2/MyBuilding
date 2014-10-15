//
//  ResultsTableViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "ResultsTableViewController.h"
#import "ProjectApi.h"
#import "projectModel.h"
#import "ProjectTableViewCell.h"
#import "ProgramDetailViewController.h"
#import "MJRefresh.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"icon_04"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setFrame:CGRectMake(0, 0, 240, 31)];
    [searchBtn setBackgroundImage:[GetImagePath getImagePath:@"搜索结果_03a"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(serachClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:searchBtn];
    
    UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 8, 15, 15)];
    [searchImage setImage:[GetImagePath getImagePath:@"搜索结果_09a"]];
    [bgView addSubview:searchImage];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 200, 30)];
    label.textColor = [UIColor whiteColor];
    if(self.flag == 0){
        label.text = self.searchStr;
    }else{
        NSMutableString *str = [[NSMutableString alloc] init];
        NSString *string = nil;
        for(int i=0;i<self.dic.allKeys.count;i++){
            if(![[self.dic objectForKey:[self.dic allKeys][i]] isEqualToString:@""]){
                [str appendString:[NSString stringWithFormat:@"%@,",[self.dic objectForKey:[self.dic allKeys][i]]]];
            }
        }
        if(str.length !=0){
            string = [str substringToIndex:([str length]-1)];
        }
        label.text = string;
    }
    label.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:label];
    self.navigationItem.titleView = bgView;
    
    startIndex = 0;
    if(self.flag == 0){
        [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                showArr = posts;
                [self.tableView reloadData];
            }
        } startIndex:startIndex keywords:self.searchStr];
    }else{
        [ProjectApi AdvanceSearchProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                showArr = posts;
                [self.tableView reloadData];
            }
        } dic:self.dic startIndex:startIndex];
    }
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    self.tableView.separatorStyle = NO;
    
    //集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)serachClick{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    }else{
        startIndex = 0;
        [showArr removeAllObjects];
        if(self.flag == 0){
            [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    showArr = posts;
                    [self.tableView reloadData];
                    [self.tableView footerEndRefreshing];
                    [self.tableView headerEndRefreshing];
                }
            } startIndex:startIndex keywords:self.searchStr];
        }else{
            [ProjectApi AdvanceSearchProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    showArr = posts;
                    [self.tableView reloadData];
                    [self.tableView footerEndRefreshing];
                    [self.tableView headerEndRefreshing];
                }
            } dic:self.dic startIndex:startIndex];
        }
    }
}

- (void)footerRereshing
{
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
        [self.tableView footerEndRefreshing];
        [self.tableView headerEndRefreshing];
    }else{
        startIndex = startIndex +1;
        if(self.flag == 0){
            [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    [showArr addObjectsFromArray:posts];
                    [self.tableView reloadData];
                    [self.tableView footerEndRefreshing];
                    [self.tableView headerEndRefreshing];
                }
            } startIndex:startIndex keywords:self.searchStr];
        }else{
            [ProjectApi AdvanceSearchProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    [showArr addObjectsFromArray:posts];
                    [self.tableView reloadData];
                    [self.tableView footerEndRefreshing];
                    [self.tableView headerEndRefreshing];
                }
            } dic:self.dic startIndex:startIndex];
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return showArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 30;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"ProjectTableViewCell"];
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    projectModel *model = showArr[indexPath.row];
    if(!cell){
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model fromView:@"project"];
    }
    cell.indexRow=indexPath.row;
    cell.delegate = self;
    cell.selectionStyle = NO;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 291.5, 50)];
        [bgView setBackgroundColor:RGBCOLOR(239, 237, 237)];
        UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 160, 20)];
        countLabel.font = [UIFont fontWithName:@"GurmukhiMN" size:12];
        countLabel.textColor = GrayColor;
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.text = [NSString stringWithFormat:@"共计%d条",showArr.count];
        [bgView addSubview:countLabel];
        return bgView;
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProgramDetailViewController* vc=[[ProgramDetailViewController alloc]init];
    projectModel *model = showArr[indexPath.row];
    vc.model=model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addProjectCommentView:(int)index{
    NSLog(@"%d",index);
}
@end
