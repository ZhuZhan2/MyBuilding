//
//  PublishRequirementViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/6/4.
//
//

#import "PublishRequirementViewController.h"
#import "CategoryView.h"
#import "PublishRequirementContactsInfoView.h"
#import "PublishRequirementProjectView.h"
#import "PublishRequirementMaterialView.h"
#import "PublishRequirementRelationView.h"
#import "PublishRequirementCooperationView.h"
#import "PublishRequirementOtherView.h"
#import "RKShadowView.h"
#import "LoginSqlite.h"
@interface PublishRequirementViewController ()<CategoryViewDelegate,PublishRequirementProjectViewDelegate,PublishRequirementMaterialViewDelegate,PublishRequirementRelationViewDelegate,PublishRequirementCooperationViewDelegate>
@property (nonatomic, strong)CategoryView* requirementCategoryView;
@property (nonatomic, strong)PublishRequirementContactsInfoView* contactsInfoView;
@property (nonatomic, strong)UIView* requirementInfoView;

@property (nonatomic, strong)NSArray* viewArr;
@property (nonatomic)NSInteger nowIndex;

@property (nonatomic, strong)PublishRequirementProjectView* projectView;
@property (nonatomic, strong)PublishRequirementMaterialView* materialView;
@property (nonatomic, strong)PublishRequirementRelationView* relationView;
@property (nonatomic, strong)PublishRequirementCooperationView* cooperationView;
@property (nonatomic, strong)PublishRequirementOtherView* otherView;
@end

@implementation PublishRequirementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    self.tableView.backgroundColor = AllBackDeepGrayColor;
    [self.requirementCategoryView singleCategoryViewClickedWithIndex:0];
    [self addKeybordNotification];
}

- (void)initNavi{
    self.title = @"发布需求";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

- (void)categoryViewClickedWithCategory:(NSString *)category index:(NSInteger)index{
    self.nowIndex = index;
    self.contactsInfoView = nil;
    self.viewArr = nil;
    [self.tableView reloadData];
}

- (void)projectViewAreaBtnClicked{
    NSLog(@"projectViewAreaBtnClicked");
}

- (void)materialViewBigCategoryBtnClicked{
    NSLog(@"materialViewBigCategoryBtnClicked");
}

- (void)materialViewSmallCategoryBtnClicked{
    NSLog(@"materialViewSmallCategoryBtnClicked");
}

- (void)relationViewAreaBtnClicked{
    NSLog(@"relationViewAreaBtnClicked");
}

- (void)cooperationViewAreaBtnClicked{
    NSLog(@"cooperationViewAreaBtnClicked");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView* view = self.viewArr[indexPath.row];
    return CGRectGetHeight(view.frame);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView* view = self.viewArr[indexPath.row];
    [cell addSubview:view];
    return cell;
}

- (UIView *)requirementCategoryView{
    if (!_requirementCategoryView) {
        _requirementCategoryView = [CategoryView categoryViewWithCategoryArr:@[@"找项目",@"找材料",@"找关系",@"找合作",@"其他"]];
        _requirementCategoryView.bottomView = [RKShadowView seperatorLineWithHeight:10 top:0];
        _requirementCategoryView.delegate = self;
    }
    return _requirementCategoryView;
}

- (PublishRequirementContactsInfoView *)contactsInfoView{
    if (!_contactsInfoView) {
        _contactsInfoView = [PublishRequirementContactsInfoView infoView];
        
        _contactsInfoView.publishUserName = [LoginSqlite getdata:@"userName"];
        
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        view.backgroundColor = AllBackDeepGrayColor;
        CGRect frame = view.frame;
        frame.origin.y = CGRectGetHeight(_contactsInfoView.frame);
        view.frame = frame;
        
        [_contactsInfoView addSubview:view];
        frame = _contactsInfoView.frame;
        frame.size.height += CGRectGetHeight(view.frame);
        _contactsInfoView.frame = frame;
    }
    return _contactsInfoView;
}

- (NSArray *)viewArr{
    if (!_viewArr) {
        NSArray* views = @[self.projectView,self.materialView,self.relationView,self.cooperationView,self
                           .otherView];
        _viewArr = @[self.requirementCategoryView,self.contactsInfoView,views[self.nowIndex]];
    }
    return _viewArr;
}

- (PublishRequirementProjectView *)projectView{
    if (!_projectView) {
        _projectView = [PublishRequirementProjectView projectView];
        _projectView.delegate = self;
    }
    return _projectView;
}

- (PublishRequirementMaterialView *)materialView{
    if (!_materialView) {
        _materialView = [PublishRequirementMaterialView materialView];
        _materialView.delegate = self;
    }
    return _materialView;
}

- (PublishRequirementRelationView *)relationView{
    if (!_relationView) {
        _relationView = [PublishRequirementRelationView relationView];
        _relationView.delegate = self;
    }
    return _relationView;
}

- (PublishRequirementCooperationView *)cooperationView{
    if (!_cooperationView) {
        _cooperationView = [PublishRequirementCooperationView cooperationView];
        _cooperationView.delegate = self;
    }
    return _cooperationView;
}

- (PublishRequirementOtherView *)otherView{
    if (!_otherView) {
        _otherView = [PublishRequirementOtherView otherView];
    }
    return _otherView;
}
@end
