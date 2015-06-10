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
#import "MyTableView.h"
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
    [self initStageChooseViewWithStages:@[@"询价提醒",@"报价提醒",@"合同提醒"]  numbers:nil underLineIsWhole:NO normalColor:[UIColor blackColor] highlightColor:BlueColor];
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
    }else{
        [self getContractsInfo:model.a_messageType contractsId:model.a_messageSourceId];
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
//                [self.showArr removeObjectAtIndex:indexPath.row];
//                NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
//                [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                [self loadList];
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

////供应商合同
//-(void)providerContractsWithId:(NSString *)ID{
//    [self repealContractsDetailWithId:ID sucessBlock:^(ContractsRepealModel *model) {
//        
//    } needStop:YES];
//    
//    return;
//    [self providerContractsDetailWithId:ID sucessBlock:^(ContractsMainClauseModel *model) {
//        if([model.a_fileName isEqualToString:@""]){
//            MainContractsBaseController *view = [[MainContractsBaseController alloc] init];
//            view.mainClauseModel = model;
//            [self.navigationController pushViewController:view animated:YES];
//        }
//    } needStop:YES];
//}
//
-(void)getContractsInfo:(NSString *)type contractsId:(NSString *)contractsId{
    [AskPriceMessageApi GetDetailsForIdWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            ContractsBaseViewController* pushVC;
            NSDictionary* dic=posts[0];
            NSInteger recordType=[dic[@"recordType"] integerValue];
            switch (recordType) {
                case 0:
                case 2:{
                    MainContractsBaseController* vc=[[MainContractsBaseController alloc]init];
                    ContractsMainClauseModel* model=[[ContractsMainClauseModel alloc]init];
                    model.dict=dic;
                    vc.mainClauseModel=model;
                    pushVC=vc;
                    break;
                }
                case 1:{
                    ProviderContractsController* vc=[[ProviderContractsController alloc]init];
                    ContractsMainClauseModel* model=[[ContractsMainClauseModel alloc]init];
                    model.dict=dic;
                    vc.mainClauseModel=model;
                    pushVC=vc;
                    break;
                }
                case 3:{
                    SalerContractsController* vc=[[SalerContractsController alloc]init];
                    ContractsSalerModel* model=[[ContractsSalerModel alloc]init];
                    model.dict=dic;
                    vc.salerModel=model;
                    pushVC=vc;
                    break;
                }
                case 4:{
                    RepealContractsController* vc=[[RepealContractsController alloc]init];
                    ContractsRepealModel* model=[[ContractsRepealModel alloc]init];
                    model.dict=dic;
                    vc.repealModel=model;
                    pushVC=vc;
                    break;
                }
            }
            [self.navigationController pushViewController:pushVC animated:YES];

        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self stopLoadingView];
    } messageType:type contractId:contractsId noNetWork:^{
        self.tableView.scrollEnabled=NO;
        [self stopLoadingView];
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            self.tableView.scrollEnabled=YES;
            [self loadList];
        }];
    }];
}
//
////销售合同
//-(void)salerContractsWithId:(NSString *)ID{
//    [self salerContractsDetailWithId:ID sucessBlock:^(ContractsSalerModel *model) {
//        SalerContractsController *view = [[SalerContractsController alloc] init];
//        view.salerModel = model;
//        [self.navigationController pushViewController:view animated:YES];
//    } needStop:YES];
//}
//
////撤销合同
//-(void)repealContractsWithId:(NSString *)ID{
//    [self repealContractsDetailWithId:ID sucessBlock:^(ContractsRepealModel *model) {
//        RepealContractsController *view = [[RepealContractsController alloc] init];
//        view.repealModel = model;
//        [self.navigationController pushViewController:view animated:YES];
//    } needStop:YES];
//}

////主条款和供应商合同详情
//-(void)providerContractsDetailWithId:(NSString*)Id sucessBlock:(void(^)(ContractsMainClauseModel* model))sucessBlock needStop:(BOOL)needStop{
//    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
//    [dic setObject:Id forKey:@"contractId"];
//    [ContractsApi PostDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
//        if(!error){
//            if (sucessBlock) {
//                sucessBlock(posts[0]);
//            }
//        }else{
//            if([ErrorCode errorCode:error] == 403){
//                [LoginAgain AddLoginView:NO];
//            }else{
//                [ErrorCode alert];
//            }
//        }
//        if (needStop) {
//            [self stopLoadingView];
//        }
//    } dic:dic noNetWork:^{
//        self.tableView.scrollEnabled=NO;
//        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
//            self.tableView.scrollEnabled=YES;
//            [self loadList];
//        }];
//    }];
//}


////销售方合同详情
//-(void)salerContractsDetailWithId:(NSString*)Id sucessBlock:(void(^)(ContractsSalerModel* model))sucessBlock needStop:(BOOL)needStop{
//    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
//    [dic setObject:Id forKey:@"contractId"];
//    [ContractsApi PostSalesDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
//        if(!error){
//            if (sucessBlock) {
//                sucessBlock(posts[0]);
//            }
//        }else{
//            if([ErrorCode errorCode:error] == 403){
//                [LoginAgain AddLoginView:NO];
//            }else{
//                [ErrorCode alert];
//            }
//        }
//        if (needStop) {
//            [self stopLoadingView];
//        }
//    } dic:dic noNetWork:^{
//        self.tableView.scrollEnabled=NO;
//        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
//            self.tableView.scrollEnabled=YES;
//            [self loadList];
//        }];
//    }];
//}
//
////撤销合同详情
//-(void)repealContractsDetailWithId:(NSString*)Id sucessBlock:(void(^)(ContractsRepealModel* model))sucessBlock needStop:(BOOL)needStop{
//    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
//    [dic setObject:Id forKey:@"contractId"];
//    [ContractsApi PostRevocationDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
//        if(!error){
//            if (sucessBlock) {
//                sucessBlock(posts[0]);
//            }
//        }else{
//            if([ErrorCode errorCode:error] == 403){
//                [LoginAgain AddLoginView:NO];
//            }else{
//                [ErrorCode alert];
//            }
//        }
//        if (needStop) {
//            [self stopLoadingView];
//        }
//    } dic:dic noNetWork:^{
//        self.tableView.scrollEnabled=NO;
//        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
//            self.tableView.scrollEnabled=YES;
//            [self loadList];
//        }];
//    }];
//
//}
@end
