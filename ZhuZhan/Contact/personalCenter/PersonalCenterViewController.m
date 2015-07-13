//
//  PersonalCenterViewController.m
//  PersonalCenter
//
//  Created by Jack on 14-8-18.
//  Copyright (c) 2014年 Jack. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "AccountViewController.h"
#import "LoginModel.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "LoginSqlite.h"
#import "CommentApi.h"
#import "ActivesModel.h"
#import "MJRefresh.h"
#import "PersonalCenterModel.h"
#import "PersonalCenterCellView.h"
#import "ConnectionAvailable.h"
#import "PersonalProjectTableViewCell.h"
#import "CompanyCenterViewController.h"
#import "MyTableView.h"
#import "PersonalCenterCompanyTableViewCell.h"
#import "ProductModel.h"
#import "AskPriceViewController.h"
#import "ConstractListController.h"
#import "MyFocusViewController.h"
#import "PersonalCenterTableViewCell.h"
#import "MyMarketViewController.h"
#import "PersonalHeadView.h"
#import "MyProjectViewController.h"
#import "PersonalCenterProjectTableViewCell.h"
#import "RequirementDetailViewController.h"
#import "MyPointViewController.h"
#import "SignViewController.h"
#import "MyPointApi.h"
#import "PointDetailModel.h"

@interface PersonalCenterViewController ()<PersonalHeadViewDelegate>
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIView *myFocusView;
@property(nonatomic,strong)UILabel *myFocusViewTitle;
@property(nonatomic,strong)UIButton *myFocusBtn;
@property(nonatomic,strong)UIImageView *topCutLine;
@property(nonatomic,strong)UIImageView *bottomCutLine;
@property(nonatomic,strong)UIImageView *arrowImageView;
@property(nonatomic,strong)PersonalHeadView *personalHeadView;
@end

@implementation PersonalCenterViewController
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 70, 19.5)];
    [rightButton setTitle:@"账号设置" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"个人中心";
    
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 85) bannerPlaceholderImageName:@"默认主图"];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImageUrlString:[LoginSqlite getdata:@"backgroundImage"]];
    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userImage"]]];
    [_pathCover hidewaterDropRefresh];
    [_pathCover setNameFrame:CGRectMake(-40, 15, 320, 20) font:[UIFont systemFontOfSize:14]];
    [_pathCover setBirthdayFrame:CGRectMake(93, 35, 320, 20) font:[UIFont systemFontOfSize:14]];
    [_pathCover setHeadImageFrame:CGRectMake(20, 5, 61, 61)];
    if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]){
        [_pathCover.headImage.layer setMasksToBounds:YES];
        [_pathCover.headImage.layer setCornerRadius:5];
    }else{
        [_pathCover.headImage.layer setMasksToBounds:YES];
        [_pathCover.headImage.layer setCornerRadius:30.5];
    }
    [_pathCover setFootViewFrame:CGRectMake(0, -180, 320, 320)];

    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[LoginSqlite getdata:@"userName"], XHUserNameKey, @"",XHBirthdayKey,nil]];
    
    [self.headView addSubview:self.pathCover];
    [self.headView addSubview:self.personalHeadView];
//    [self.myFocusView addSubview:self.myFocusViewTitle];
//    [self.myFocusView addSubview:self.myFocusBtn];
//    [self.myFocusView addSubview:self.topCutLine];
//    [self.myFocusView addSubview:self.bottomCutLine];
//    [self.myFocusView addSubview:self.arrowImageView];
//    [self.headView addSubview:self.myFocusView];
//    [self getThreeBtn];
    
    self.tableView.tableHeaderView = self.headView;
    
    
    __weak PersonalCenterViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    //集成刷新控件
    [self setupRefresh];
    
    showArr = [[NSMutableArray alloc] init];

    [self downLoad:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (changeHeadImage) name:@"changHead" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (changeUserName) name:@"changName" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (changeBackgroundImage) name:@"changBackground" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (newPoint) name:@"newPoint" object:nil];
    
    [self getMyPoint];
}

/*
 points	string	积分总数
 days	string	连续签到天数
 toDayGet	string	今日可领积分数
 hasSign	string	今日签到状态
 status	string	积分账户状态
 */
-(void)getMyPoint{
    [MyPointApi GetPointDetailWithBlock:^(PointDetailModel *model, NSError *error) {
        if(!error){
            PointDetailModel *pointmModel = model;
            [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"我的积分：%d",pointmModel.a_points],XHBirthdayKey,nil]];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } noNetWork:^{
        [ErrorCode alert];
    }];
}

