//
//  ALLProjectViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/28.
//
//

#import "ALLProjectViewController.h"
#import "ProjectTableViewCell.h"
#import "PorjectCommentTableViewController.h"
#import "ProjectApi.h"
#import "LoadingView.h"
#import "MyTableView.h"
@interface ALLProjectViewController ()<UITableViewDataSource,UITableViewDelegate,ProjectTableViewCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)LoadingView *loadingView;
@end

@implementation ALLProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self loadList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadList{
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view];
    [ProjectApi GetPiProjectSeachWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts[0];
            if(self.showArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                [self loadList];
            }];
        }
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
    } startIndex:0 keywords:@"" noNetWork:^{
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBCOLOR(239, 237, 237);
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(NSMutableArray *)showArr{
    if(!_showArr){
        _showArr = [NSMutableArray array];
    }
    return _showArr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.showArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"ProjectTableViewCell"];
    ProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    projectModel *model = self.showArr[indexPath.row];
    if(!cell){
        cell = [[ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model fromView:@"project"];
    }
    cell.indexRow=(int)indexPath.row;
    cell.delegate = self;
    cell.model = model;
    cell.selectionStyle = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 290;
}

-(void)addProjectCommentView:(int)index{
    projectModel *model = self.showArr[index];
    PorjectCommentTableViewController *projectCommentView = [[PorjectCommentTableViewController alloc] init];
    projectCommentView.projectId = model.a_id;
    projectCommentView.projectName = model.a_projectName;
    [self.navigationController pushViewController:projectCommentView animated:YES];
}
@end
