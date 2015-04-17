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
}

-(void)initNaviExtra{
    self.title=@"佣金合同条款";
    [self setRightBtnWithText:@"取消"];
}

-(void)rightBtnClicked{
    NSLog(@"取消咯");
}

-(void)contractsBtnToolBarClickedWithBtn:(UIButton *)btn index:(NSInteger)index{
    NSLog(@"index=%d",(int)index);
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
        _userView1=[ContractsUserView contractsUserViewWithUserName:@"用户名" userCategory:@"销售方" companyName:@"上海东方科技有限公司" remarkContent:@"这里输入的公司全称将用于合同和开票信息"];
    }
    return _userView1;
}

-(ContractsUserView *)userView2{
    if (!_userView2) {
        _userView2=[ContractsUserView contractsUserViewWithUserName:@"用户名" userCategory:@"供应商供应商供应商供应商供应商供应商供应商供应商供应商供应商供应商供应商供应商供应商供应商供应商" companyName:@"上海东方科技有限公司上海东方科技有限公司上海东方科技有限公司上海东方科技有限公司上海东方科技有限公司上海东方科技有限公司上海东方科技有限公司上海东方科技有限公司上海东方科技有限公司上海东方科技有限公司上海东方科技有限公司" remarkContent:@"这里输入的公司全称将用于合同和开票信息"];
    }
    return _userView2;
}

-(ContractsMainClauseView *)mainClauseView{
    if (!_mainClauseView) {
        _mainClauseView=[ContractsMainClauseView mainClauseViewWithTitle:@"￥123456789.00" content:@"1.迪斯科打撒娇的老师交代啦\n2.垃圾点撒，点撒扣篮对就饿啊阑珊口来多久了\n3.安康大量考水帘洞ASAD阿萨大时代ASAS安师大烧烤老倔绝境逢生的地方科技大厦电视卡达拉斯：拉大来看"];
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
//        NSArray* imageNames=@[@"不同意迷你带字",@"同意迷你带字",@"上传迷你带字",@"选项按钮"];
        NSArray* imageNames=@[@"不同意小带字",@"同意小带字",@"上传小带字"];
        //NSArray* imageNames=@[@"不同意带字",@"同意带字"];

        for (int i=0;i<imageNames.count;i++) {
            UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage* image=[GetImagePath getImagePath:imageNames[i]];
            btn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btns addObject:btn];
        }

        _btnToolBar=[ContractsBtnToolBar contractsBtnToolBarWithBtns:btns contentMaxWidth:295 top:5 bottom:30 contentHeight:37];
      //  _btnToolBar=[ContractsBtnToolBar contractsBtnToolBarWithBtns:btns contentMaxWidth:270 top:5 bottom:30 contentHeight:37];

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
