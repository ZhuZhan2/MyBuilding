//
//  MainContractsBaseController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/15.
//
//

#import "MainContractsBaseController.h"
#import "ContractsUserView.h"
#import "ContractsTradeCodeView.h"
#import "ContractsMainClauseView.h"
#import "ContractsBtnToolBar.h"
#import "ContractsApi.h"
#import "ProvisionalViewController.h"
#import "RKContractsStagesView.h"
#import "ErrorCode.h"
@interface MainContractsBaseController ()<ContractsBtnToolBarDelegate>
@property (nonatomic, strong)ContractsMainClauseModel* mainClauseModel;

@property (nonatomic, strong)ContractsUserView* userView1;
@property (nonatomic, strong)ContractsUserView* userView2;
@property (nonatomic, strong)ContractsMainClauseView* mainClauseView;
@property (nonatomic, strong)ContractsBtnToolBar* btnToolBar;
@property (nonatomic, strong)NSMutableArray* cellViews;
@end

@implementation MainContractsBaseController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initNaviExtra];
    [self initTableView];
    [self initTableViewExtra];
    [self loadList];
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    if (!self.contractsStagesViewData) {
        [self setRightBtnWithText:@"更多"];
    }
}

-(NSString *)contractId{
    if (!_contractId) {
        _contractId=self.listSingleModel.a_id;
    }
    return _contractId;
}