-(void)getThreeBtn{
    UIButton *threeBtnsView = [UIButton buttonWithType:UIButtonTypeCustom];
    threeBtnsView.frame = CGRectMake(0, 155, kScreenWidth, 50);
//    threeBtnsView.backgroundColor=[UIColor whiteColor];
    [_pathCover addSubview:threeBtnsView];
    
    CGFloat width=kScreenWidth/4;
    
    UIButton *firstBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    firstBtn.frame = CGRectMake(8, 12, width-15, 25);
    [firstBtn setTitle:@"我的询价" forState:UIControlStateNormal];
    firstBtn.backgroundColor = [UIColor blackColor];
    firstBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    firstBtn.tag = 1;
    [firstBtn addTarget:self action:@selector(gotoAskPrice:) forControlEvents:UIControlEventTouchUpInside];
    firstBtn.alpha = .8;
    firstBtn.layer.masksToBounds = YES;
    firstBtn.layer.cornerRadius = 4.0;
    [threeBtnsView addSubview:firstBtn];
    
    UIButton *secondBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secondBtn.frame = CGRectMake(width+8, 12, width-15, 25);
    [secondBtn setTitle:@"我的报价" forState:UIControlStateNormal];
    [secondBtn addTarget:self action:@selector(gotoAskPrice:) forControlEvents:UIControlEventTouchUpInside];
    secondBtn.tag = 2;
    secondBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    secondBtn.backgroundColor = [UIColor blackColor];
    secondBtn.alpha = .8;
    secondBtn.layer.masksToBounds = YES;
    secondBtn.layer.cornerRadius = 4.0;
    [threeBtnsView addSubview:secondBtn];
    
    UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn.frame = CGRectMake(width*2+8, 12, width-15, 25);
    [thirdBtn setTitle:@"我的合同" forState:UIControlStateNormal];
    [thirdBtn addTarget:self action:@selector(gotoConstractList:) forControlEvents:UIControlEventTouchUpInside];
    thirdBtn.tag = 3;
    thirdBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    thirdBtn.backgroundColor = [UIColor blackColor];
    thirdBtn.alpha = .8;
    thirdBtn.layer.masksToBounds = YES;
    thirdBtn.layer.cornerRadius = 4.0;
    [threeBtnsView addSubview:thirdBtn];
    
    UIButton *fourBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fourBtn.frame = CGRectMake(width*3+8, 12, width-15, 25);
    [fourBtn setTitle:@"我的需求" forState:UIControlStateNormal];
    [fourBtn addTarget:self action:@selector(gotoMyMarket:) forControlEvents:UIControlEventTouchUpInside];
    fourBtn.tag = 4;
    fourBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    fourBtn.backgroundColor = [UIColor blackColor];
    fourBtn.alpha = .8;
    fourBtn.layer.masksToBounds = YES;
    fourBtn.layer.cornerRadius = 4.0;
    [threeBtnsView addSubview:fourBtn];
    

//    for (int i=0;i<2;i++) {
//        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(width*(i+1), 10, 2, 30)];
//        view.backgroundColor=AllSeperatorLineColor;
//        [threeBtnsView addSubview:view];
//    }
}

-(void)downLoad:(void(^)())block{
    [CommentApi PersonalActiveWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [showArr removeAllObjects];
            startIndex=0;
            showArr = posts;
            _timeScroller.hidden=YES;
            [MyTableView reloadDataWithTableView:self.tableView];
            if(showArr.count == 0){
                [MyTableView hasData:self.tableView];
            }
            _timeScroller.hidden=NO;
            if (block) {
                block();
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } userId:[LoginSqlite getdata:@"userId"] startIndex:0 noNetWork:^{
        [ErrorCode alert];
    }];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)footerRereshing
{
    [CommentApi PersonalActiveWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            startIndex ++;
            [showArr addObjectsFromArray:posts];
            _timeScroller.hidden=YES;
            [MyTableView reloadDataWithTableView:self.tableView];
            if(showArr.count == 0){
                [MyTableView hasData:self.tableView];
            }
            _timeScroller.hidden=NO;
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
        [self.tableView footerEndRefreshing];
    } userId:[LoginSqlite getdata:@"userId"] startIndex:(int)startIndex+1 noNetWork:^{
        [self.tableView footerEndRefreshing];
        [ErrorCode alert];
    }];
}

//****************************************************************
//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView isMyDynamicList:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
}


-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{//账户按钮触发的事件
    if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]){
        CompanyCenterViewController *companyVC = [[CompanyCenterViewController alloc] init];
        [self.navigationController pushViewController:companyVC animated:YES];
    }else{
        AccountViewController *accountVC = [[AccountViewController alloc] init];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
}

