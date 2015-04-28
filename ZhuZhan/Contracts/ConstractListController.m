//
//  ConstractListController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import "ConstractListController.h"
#import "ContractListCell.h"
#import "ContractsBaseViewController.h"
#import "DemandStageChooseController.h"
#import "ContractsListSearchController.h"
#import "ContractsApi.h"
#import "ContractsListSingleModel.h"
#import "LoginSqlite.h"
#import "MainContractsBaseController.h"
#import "ProviderContractsController.h"
#import "SalerContractsController.h"
#import "RepealContractsController.h"
#import "MJRefresh.h"
#import "MyTableView.h"
@interface ConstractListController ()<DemandStageChooseControllerDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property (nonatomic)NSInteger nowStage;
@property (nonatomic,copy,readonly)NSString* nowStageStr;
@property(nonatomic)int startIndex;
/*
 所有合同	0
 主条款列表	1
 供应商合同	2
 销售合同	3
 撤销合同	4
 */
@property(nonatomic,strong)NSString *archiveStatus;
@end

@implementation ConstractListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"全部",@"进行中",@"已完成",@"已关闭"]  numbers:@[@"0",@"0",@"0",@"0"]];
    
    [self initTableView];
    [self initTableViewExtra];
    //集成刷新控件
    [self setupRefresh];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"ConstractListControllerReloadDataNotification" object:nil];
}

-(void)reload{
    [self headerRereshing];
}

-(void)initTableViewExtra{
    self.tableView.backgroundColor=AllBackDeepGrayColor;
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithImage:self.nowStage?[GetImagePath getImagePath:@"搜索按钮"]:nil];
    [self initTitleViewWithTitle:@"佣金合同列表"];
}

-(void)initTitleViewWithTitle:(NSString*)title{
    NSString* titleStr=title;
    UIFont* font=[UIFont boldSystemFontOfSize:19];
    UILabel* titleLabel=[[UILabel alloc]init];
    titleLabel.text=titleStr;
    titleLabel.font=font;
    titleLabel.textColor=[UIColor whiteColor];
    CGSize size=[titleStr boundingRectWithSize:CGSizeMake(9999, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    titleLabel.frame=CGRectMake(0, 0, size.width, size.height);
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake( 0, 0, 15, 9)];
    imageView.center=CGPointMake(CGRectGetMaxX(titleLabel.frame)+CGRectGetWidth(imageView.frame)*0.5+5, CGRectGetMidY(titleLabel.frame));
    imageView.image=[GetImagePath getImagePath:@"交易_页头箭头"];
    
    CGRect frame=titleLabel.frame;
    frame.size.width+=CGRectGetWidth(imageView.frame);
    
    UIButton* button=[[UIButton alloc]initWithFrame:frame];
    [button addTarget:self action:@selector(selectStage) forControlEvents:UIControlEventTouchUpInside];
    [button addSubview:titleLabel];
    [button addSubview:imageView];
    
    self.navigationItem.titleView=button;
}

-(void)selectStage{
    DemandStageChooseController* vc=[[DemandStageChooseController alloc]initWithIndex:self.nowStage stageNames:@[@"全部佣金合同",@"供应商佣金合同",@"销售佣金合同",@"佣金撤销流程"]];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)rightBtnClicked{
    ContractsListSearchController* vc=[[ContractsListSearchController alloc]init];
    vc.archiveStatus = self.archiveStatus;
    vc.nowStageStr = self.nowStageStr;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadList{
    self.startIndex = 0;
    [ContractsApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.showArr=posts[0];
            //if([self.archiveStatus isEqualToString:@""]){
                [self.stageChooseView changeNumbers:@[posts[1][@"totalCount"],posts[1][@"inProgressCount"],posts[1][@"completeCount"],posts[1][@"closeCount"]]];
            //}
            if(self.showArr.count == 0){
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
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
    } keyWords:@"" archiveStatus:self.archiveStatus contractsType:self.nowStageStr startIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
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
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.startIndex = 0;
    [ContractsApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self.showArr removeAllObjects];
            self.showArr=posts[0];
            //if([self.archiveStatus isEqualToString:@""]){
                [self.stageChooseView changeNumbers:@[posts[1][@"totalCount"],posts[1][@"inProgressCount"],posts[1][@"completeCount"],posts[1][@"closeCount"]]];
            //}
            if(self.showArr.count == 0){
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
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    } keyWords:@"" archiveStatus:self.archiveStatus contractsType:self.nowStageStr startIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

- (void)footerRereshing
{
    [ContractsApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.startIndex++;
            [self.showArr addObjectsFromArray:posts[0]];
            //if([self.archiveStatus isEqualToString:@""]){
                [self.stageChooseView changeNumbers:@[posts[1][@"totalCount"],posts[1][@"inProgressCount"],posts[1][@"completeCount"],posts[1][@"closeCount"]]];
            //}
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    } keyWords:@"" archiveStatus:self.archiveStatus contractsType:self.nowStageStr startIndex:self.startIndex+1 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(NSMutableArray *)showArr{
    if (!_showArr) {
        _showArr=[NSMutableArray array];
    }
    return _showArr;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ContractListCell carculateTotalHeightWithContents:self.showArr[indexPath.row]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContractListCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ContractListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    
    ContractsListSingleModel* singleModel=self.showArr[indexPath.row];
    NSString* saleName=singleModel.a_salerName;
    NSString* providerName=singleModel.a_providerName;
    NSString* provider=singleModel.a_providerCompanyName;
    NSString* saler=singleModel.a_salerCompanyName;
    NSString* contractsName=singleModel.a_contractsType;
    NSString* contractsStatus=singleModel.a_archiveStatus;
    NSInteger index=[@[@"进行中",@"已完成",@"已关闭"] indexOfObject:contractsStatus];
    NSArray* colors=@[BlueColor,AllGreenColor,AllLightGrayColor];
    cell.contents=@[saleName,providerName,saler,provider,colors[index],contractsName,contractsStatus];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContractsListSingleModel* singleModel=self.showArr[indexPath.row];
    
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
    }
    pushVC.listSingleModel=singleModel;
    
    [self.navigationController pushViewController:pushVC animated:YES];
}


-(void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    NSArray* archiveStatus=@[@"",@"0",@"1",@"2"];
    self.archiveStatus=archiveStatus[stageNumber];
    [self loadList];
}

-(void)finishSelectedWithStageName:(NSString *)stageName index:(int)index{
    self.nowStage=index;
    NSArray* titles=@[@"佣金合同列表",@"供应商佣金合同",@"销售佣金合同",@"佣金撤销流程"];
    if (index==0) {
        [self setRightBtnWithImage:nil];

    }else{
        [self setRightBtnWithImage:[GetImagePath getImagePath:@"搜索按钮"]];

    }
    [self initTitleViewWithTitle:titles[index]];
    [self loadList];
}

-(NSString *)nowStageStr{
    return @[@"0",@"1",@"2",@"3"][self.nowStage];
}

-(NSString *)archiveStatus{
    if (!_archiveStatus) {
        _archiveStatus=@"";
    }
    return _archiveStatus;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ConstractListControllerReloadDataNotification" object:nil];
}
@end
