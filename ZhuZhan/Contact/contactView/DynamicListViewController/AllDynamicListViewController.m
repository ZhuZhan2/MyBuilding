//
//  AllDynamicListViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/1.
//
//

#import "AllDynamicListViewController.h"
#import "MJRefresh.h"
#import "ContactModel.h"
#import "LoadingView.h"
#import "ActivesModel.h"
#import "MyTableView.h"

@interface AllDynamicListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic,strong)NSMutableArray *modelsArr;
@property(nonatomic)int startIndex;
@end

@implementation AllDynamicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.startIndex = 0;
    [self firstNetWork];
    //集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,kScreenHeight-160)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(NSMutableArray *)modelsArr{
    if(!_modelsArr){
        _modelsArr = [NSMutableArray array];
    }
    return _modelsArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = [NSString stringWithFormat:@"productCell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = NO;
    return cell;
}

-(void)firstNetWork{
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view];
    [ContactModel AllActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.modelsArr = posts;
            if(self.modelsArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
    } startIndex:0 noNetWork:^{
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
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
- (void)headerRereshing{
    self.startIndex = 0;
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view];
    [ContactModel AllActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.modelsArr removeAllObjects];
            self.modelsArr = posts;
            if(self.modelsArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        [self.tableView headerEndRefreshing];
    } startIndex:0 noNetWork:^{
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

- (void)footerRereshing{
    [ContactModel AllActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex ++;
            [self.modelsArr addObjectsFromArray:posts];
            [MyTableView reloadDataWithTableView:self.tableView];
            if(self.modelsArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    } startIndex:self.startIndex+1 noNetWork:^{
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}
@end
