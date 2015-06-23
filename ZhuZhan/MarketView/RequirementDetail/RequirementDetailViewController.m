//
//  RequirementDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/9.
//
//

#import "RequirementDetailViewController.h"
#import "RequirementDetailTitleView.h"
#import "MarketApi.h"
#import "RequirementDetailModel.h"
#import "RKShadowView.h"
#import "RequirementCategoryView.h"
#import "RequirementContactsInfoView.h"
#import "LoginSqlite.h"
#import "RequireCommentViewController.h"
#import "RequirementInfoPorjectView.h"
#import "RequirementInfoMateialView.h"
#import "RequirementInfoRelationView.h"
#import "RequirementInfoCooperationView.h"
#import "RequirementInfoOtherView.h"
#import "RequirementCustomerReplyView.h"
#import "ChatViewController.h"
#import "ProjectStage.h"
#import "PersonalDetailViewController.h"
#import "CompanyDetailViewController.h"
#import "AddressBookApi.h"
#import "MarketModel.h"

@interface RequirementDetailViewController ()<RequirementDetailTitleViewDelegate,RequirementCategoryViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong)RequirementDetailTitleView* titleView;
@property (nonatomic, strong)RequirementCategoryView* categoryView;
@property (nonatomic, strong)RequirementContactsInfoView* contactsInfoView;
@property (nonatomic, strong)UIView* requirementView;
@property (nonatomic, strong)RequirementCustomerReplyView* customerReplyView;
@property (nonatomic, strong)NSArray* viewArr;

@property (nonatomic, copy)NSString* targetId;
@property (nonatomic, strong)RequirementDetailModel* model;
@end

@implementation RequirementDetailViewController
- (instancetype)initWithTargetId:(NSString*)targetId{
    if (self = [super init]) {
        self.targetId = targetId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    [self firstNetWork];
    self.tableView.backgroundColor = AllBackLightGratColor;
}

- (void)firstNetWork{
    [self startLoadingViewWithOption:0];
    [MarketApi GetRequireInfoWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.model = posts[0];
            [self reloadData];
        }
        [self stopLoadingView];
    } reqId:self.targetId noNetWork:nil];
}

- (void)reloadData{
    NSString* createdTime = [ProjectStage ProjectCardTimeStage:self.model.a_createdTime];
    [self.titleView setUserImageUrl:self.model.a_loginImagesId title:self.model.a_loginName time:createdTime needRound:self.model.a_isPsersonal];
    [self.categoryView setTitle:self.model.a_requireTypeName];
    
    //判断是否要有assist按钮
    BOOL needShow;
    BOOL isSelf = [self.model.a_loginId isEqualToString:[LoginSqlite getdata:@"userId"]];
    if (isSelf) {
        needShow = self.selfCanDelete;
    }else{
        BOOL selfIsPersonal = [[LoginSqlite getdata:@"userType"] isEqualToString:@"Personal"];
        BOOL createByIsPersonal = self.model.a_isPsersonal;
        needShow = selfIsPersonal&&createByIsPersonal;
    }

    self.categoryView.assistView.hidden = !needShow;
    
    if (!self.categoryView.assistView.hidden) {
        //判断按钮内容是“删除”还是“联系他”
        [self.categoryView.assistView setBackgroundImage:[GetImagePath getImagePath:isSelf?@"card_delete":@"touchTA"] forState:UIControlStateNormal];
    }

    self.contactsInfoView.realName = self.model.a_realName;
    self.contactsInfoView.phoneNumber = self.model.a_telphone;
    
    self.viewArr = @[self.titleView,self.categoryView,self.contactsInfoView,self.requirementView];
    
    if (self.model.a_isOpen) {
        NSString* time = [ProjectStage ProjectCardTimeStage:self.model.a_replyTime];
        
        BOOL hasContent = ![self.model.a_replyContent isEqualToString:@""];
                           
        [self.customerReplyView setContent:hasContent?self.model.a_replyContent:@"抱歉！暂时还没有客服回应您，请耐心等待！" time:time needTime:hasContent contentColor:hasContent?RGBCOLOR(51, 51, 51):RGBCOLOR(187, 187, 187)];
        self.viewArr = @[self.titleView,self.categoryView,self.contactsInfoView,self.requirementView,self.customerReplyView];
    }
    
    [self.tableView reloadData];
}