-(void)loadList{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setObject:self.contractId forKey:@"contractId"];
    [ContractsApi PostDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.mainClauseModel=posts[0];
            [self reload];
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

-(void)reload{
    [self.stagesView removeFromSuperview];
    self.stagesView=nil;
    [self initStagesView];
    
    self.mainClauseView=nil;
    self.btnToolBar=nil;
    self.cellViews=nil;
    [self.tableView reloadData];
}

-(void)initNaviExtra{
    self.title=@"佣金合同条款";
}

-(void)contractsBtnToolBarClickedWithBtn:(UIButton *)btn index:(NSInteger)index{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    BOOL isSelfCreated=self.listSingleModel.a_isSelfCreated;
    NSString* contractsId=self.listSingleModel.a_id;
    [dic setObject:contractsId forKey:@"id"];
    
    if (isSelfCreated) {
        //修改
        if (index==0) {
            ContractsListSingleModel* dataModel=self.listSingleModel;
            ProvisionalModel* model=[[ProvisionalModel alloc]init];

            BOOL crateIsSaler=[dataModel.a_createdByType isEqualToString:@"2"];
            model.personaStr1=crateIsSaler?@"销售商":@"供应商";
            model.personaStr2=!crateIsSaler?@"销售商":@"供应商";
            model.myCompanyName=dataModel.a_partyA;
            model.otherCompanyName=dataModel.a_partyB;
            model.personaName=dataModel.a_recipientName;
            model.moneyStr=dataModel.a_contractsMoney;
            model.contractStr=self.mainClauseModel.a_contentMain;
            model.modifiedId=self.listSingleModel.a_id;
            
            ProvisionalViewController* vc=[[ProvisionalViewController alloc]initWithView:model targetPopVC:self];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //不同意
        if (index==0) {
            [ContractsApi PostDisagreeWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    [self sucessPost];
                    NSLog(@"不同意成功");
                }else{
                    if([ErrorCode errorCode:error]== 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:nil];
            //同意
        }else if (index==1){
            [ContractsApi PostAgreeWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    [self sucessPost];
                    NSLog(@"同意成功");
                }else{
                    if([ErrorCode errorCode:error]== 403){
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
}

-(void)initTableViewExtra{
    CGRect frame=self.tableView.frame;
    CGFloat changeHeight=CGRectGetMaxY(self.tradeCodeView.frame)-CGRectGetMinY(self.tableView.frame);
    frame.origin.y+=changeHeight;
    frame.size.height-=changeHeight;
    self.tableView.frame=frame;
    
    self.tableView.backgroundColor=AllBackDeepGrayColor;
    [self.view insertSubview:self.tableView belowSubview:self.tradeCodeView];
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor=AllBackDeepGrayColor;
    self.tableView.tableFooterView=view;
}

-(void)closeBtnClickedWithContent:(NSString*)content{
    BOOL hasProviderFile=self.listSingleModel.a_provideHas;
    BOOL canClose=self.listSingleModel.a_isSelfCreated&&self.mainClauseModel.a_status==2&&!hasProviderFile;
    if (!canClose) {
        [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"目前状态无法进行关闭" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
        return;
    }
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.listSingleModel.a_id;
    [dic setObject:contractsId forKey:@"id"];
    [dic setObject:content forKey:@"remark"];
    [ContractsApi PostCloseWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self sucessPost];
        }
    } dic:dic noNetWork:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellViews.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetHeight([self.cellViews[indexPath.row] frame]);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.cellViews[indexPath.row]];
    return cell;
}

-(UIView *)stagesView{
    if (!_stagesView&&!self.contractsStagesViewData) {
        NSInteger status=self.mainClauseModel.a_status;
        BOOL hasProviderFile=self.listSingleModel.a_provideHas;
        NSArray* bigStages=@[@"合同主要条款",@"供应商佣金合同",@"销售佣金合同"];
        NSArray* array;
        {
            if (status<=2) {
                array=[self stylesWithNumber:2 count:3];
            }else if (status>=3){
                array=[self stylesWithNumber:3 count:3];
            }
        }
        
        _stagesView=[RKContractsStagesView contractsStagesViewWithBigStageNames:bigStages smallStageNames:@[@[@"填写条款",@"待审核",@"生成条款"],@[hasProviderFile?(status==9?@"已完成":@"进行中"):@"未开始"],@[@"未开始"]] smallStageStyles:@[array,@[hasProviderFile?@0:@1],@[@1]] isClosed:NO];
        CGRect frame=_stagesView.frame;
        frame.origin.y=64;
        _stagesView.frame=frame;
    }else if (!_stagesView&&self.contractsStagesViewData) {
        _stagesView=[RKContractsStagesView contractsStagesViewWithBigStageNames:self.contractsStagesViewData[0] smallStageNames:self.contractsStagesViewData[1] smallStageStyles:self.contractsStagesViewData[2] isClosed:NO];
        CGRect frame=_stagesView.frame;
        frame.origin.y=64;
        _stagesView.frame=frame;
    }
    return _stagesView;
}

-(ContractsUserView *)userView1{
    if (!_userView1) {
        _userView1=[ContractsUserView contractsUserViewWithUserName:self.listSingleModel.a_salerName userCategory:@"销售方" companyName:self.listSingleModel.a_salerCompanyName remarkContent:@"这里输入的公司全称将用于合同和开票信息"];
    }
    return _userView1;
}

-(ContractsUserView *)userView2{
    if (!_userView2) {
        _userView2=[ContractsUserView contractsUserViewWithUserName:self.listSingleModel.a_providerName userCategory:@"供应商" companyName:self.listSingleModel.a_providerCompanyName remarkContent:@"这里输入的公司全称将用于合同和开票信息"];
    }
    return _userView2;
}

-(ContractsMainClauseView *)mainClauseView{
    if (!_mainClauseView) {
        _mainClauseView=[ContractsMainClauseView mainClauseViewWithTitle:self.listSingleModel.a_contractsMoney content:self.mainClauseModel.a_contentMain];
    }
    return _mainClauseView;
}

/*
 同意带字 不同意带字 关闭带字 修改带字
 同意小带字 不同意小带字 上传小带字
 同意迷你带字 不同意迷你带字 上传迷你带字 选项按钮
 */
-(ContractsBtnToolBar *)btnToolBar{
    if (!_btnToolBar) {
        NSMutableArray* btns=[NSMutableArray array];
        
        NSArray* imageNames;
        if (self.listSingleModel.a_isSelfCreated) {
            if (self.mainClauseModel.a_status==2) {
                imageNames=@[@"修改大带子"];
            }else{
                
            }
        }else{
            if (self.mainClauseModel.a_status==1) {
                imageNames=@[@"不同意带字",@"同意带字"];
            }else{
                
            }
        }
        
        for (int i=0;i<imageNames.count;i++) {
            UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage* image=[GetImagePath getImagePath:imageNames[i]];
            btn.frame=CGRectMake(0, 0, MIN(image.size.width, 270) , image.size.height);
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btns addObject:btn];
        }
        
        _btnToolBar=[ContractsBtnToolBar contractsBtnToolBarWithBtns:btns contentMaxWidth:270 top:5 bottom:30 contentHeight:37];
        
        _btnToolBar.delegate=self;
    }
    return _btnToolBar;
}

-(NSMutableArray *)cellViews{
    if (!_cellViews) {
        _cellViews=[@[self.userView1,self.userView2,self.mainClauseView,self.btnToolBar] mutableCopy];
    }
    return _cellViews;
}
@end
