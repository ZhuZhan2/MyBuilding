//
//  AskPriceMessageViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/16.
//
//

#import "AskPriceMessageViewController.h"
#import "AskPriceMessageCell.h"
#import "AskPriceMessageModel.h"
#import "MJRefresh.h"
#import "AskPriceMessageApi.h"
#import "AskPriceDetailViewController.h"
#import "QuotesDetailViewController.h"
#import "MainContractsBaseController.h"
#import "ProviderContractsController.h"
#import "SalerContractsController.h"
#import "RepealContractsController.h"
#import "ContractsApi.h"
#import "ContractsMainClauseModel.h"
#import "ContractsRepealModel.h"
#import "ContractsSalerModel.h"
@interface AskPriceMessageViewController ()
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)NSString *type;
@property(nonatomic)int startIndex;
@property(nonatomic,strong)UIActivityIndicatorView* activityView;
@property(nonatomic,strong)UIView* loadingView;
@end

@implementation AskPriceMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startIndex = 0;
    [self initNavi];
    [self initStageChooseViewWithStages:@[@"询价提醒",@"报价提醒",@"合同提醒"]  numbers:nil];
    [self initTableView];
    //集成刷新控件
    [self setupRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIActivityIndicatorView *)activityView{
    if (!_activityView) {
        _activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    return _activityView;
}

-(void)startLoadingView{
    [self.activityView startAnimating];
    [self.navigationController.view addSubview:self.loadingView];
}

-(void)stopLoadingView{
    [self.activityView stopAnimating];
    [self.loadingView removeFromSuperview];
}

-(UIView *)loadingView{
    if (!_loadingView) {
        _loadingView=[[UIView alloc]initWithFrame:self.view.bounds];
        _loadingView.backgroundColor=[[UIColor alloc]initWithRed:0 green:0 blue:0 alpha:.5];
        
        self.activityView.center=_loadingView.center;
        [_loadingView addSubview:self.activityView];
    }
    return _loadingView;
}

-(void)loadList{
    self.startIndex = 0;
    [AskPriceMessageApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.showArr = posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                self.tableView.scrollEnabled=NO;
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    self.tableView.scrollEnabled=YES;
                    [self loadList];
                }];
            }
        }
    } messageType:self.type startIndex:0 noNetWork:^{
        self.tableView.scrollEnabled=NO;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
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
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.startIndex = 0;
    [AskPriceMessageApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.showArr removeAllObjects];
            self.showArr = posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                self.tableView.scrollEnabled=NO;
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    self.tableView.scrollEnabled=YES;
                    [self loadList];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    } messageType:self.type startIndex:0 noNetWork:^{
        self.tableView.scrollEnabled=NO;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
            [self loadList];
        }];
    }];
}

- (void)footerRereshing
{
    [AskPriceMessageApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex ++;
            [self.showArr addObjectsFromArray:posts];
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                self.tableView.scrollEnabled=NO;
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    self.tableView.scrollEnabled=YES;
                    [self loadList];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    } messageType:self.type startIndex:self.startIndex+1 noNetWork:^{
        self.tableView.scrollEnabled=NO;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
            [self loadList];
        }];
    }];
}

-(void)initNavi{
    self.title = @"交易提醒";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.needAnimaiton=YES;
}

-(NSMutableArray *)showArr{
    if(!_showArr){
        _showArr = [[NSMutableArray alloc] init];
    }
    return _showArr;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.showArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGSize defaultSize = DEFAULT_CELL_SIZE;
    CGSize cellSize = [AskPriceMessageCell sizeForCellWithDefaultSize:defaultSize setupCellBlock:^id(id<CellHeightDelegate> cellToSetup) {
        AskPriceMessageModel *model = self.showArr[indexPath.row];
        [((AskPriceMessageCell *)cellToSetup) setModel:model];
        return cellToSetup;
    }];
    return cellSize.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self startLoadingView];
    AskPriceMessageModel *model = self.showArr[indexPath.row];
    if([model.a_messageType isEqualToString:@"06"]){
        AskPriceDetailViewController *view = [[AskPriceDetailViewController alloc] init];
        view.tradId = model.a_messageSourceId;
        [self.navigationController pushViewController:view animated:YES];
        [self stopLoadingView];
    }else if ([model.a_messageType isEqualToString:@"07"]){
        QuotesDetailViewController *view = [[QuotesDetailViewController alloc] init];
        view.tradId = model.a_messageSourceId;
        [self.navigationController pushViewController:view animated:YES];
        [self stopLoadingView];
    }else if ([model.a_messageType isEqualToString:@"08"]){
        NSLog(@"08");
        [self MainContractsData:model.a_messageSourceId];
    }else if ([model.a_messageType isEqualToString:@"09"]){
        [self ProviderContractsData:model.a_messageSourceId];
    }else if ([model.a_messageType isEqualToString:@"10"]){
        [self RepealContractsData:model.a_messageSourceId];
        //RepealContractsController *view = [[RepealContractsController alloc] init];
        //[self.navigationController pushViewController:view animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AskPriceMessageCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AskPriceMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    AskPriceMessageModel *model = self.showArr[indexPath.row];
    cell.model = model;
    cell.selectionStyle = NO;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        AskPriceMessageModel* model=self.showArr[indexPath.row];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:model.a_id forKey:@"messageId"];
        [AskPriceMessageApi DeleteMessageWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"删除成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
                [self.showArr removeObjectAtIndex:indexPath.row];
                NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
                [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            self.tableView.scrollEnabled=NO;
            [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                self.tableView.scrollEnabled=YES;
                [self loadList];
            }];
        }];
    }
}

-(void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    NSArray* stages=@[@"06",@"07",@"08"];
    self.type=stages[stageNumber];
    [self loadList];
}

//主条款或者供应商合同
-(void)MainContractsData:(NSString *)ID{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setObject:ID forKey:@"contractId"];
    [ContractsApi PostDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            ContractsMainClauseModel* mainModel=posts[0];
            if([mainModel.a_fileName isEqualToString:@""]){
                MainContractsBaseController *view = [[MainContractsBaseController alloc] init];
                view.mainClauseModel = mainModel;
                [self.navigationController pushViewController:view animated:YES];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self stopLoadingView];
    } dic:dic noNetWork:^{
        self.tableView.scrollEnabled=NO;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
            [self loadList];
        }];
    }];
}

//销售合同
-(void)ProviderContractsData:(NSString *)ID{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setObject:ID forKey:@"contractId"];
    [ContractsApi PostSalesDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            ContractsSalerModel *saleModel = posts[0];
            SalerContractsController *view = [[SalerContractsController alloc] init];
            view.salerModel = saleModel;
            [self.navigationController pushViewController:view animated:YES];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self stopLoadingView];
    } dic:dic noNetWork:^{
        self.tableView.scrollEnabled=NO;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
            [self loadList];
        }];
    }];
}

//撤销合同
-(void)RepealContractsData:(NSString *)ID{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setObject:ID forKey:@"contractId"];
    [ContractsApi PostRevocationDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            ContractsRepealModel *repealModel = posts[0];
            RepealContractsController *view = [[RepealContractsController alloc] init];
            view.repealModel = repealModel;
            [self.navigationController pushViewController:view animated:YES];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self stopLoadingView];
    } dic:dic noNetWork:^{
        self.tableView.scrollEnabled=NO;
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
            [self loadList];
        }];
    }];
}
@end
