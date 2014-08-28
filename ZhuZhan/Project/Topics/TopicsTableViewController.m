//
//  TopicsTableViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "TopicsTableViewController.h"
#import "ProjectApi.h"
#import "TopicsTableViewCell.h"
#import "TopicsModel.h"
@interface TopicsTableViewController ()

@end

@implementation TopicsTableViewController

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
    
    self.title = @"项目专题";
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    self.tableView.separatorStyle = NO;
    [ProjectApi GetPiProjectSeminarWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return showArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"TopicsTableViewCell"];
    TopicsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    TopicsModel *model = showArr[indexPath.row];
    if(!cell){
        cell = [[TopicsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
    }
    cell.selectionStyle = NO;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    detailView = [[TopicsDetailTableViewController alloc] init];
    detailView.model = showArr[indexPath.row];
    [self.navigationController pushViewController:detailView animated:YES];
}


@end
