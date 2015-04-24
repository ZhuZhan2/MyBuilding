//
//  ContractsListSearchController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/31.
//
//

#import "ContractsListSearchController.h"
#import "ContractsApi.h"
#import "ContractListCell.h"
#import "ContractsListSingleModel.h"
#import "MainContractsBaseController.h"
#import "ProviderContractsController.h"
#import "SalerContractsController.h"
#import "RepealContractsController.h"
#import "MJRefresh.h"
@interface ContractsListSearchController ()
@property(nonatomic,strong)NSMutableArray* models;
@property(nonatomic,strong)NSString *keyWords;
@property (nonatomic)int startIndex;
@end

@implementation ContractsListSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self setSearchBarTableViewBackColor:AllBackDeepGrayColor];
    [self.searchBar becomeFirstResponder];
    
    //集成刷新控件
    [self setupRefresh];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"ConstractListControllerReloadDataNotification" object:nil];
}

-(void)reload{
    [self headerRereshing];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.searchBarTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    [self.searchBarTableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [super searchBarSearchButtonClicked:searchBar];
    [self searchListWithKeyword:searchBar.text];
}

-(void)searchListWithKeyword:(NSString*)keyword{
    self.keyWords = keyword;
    [ContractsApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.startIndex=0;
            self.models=posts[0];
            [self.searchBarTableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } keyWords:keyword archiveStatus:self.archiveStatus contractsType:self.nowStageStr startIndex:0 noNetWork:^{
        [ErrorCode alert];
    }];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    [ContractsApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self.models removeAllObjects];
            self.models = posts[0];
            [self.searchBarTableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self.searchBarTableView headerEndRefreshing];
    } keyWords:self.keyWords archiveStatus:self.archiveStatus contractsType:self.nowStageStr startIndex:0 noNetWork:^{
        [ErrorCode alert];
    }];
}

- (void)footerRereshing
{
    [ContractsApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.startIndex++;
            [self.models addObjectsFromArray:posts[0]];
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self.searchBarTableView footerEndRefreshing];
    } keyWords:self.keyWords archiveStatus:self.archiveStatus contractsType:self.nowStageStr startIndex:self.startIndex+1 noNetWork:^{
        [ErrorCode alert];
    }];
}

-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}
-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ContractListCell carculateTotalHeightWithContents:self.models[indexPath.row]];
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContractListCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ContractListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    
    ContractsListSingleModel* singleModel=self.models[indexPath.row];
    NSString* sendName=singleModel.a_createdBy;
    NSString* receiveName=singleModel.a_recipientName;
    NSString* provider=singleModel.a_providerCompanyName;
    NSString* saler=singleModel.a_salerCompanyName;
    NSString* contractsName=singleModel.a_contractsType;
    NSString* contractsStatus=singleModel.a_archiveStatus;
    NSInteger index=[@[@"进行中",@"已完成",@"已关闭"] indexOfObject:contractsStatus];
    NSArray* colors=@[BlueColor,AllGreenColor,AllLightGrayColor];
    cell.contents=@[sendName,receiveName,saler,provider,colors[index],contractsName,contractsStatus];
    return cell;
}

-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContractsListSingleModel* singleModel=self.models[indexPath.row];
    
    ContractsBaseViewController* pushVC;
    BOOL isSaler=singleModel.a_isSaler;
    BOOL hasSaleFile=singleModel.a_saleHas;
    BOOL hasProviderFile=singleModel.a_provideHas;
    BOOL hasRepealFile=singleModel.a_contractsTypeInt==3;
    
    if (!hasSaleFile&&!hasProviderFile&&!hasRepealFile) {
        MainContractsBaseController* vc=[[MainContractsBaseController alloc]init];
        pushVC=vc;
    }else if (hasRepealFile){
        RepealContractsController* vc=[[RepealContractsController alloc]init];
        pushVC=vc;
        //供应商合同阶段
    }else if (!isSaler){
        if (hasProviderFile) {
            ProviderContractsController* vc=[[ProviderContractsController alloc]init];
            pushVC=vc;
        }else{
            MainContractsBaseController* vc=[[MainContractsBaseController alloc]init];
            pushVC=vc;
        }
        //销售方合同阶段
    }else if (isSaler){
        if (hasSaleFile) {
            SalerContractsController* vc=[[SalerContractsController alloc]init];
            pushVC=vc;
        }else{
            MainContractsBaseController* vc=[[MainContractsBaseController alloc]init];
            pushVC=vc;
        }
    }else{
        [self error];
    }
    pushVC.listSingleModel=singleModel;
    
    [self.navigationController pushViewController:pushVC animated:YES];
    
    self.searchBarAnimationBackView.hidden=YES;
}

-(void)error{
    [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"请测试记下当前的合同各个状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self viewAppearOrDisappear:YES];
}

-(void)viewAppearOrDisappear:(BOOL)isAppear{
    self.navigationController.navigationBarHidden=isAppear;
    [[UIApplication sharedApplication] setStatusBarStyle:isAppear?UIStatusBarStyleDefault:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self viewAppearOrDisappear:NO];
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
}

-(void)getSearchBarBackBtn{
    UIView* button=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.searchBar.frame)+64+CGRectGetHeight(self.stageChooseView.frame), kScreenWidth, CGRectGetHeight(self.view.frame))];
    button.backgroundColor=[UIColor whiteColor];
    self.searchBarBackBtn=button;
    [self.view addSubview:self.searchBarBackBtn];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ConstractListControllerReloadDataNotification" object:nil];
}
@end