- (void)initNavi{
    self.title = @"需求详情";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"评论"];
}

- (void)rightBtnClicked{
    NSLog(@"评论");
    RequireCommentViewController *view = [[RequireCommentViewController alloc] init];
    view.paramId = self.targetId;
    [self.navigationController pushViewController:view animated:YES];
}

- (void)requirementDetailTitleViewClicked:(RequirementDetailTitleView *)titleView{
    if ([self.model.a_loginId isEqualToString:[LoginSqlite getdata:@"userId"]]) return;
        
    if (self.model.a_isPsersonal) {
        PersonalDetailViewController *personalVC = [[PersonalDetailViewController alloc] init];
        personalVC.contactId = self.model.a_loginId;
        [self.navigationController pushViewController:personalVC animated:YES];
    }else{
        CompanyDetailViewController* vc = [[CompanyDetailViewController alloc] init];
        vc.companyId = self.model.a_loginId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)requirementCategoryViewAssistBtnClicked{
    BOOL isSelf = [self.model.a_loginId isEqualToString:[LoginSqlite getdata:@"userId"]];
    if (isSelf) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请问是否确定删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 2;
        [alertView show];
        
    }else if(self.model.a_isFriend){
        [self gotoChatView];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"对方暂时不是你的好友，是否添加？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = 1;
        [alertView show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1 && buttonIndex == 1){
        [self gotoAddFriend];
    }else if (alertView.tag == 2 && buttonIndex == 1){
        [self gotoDelete];
    }else if (alertView.tag == 3){
        [self leftBtnClicked];
    }
}

-(void)gotoChatView{
    ChatViewController* vc=[[ChatViewController alloc]init];
    vc.contactId = self.model.a_loginId;
    vc.titleStr = self.model.a_loginName;
    vc.type=@"01";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)gotoAddFriend{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.model.a_loginId forKey:@"userId"];
    [AddressBookApi PostSendFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发送成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
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

-(void)gotoDelete{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.targetId forKey:@"reqId"];
    [MarketApi DelRequireWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RequirementListReload" object:nil];
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"删除成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            alertView.tag = 3;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView* view = self.viewArr[indexPath.row];
    return CGRectGetHeight(view.frame);
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.viewArr[indexPath.row]];
    return cell;
}

- (NSArray *)viewArr{
    if (!_viewArr) {
        _viewArr = @[self.titleView,self.categoryView,self.contactsInfoView];
    }
    return _viewArr;
}

- (RequirementDetailTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[RequirementDetailTitleView alloc] init];
        _titleView.delegate = self;
        
        UIView* view = [RKShadowView seperatorLineWithHeight:10 top:0];
        [_titleView addSubview:view];
        
        CGRect frame = view.frame;
        frame.origin.y = CGRectGetHeight(_titleView.frame);
        view.frame = frame;
        
        frame = _titleView.frame;
        frame.size.height += CGRectGetHeight(view.frame);
        _titleView.frame = frame;
    }
    return _titleView;
}

- (RequirementCategoryView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[RequirementCategoryView alloc] init];
        _categoryView.delegate = self;
        UIView* sepe = [RKShadowView seperatorLine];
        [_categoryView addSubview:sepe];
        
        UIView* view = [RKShadowView seperatorLineWithHeight:10 top:0];
        [_categoryView addSubview:view];
        
        CGRect frame = view.frame;
        frame.origin.y = CGRectGetHeight(_categoryView.frame);
        view.frame = frame;
        
        frame = _categoryView.frame;
        frame.size.height += CGRectGetHeight(view.frame);
        _categoryView.frame = frame;
    }
    return _categoryView;
}