- (void)_refreshing {
    // refresh your data sources
    [self downLoad:^{
        __weak PersonalCenterViewController *wself = self;
        [wself.pathCover stopRefresh];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return showArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterModel *model;
    if(showArr.count !=0){
        model = showArr[indexPath.row];
    }
    if(model.a_type == 7){
        NSString *CellIdentifier = [NSString stringWithFormat:@"PersonalCenterCompanyTableViewCell"];
        PersonalCenterCompanyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[PersonalCenterCompanyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.time = model.a_createdTime;
        cell.companyName = model.a_companyName;
        cell.contentView.backgroundColor = RGBCOLOR(239, 237, 237);
        cell.selectionStyle = NO;
        return cell;
    }else if (model.a_type == 1 || model.a_type == 8 || model.a_type == 9){
        NSString *CellIdentifier = [NSString stringWithFormat:@"PersonalProjectTableViewCell"];
        PersonalProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[PersonalProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.model = model;
        cell.contentView.backgroundColor = RGBCOLOR(239, 237, 237);
        cell.selectionStyle = NO;
        return cell;
    }else if (model.a_type == 2 || model.a_type == 3 || model.a_type == 4 || model.a_type == 5){
        NSString *CellIdentifier = [NSString stringWithFormat:@"PersonalCenterProjectTableViewCell"];
        PersonalCenterProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[PersonalCenterProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.time = model.a_createdTime;
        cell.companyName = model.a_projectName;
        cell.projectDemo = model.a_operationType;
        cell.contentView.backgroundColor = RGBCOLOR(239, 237, 237);
        cell.selectionStyle = NO;
        return cell;
    }else if(model.a_type == 0 || model.a_type == 6){
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
        PersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[PersonalCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.contentView.backgroundColor = RGBCOLOR(239, 237, 237);
        cell.selectionStyle = NO;
        cell.personalCentermodel = model;
        return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        return cell;
    }
}

-(UIView*)getSeparatorLine{
    //
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 0.5)];
    separatorLine.backgroundColor=[UIColor blackColor];
    separatorLine.alpha=.1f;
    return separatorLine;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonalCenterModel *model;
    if(showArr.count !=0){
        model = showArr[indexPath.row];
    }
    if(model.a_type == 1){
        PorjectCommentTableViewController *projectCommentView = [[PorjectCommentTableViewController alloc] init];
        projectCommentView.projectId = model.a_messageSourceId;
        projectCommentView.projectName = model.a_projectName;
        [self.navigationController pushViewController:projectCommentView animated:YES];
    }else if (model.a_type == 0){
        ProductDetailViewController* vc=[[ProductDetailViewController alloc]initWithPersonalCenterModel:model];
        vc.type = @"03";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (model.a_type == 6){
        ProductModel *productModel = [[ProductModel alloc] init];
        productModel.a_id = model.a_messageSourceId;
        productModel.a_name = model.a_productName;
        productModel.a_content = model.a_msgContent;
        productModel.a_imageUrl = model.a_imageUrl;
        productModel.a_originImageUrl = model.a_imageOriginalUrl;
        productModel.a_createdBy = [LoginSqlite getdata:@"userId"];
        productModel.a_imageWidth = model.a_imageWidth;
        productModel.a_imageHeight = model.a_imageHeight;
        productModel.a_avatarUrl = model.a_avatarUrl;
        productModel.a_userName = model.a_loginName;
        productModel.a_userType = model.a_userType;
        ProductDetailViewController* vc=[[ProductDetailViewController alloc] initWithProductModel:productModel];
        vc.type = @"01";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (model.a_type == 8 || model.a_type == 9){
        RequirementDetailViewController* vc = [[RequirementDetailViewController alloc] initWithTargetId:model.a_reqId];
        vc.selfCanDelete = !model.a_isPubilc;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalCenterModel *model;
    if(showArr.count !=0){
        model = showArr[indexPath.row];
    }
    if(model.a_type == 2 || model.a_type == 3 || model.a_type == 4 || model.a_type == 5 || model.a_type == 7){
        return 60;
    }else if(model.a_type == 1 || model.a_type == 8 || model.a_type == 9){
        return 80;
    }else if(model.a_type == 0 || model.a_type == 6){
        return [PersonalCenterTableViewCell carculateCellHeightWithModel:model];
    }else{
        return 0;
    }
}

//时间标签
- (UITableView *)tableViewForTimeScroller:(ACTimeScroller *)timeScroller
{
    return [self tableView];
}
//传入时间标签的date
//- (NSDate *)timeScroller:(ACTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell
//{
//    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
//    return _datasource[[indexPath row]];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gotoMyCenter{

}

-(void)changeHeadImage{
    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userImage"]]];
    //self.personalHeadView.avatarUrl = [NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userImage"]];
}

-(void)changeUserName{
//    NSLog(@"==>%@",[LoginSqlite getdata:@"userName"]);
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[LoginSqlite getdata:@"userName"], XHUserNameKey, nil]];
    //self.personalHeadView.userName = [LoginSqlite getdata:@"userName"];
}

-(void)changeBackgroundImage{
    [_pathCover setBackgroundImageUrlString:[LoginSqlite getdata:@"backgroundImage"]];
}

-(void)newPoint{
    [self getMyPoint];
}

-(void)gotoAskPrice:(UIButton *)button{
    NSString* otherStr;
    if(button.tag == 1){
        otherStr = @"0";
    }else{
        otherStr = @"1";
    }
    
    AskPriceViewController *view = [[AskPriceViewController alloc] initWithOtherStr:otherStr];

    [self.navigationController pushViewController:view animated:YES];
}

-(void)gotoConstractList:(UIButton *)button{
    ConstractListController *view = [[ConstractListController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)gotoMyMarket:(UIButton *)button{
    MyMarketViewController *view = [[MyMarketViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(UIView *)headView{
    if(!_headView){
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 245)];
        //_headView.backgroundColor = RGBCOLOR(239, 237, 237);
    }
    return _headView;
}

-(UIView *)myFocusView{
    if(!_myFocusView){
        _myFocusView = [[UIView alloc] initWithFrame:CGRectMake(0, 210, 320, 43)];
        _myFocusView.backgroundColor = [UIColor whiteColor];
    }
    return _myFocusView;
}

-(UILabel *)myFocusViewTitle{
    if(!_myFocusViewTitle){
        _myFocusViewTitle = [[UILabel alloc] initWithFrame:CGRectMake(14, 10, 100, 20)];
        _myFocusViewTitle.text = @"我的关注";
        _myFocusViewTitle.font = [UIFont systemFontOfSize:15];
    }
    return _myFocusViewTitle;
}

-(UIButton *)myFocusBtn{
    if(!_myFocusBtn){
        _myFocusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _myFocusBtn.frame = CGRectMake(0, 0, 320, 43);
        [_myFocusBtn addTarget:self action:@selector(myFocusBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myFocusBtn;
}

-(UIImageView *)topCutLine{
    if(!_topCutLine){
        _topCutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 320, 1)];
        _topCutLine.backgroundColor = RGBCOLOR(217, 217, 217);
    }
    return _topCutLine;
}

-(UIImageView *)bottomCutLine{
    if(!_bottomCutLine){
        _bottomCutLine = [[UIImageView alloc] initWithFrame:CGRectMake(0,42, 320, 1)];
        _bottomCutLine.backgroundColor = RGBCOLOR(217, 217, 217);
    }
    return _bottomCutLine;
}

-(UIImageView *)arrowImageView{
    if(!_arrowImageView){
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(299, 15, 7, 12)];
        _arrowImageView.image = [GetImagePath getImagePath:@"project_arrow"];
    }
    return _arrowImageView;
}

-(void)myFocusBtnAction{
    MyFocusViewController* vc = [[MyFocusViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(PersonalHeadView *)personalHeadView{
    if(!_personalHeadView){
        _personalHeadView = [[PersonalHeadView alloc] initWithFrame:CGRectMake(0, 85, 320, 160)];
        _personalHeadView.delegate = self;
    }
    return _personalHeadView;
}

-(void)selectBlock:(int)index{
    switch (index) {
        case 0:
        {
            AskPriceViewController *view = [[AskPriceViewController alloc] initWithOtherStr:@"0"];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 1:
        {
            AskPriceViewController *view = [[AskPriceViewController alloc] initWithOtherStr:@"1"];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 2:
        {
            ConstractListController *view = [[ConstractListController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 3:
        {
            MyMarketViewController *view = [[MyMarketViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 4:
        {
            MyFocusViewController* vc = [[MyFocusViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            MyProjectViewController *view = [[MyProjectViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 6:
        {
            MyPointViewController *view = [[MyPointViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        case 7:
        {
            SignViewController *view = [[SignViewController alloc] init];
            [self.navigationController pushViewController:view animated:YES];
        }
            break;
        default:
            break;
    }
}
@end
