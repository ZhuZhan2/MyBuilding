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
@interface RequirementDetailViewController ()
@property (nonatomic, strong)RequirementDetailTitleView* titleView;
@property (nonatomic, strong)RequirementCategoryView* categoryView;
@property (nonatomic, strong)RequirementContactsInfoView* contactsInfoView;
@property (nonatomic, strong)UIView* requirementView;
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
    [self.titleView setUserImageUrl:self.model.a_loginImagesId title:self.model.a_loginName time:self.model.a_createdTime needRound:self.model.a_isPsersonal];
    [self.categoryView setTitle:self.model.a_requireTypeName];
    self.categoryView.assistView.hidden = ([self.model.a_loginId isEqualToString:[LoginSqlite getdata:@"userId"]] || !self.model.a_isPsersonal);
    self.contactsInfoView.realName = self.model.a_realName;
    self.contactsInfoView.phoneNumber = self.model.a_telphone;
    
    self.viewArr = @[self.titleView,self.categoryView,self.contactsInfoView,self.requirementView];
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
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell addSubview:self.viewArr[indexPath.row]];
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
    return relationView;
}

- (RequirementInfoCooperationView*)getCooperationView{
    RequirementInfoCooperationView* cooperationView = [RequirementInfoCooperationView cooperationViewWithRequirementDescribe:self.model.a_reqDesc];
    cooperationView.areaField.userInteractionEnabled = NO;
    return cooperationView;
}

- (RequirementInfoOtherView*)getOtherView{
    RequirementInfoOtherView* otherView = [RequirementInfoOtherView otherViewWithRequirementDescribe:self.model.a_reqDesc];
    return otherView;
}
@end
