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
@interface ContractsListSearchController ()
@property(nonatomic,strong)NSString *keyWords;
@property(nonatomic,strong)NSMutableArray* models;
@end

@implementation ContractsListSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self setSearchBarTableViewBackColor:AllBackDeepGrayColor];
    [self.searchBar becomeFirstResponder];
}

-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count +++> %d",(int)self.models.count);
    return self.models.count;
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"height==>%f",[ContractListCell carculateTotalHeightWithContents:self.models[indexPath.row]]);
    return [ContractListCell carculateTotalHeightWithContents:self.models[indexPath.row]];
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"searchBarTableView");
    ContractListCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ContractListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    
    ContractsListSingleModel* singleModel=self.models[indexPath.row];
    NSLog(@"===>%@",self.models[indexPath.row]);
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

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //[super searchBarSearchButtonClicked:searchBar];
    [self searchListWithKeyword:searchBar.text];
}

-(void)searchListWithKeyword:(NSString*)keyword{
    self.keyWords = keyword;
    [ContractsApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
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
@end
