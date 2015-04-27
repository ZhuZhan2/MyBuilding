//
//  DemandAskPriceDetailController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/24.
//
//

#import "DemandAskPriceDetailController.h"
#import "AskPriceApi.h"
#import "MJRefresh.h"
#import "RKImageModel.h"
#import "WebViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "AcceptViewController.h"
#import "AccpetUserModel.h"
@interface DemandAskPriceDetailController ()<UIAlertViewDelegate,AcceptViewControllerDelegate>
@property(nonatomic)int startIndex;
@property(nonatomic,strong)AcceptViewController* acceptView;
@property(nonatomic,strong)NSMutableArray *acceptUserArr;
@end

@implementation DemandAskPriceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startIndex = 0;
    [self setupRefresh];
    [self loadList];
    [self firstNetWork];
}

-(void)firstNetWork{
    [AskPriceApi AcceptUsersListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.acceptUserArr = posts;
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } tradeId:self.askPriceModel.a_id noNetWork:^{
        [ErrorCode alert];
    }];
}

-(void)loadList{
    self.startIndex = 0;
    [AskPriceApi GetQuotesListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.detailModels=posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
    } providerId:self.quotesModel.a_loginId tradeCode:self.askPriceModel.a_tradeCode startIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(NSMutableArray *)detailModels{
    if (!_detailModels) {
        _detailModels=[NSMutableArray array];
    }
    return _detailModels;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailModels.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuotesDetailModel* dataModel=self.detailModels[indexPath.row];
    DemandDetailCellModel* cellModel=[self cellModelWithDataModel:dataModel];
    return [DemandDetailViewCell carculateTotalHeightWithModel:cellModel];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemandDetailViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (!cell) {
        cell=[[DemandDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell" delegate:self category:DemandControllerCategoryAskPriceController];
    }
    QuotesDetailModel* dataModel=self.detailModels[indexPath.row];
    DemandDetailCellModel* cellModel=[self cellModelWithDataModel:dataModel];
//    cellModel.isFinish=self.isFinish;
//    cellModel.indexPath=indexPath;
    cell.model=cellModel;
    return cell;
}

-(void)leftBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"leftBtnClickedWithIndexPath");
    if ([self.delegate respondsToSelector:@selector(demandDetailControllerLeftBtnClicked)]) {
        [self.delegate demandDetailControllerLeftBtnClicked];
    }
}

-(void)rightBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    if(self.acceptUserArr.count !=0){
        self.acceptView=[[AcceptViewController alloc]init];
        self.acceptView.invitedUserArr = self.acceptUserArr;
        self.acceptView.delegate=self;
        [self.superViewController presentPopupViewController:self.acceptView animationType:MJPopupViewAnimationFade flag:0];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"没有报价" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}


-(void)closeBtnClicked{
    NSMutableDictionary* dic=[@{@"createdBy":self.quotesModel.a_loginId,
                                @"bookBuildingId":self.askPriceModel.a_id,
                                @"tradeCode":self.askPriceModel.a_tradeCode
                                }mutableCopy];
    [AskPriceApi CloseQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关闭成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } dic:dic noNetWork:^{
        [ErrorCode alert];
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([self.delegate respondsToSelector:@selector(backView)]) {
        [self.delegate backView];
    }
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
    [AskPriceApi GetQuotesListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.detailModels removeAllObjects];
            self.detailModels=posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    } providerId:self.quotesModel.a_loginId tradeCode:self.askPriceModel.a_tradeCode startIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

- (void)footerRereshing
{
    [AskPriceApi GetQuotesListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex++;
            [self.detailModels addObjectsFromArray:posts];
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    } providerId:self.quotesModel.a_loginId tradeCode:self.askPriceModel.a_tradeCode startIndex:self.startIndex+1 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

-(void)imageCilckWithDemandDetailViewCell:(RKImageModel *)model{
    WebViewController *view = [[WebViewController alloc] init];
    view.url = model.bigImageUrl;
    view.type = model.type;
    view.name = model.name;
    [self.superViewController.navigationController pushViewController:view animated:YES];
}

-(void)acceptViewSureBtnClicked:(NSMutableArray *)arr{
    [self.superViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    NSMutableString *string = [[NSMutableString alloc] init];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [string appendString:[NSString stringWithFormat:@"%@,",obj]];
    }];
    if(string.length !=0){
        NSString *newStr = [string substringWithRange:NSMakeRange(0,string.length-1)];
        NSMutableDictionary* dic=[@{@"id":newStr,@"bookBuildingId":self.askPriceModel.a_id}mutableCopy];
        [AskPriceApi AcceptQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"采纳成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }
}

-(void)acceptViewCancelBtnClicked{
    [self.superViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
@end
