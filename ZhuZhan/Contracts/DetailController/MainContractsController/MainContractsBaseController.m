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
@interface MainContractsBaseController ()<ContractsBtnToolBarDelegate>
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

-(void)loadList{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setObject:self.listSingleModel.a_id forKey:@"contractId"];
    [ContractsApi PostDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.mainClauseModel=posts[0];
            [self reload];
        }
    } dic:dic noNetWork:nil];
}
-(void)reload{
    self.mainClauseView=nil;
    self.cellViews=nil;
    [self.tableView reloadData];
}
-(void)initNaviExtra{
    self.title=@"佣金合同条款";
    [self setRightBtnWithText:@"取消"];
}

-(void)rightBtnClicked{
    NSLog(@"取消咯");
}

-(void)contractsBtnToolBarClickedWithBtn:(UIButton *)btn index:(NSInteger)index{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    BOOL isSelfCreated=self.listSingleModel.a_isSelfCreated;
    NSString* contractsId=self.listSingleModel.a_id;
    [dic setObject:contractsId forKey:@"id"];

    if (isSelfCreated) {
        //关闭
        if (index==0) {
            [ContractsApi PostCloseWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    NSLog(@"关闭成功");
                    [self sucessPost];
                }
            } dic:dic noNetWork:nil];
        //修改
        }else if (index==1){
            NSLog(@"用户选择了修改，之后应跳转至修改页面，即汪洋写的创建页面");
        }
    }else{
        //不同意
        if (index==0) {
            [ContractsApi PostDisagreeWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    [self sucessPost];
                    NSLog(@"不同意成功");
                }
            } dic:dic noNetWork:nil];
        //同意
        }else if (index==1){
            [ContractsApi PostAgreeWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    [self sucessPost];
                    NSLog(@"同意成功");
                }
            } dic:dic noNetWork:nil];
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
        
        BOOL hasFile=![self.listSingleModel.a_fileName isEqualToString:@""];
        NSArray* imageNames;
        if (!hasFile) {
            if (self.listSingleModel.a_isSelfCreated) {
                if (self.listSingleModel.a_status==2) {
                    imageNames=@[@"不同意带字",@"同意带字"];
                }else{
                    
                }
            }else{
                if (self.listSingleModel.a_status==1) {
                    imageNames=@[@"不同意带字",@"同意带字"];
                }else{
                    
                }
            }
        }
        
        
        for (int i=0;i<imageNames.count;i++) {
            UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage* image=[GetImagePath getImagePath:imageNames[i]];
            btn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
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