- (RequirementContactsInfoView *)contactsInfoView{
    if (!_contactsInfoView) {
        _contactsInfoView = [RequirementContactsInfoView infoView];
        _contactsInfoView.realNameField.userInteractionEnabled = NO;
        _contactsInfoView.phoneNumberField.userInteractionEnabled = NO;
        
        UIView* view = [RKShadowView seperatorLineWithHeight:10 top:0];
        [_contactsInfoView addSubview:view];
        
        CGRect frame = view.frame;
        frame.origin.y = CGRectGetHeight(_contactsInfoView.frame);
        view.frame = frame;
        
        frame = _contactsInfoView.frame;
        frame.size.height += CGRectGetHeight(view.frame);
        _contactsInfoView.frame = frame;
    }
    return _contactsInfoView;
}

- (UIView *)requirementView{
    if (!_requirementView) {
        NSDictionary* dic = @{
                              @"01":[self getProjectView],
                              @"02":[self getMateialView],
                              @"03":[self getRelationView],
                              @"04":[self getCooperationView],
                              @"05":[self getOtherView]
                              };
        _requirementView = dic[self.model.a_requireType];
        
        UIView* view = [RKShadowView seperatorLineWithHeight:10 top:0];
        [_requirementView addSubview:view];
        
        CGRect frame = view.frame;
        frame.origin.y = CGRectGetHeight(_requirementView.frame);
        view.frame = frame;
        
        frame = _requirementView.frame;
        frame.size.height += CGRectGetHeight(view.frame);
        _requirementView.frame = frame;
    }
    return _requirementView;
}

- (RequirementInfoPorjectView*)getProjectView{
    RequirementInfoPorjectView* projectView = [RequirementInfoPorjectView projectViewWithRequirementDescribe:self.model.a_reqDesc];
    projectView.areaField.userInteractionEnabled = NO;
    projectView.minMoneyField.userInteractionEnabled = NO;
    projectView.maxMoneyField.userInteractionEnabled = NO;
    
    projectView.area = [NSString stringWithFormat:@"%@ %@",self.model.a_province,self.model.a_city];
    
    BOOL hasMin = ![self.model.a_moneyMin isEqualToString:@""];
    BOOL hasMax = ![self.model.a_moneyMax isEqualToString:@""];
    
    projectView.minMoney = hasMin?self.model.a_moneyMin:@"不限";
    projectView.maxMoney = hasMax?self.model.a_moneyMax:@"不限";
    if (!hasMin&&!hasMax) {
        projectView.maxMoneyField.hidden = YES;
        projectView.sepe.hidden = YES;
    }
    return projectView;
}

- (RequirementInfoMateialView*)getMateialView{
    RequirementInfoMateialView* mateialView = [RequirementInfoMateialView mateialViewWithRequirementDescribe:self.model.a_reqDesc smallCategory:self.model.a_smallTypeCn];
    mateialView.bigCategoryField.userInteractionEnabled = NO;
    
    mateialView.bigCategory = self.model.a_bigTypeCn;
    mateialView.smallCategory = self.model.a_smallTypeCn;
    
    return mateialView;
}

- (RequirementInfoRelationView*)getRelationView{
    RequirementInfoRelationView* relationView = [RequirementInfoRelationView relationViewWithRequirementDescribe:self.model.a_reqDesc];
    relationView.areaField.userInteractionEnabled = NO;
    
    relationView.area = [NSString stringWithFormat:@"%@ %@",self.model.a_province,self.model.a_city];
    return relationView;
}

- (RequirementInfoCooperationView*)getCooperationView{
    RequirementInfoCooperationView* cooperationView = [RequirementInfoCooperationView cooperationViewWithRequirementDescribe:self.model.a_reqDesc];
    cooperationView.areaField.userInteractionEnabled = NO;
    
    cooperationView.area = [NSString stringWithFormat:@"%@ %@",self.model.a_province,self.model.a_city];
    return cooperationView;
}

- (RequirementInfoOtherView*)getOtherView{
    RequirementInfoOtherView* otherView = [RequirementInfoOtherView otherViewWithRequirementDescribe:self.model.a_reqDesc];
    return otherView;
}

- (RequirementCustomerReplyView *)customerReplyView{
    if (!_customerReplyView) {
        _customerReplyView = [[RequirementCustomerReplyView alloc] init];
    }
    return _customerReplyView;
}
@end
