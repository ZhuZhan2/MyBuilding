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
@interface MainContractsBaseController ()
@property (nonatomic, strong)ContractsUserView* userView1;
@property (nonatomic, strong)ContractsUserView* userView2;
@property (nonatomic, strong)ContractsMainClauseView* mainClauseView;
@property (nonatomic, strong)NSMutableArray* cellViews;
@end

@implementation MainContractsBaseController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self initTableView];
    [self initTableViewExtra];
}

-(void)initTableViewExtra{
    CGRect frame=self.tableView.frame;
    CGFloat changeHeight=CGRectGetMaxY(self.tradeCodeView.frame)-CGRectGetMinY(self.tableView.frame);
    frame.origin.y+=changeHeight;
    frame.size.height-=changeHeight;
    self.tableView.frame=frame;
    
    self.tableView.backgroundColor=AllBackDeepGrayColor;
    [self.view insertSubview:self.tableView belowSubview:self.tradeCodeView];
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

-(NSMutableArray *)cellViews{
    if (!_cellViews) {
        _cellViews=[@[self.userView1,self.userView2,self.mainClauseView] mutableCopy];
    }
    return _cellViews;
}
@end
