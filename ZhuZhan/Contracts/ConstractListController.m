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
@interface ConstractListController ()<DemandStageChooseControllerDelegate>
@property(nonatomic,strong)NSMutableArray *showArr;
@property (nonatomic)NSInteger nowStage;
@property (nonatomic,copy,readonly)NSString* nowStageStr;
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
    [self initStageChooseViewWithStages:@[@"全部",@"进行中",@"已完成",@"已关闭"]  numbers:@[@"33",@"44",@"55",@"66"]];
    [self initTableView];
    [self initTableViewExtra];
}

-(void)initTableViewExtra{
    self.tableView.backgroundColor=AllBackDeepGrayColor;
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithImage:[GetImagePath getImagePath:@"搜索按钮"]];
    [self initTitleViewWithTitle:@"佣金合同列表"];
}

-(void)initTitleViewWithTitle:(NSString*)title{
    NSString* titleStr=title;
    UIFont* font=[UIFont fontWithName:@"GurmukhiMN-Bold" size:19];
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
    UIViewController* vc=[[ContractsListSearchController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadList{
    [ContractsApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.showArr=posts;
            [self.tableView reloadData];
        }
    } keyWords:@"" archiveStatus:self.archiveStatus contractsType:self.nowStageStr startIndex:0 noNetWork:nil];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ContractsListSingleModel* singleModel=self.showArr[indexPath.row];
    UIViewController* pushVC;
    BOOL hasFile=![singleModel.a_fileName isEqualToString:@""];
    BOOL isSaler=singleModel.a_isSaler;
    if (singleModel.a_status<=3&&!hasFile) {
        MainContractsBaseController* vc=[[MainContractsBaseController alloc]init];
        vc.listSingleModel=singleModel;
        pushVC=vc;
    }else if (hasFile&&singleModel.a_status>=3&&singleModel.a_status!=9){
        //销售商
        if (isSaler) {
            MainContractsBaseController* vc=[[MainContractsBaseController alloc]init];
            vc.listSingleModel=singleModel;
            pushVC=vc;
        //供应商
        }else{
            ProviderContractsController* vc=[[ProviderContractsController alloc]init];
            vc.listSingleModel=singleModel;
            pushVC=vc;
        }
    }else if (hasFile&&singleModel.a_status==9&&isSaler){
        SalerContractsController* vc=[[SalerContractsController alloc]init];
        vc.listSingleModel=singleModel;
        pushVC=vc;
    }
    
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
    [self initTitleViewWithTitle:titles[index]];
    [self loadList];
}

-(NSString *)nowStageStr{
    return @[@"0",@"2",@"3",@"4"][self.nowStage];
}

-(NSString *)archiveStatus{
    if (!_archiveStatus) {
        _archiveStatus=@"";
    }
    return _archiveStatus;
}
@end
