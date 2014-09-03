//
//  TopicsDetailTableViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "TopicsDetailTableViewController.h"
#import "TopicsDetailTableViewCell.h"
#import "ProjectTableViewCell.h"
#import "ProjectApi.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
@interface TopicsDetailTableViewController ()

@end

@implementation TopicsDetailTableViewController

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
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.title = @"专题详情";
//    [ProjectApi GetSeminarProjectsWithBlock:^(NSMutableArray *posts, NSError *error) {
//        if(!error){
//            showArr = posts;
//        }
//    } Id:self.model.a_id];
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    self.tableView.separatorStyle = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
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
    return 2+showArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 363;
    }else if(indexPath.row == 1){
        return 45;
    }
    return 280;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0){
        NSString *CellIdentifier = [NSString stringWithFormat:@"TopicsDetailTableViewCell"];
        TopicsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[TopicsDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:self.model];
        }
        cell.selectionStyle = NO;
        
        return cell;
    }else if(indexPath.row == 1){
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
        cell.selectionStyle = NO;
        UILabel *projectCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 320, 20)];
        projectCount.text = self.model.a_projectCount;
        projectCount.textColor = [UIColor blueColor];
        projectCount.font = [UIFont systemFontOfSize:17];
        projectCount.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:projectCount];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 320, 20)];
        label.text = @"关联项目";
        label.textColor = [UIColor blueColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"ProjectTableViewCell"];
        ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        projectModel *model = showArr[indexPath.row-2];
        if(!cell){
            cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model fromView:@"topics"];
        }
        cell.selectionStyle = NO;
        return cell;
    }
    return nil;
}

@end
