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
#import "RKShadowView.h"
@interface PublishRequirementViewController ()
@property (nonatomic, strong)CategoryView* requirementCategoryView;
@property (nonatomic, strong)PublishRequirementContactsInfoView* contactsInfoView;
@property (nonatomic, strong)UIView* requirementInfoView;

@property (nonatomic, strong)NSArray* viewArr;

@property (nonatomic, strong)PublishRequirementProjectView* projectView;
@property (nonatomic, strong)UIView* materialView;
@property (nonatomic, strong)UIView* relationView;
@property (nonatomic, strong)UIView* cooperationView;
@property (nonatomic, strong)UIView* otherView;
@end

@implementation PublishRequirementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    self.tableView.backgroundColor = AllBackDeepGrayColor;
    [self addKeybordNotification];
}

- (void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
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
    }
    return _requirementCategoryView;
}

- (PublishRequirementContactsInfoView *)contactsInfoView{
    if (!_contactsInfoView) {
        _contactsInfoView = [PublishRequirementContactsInfoView infoView];
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
        _viewArr = @[self.requirementCategoryView,self.contactsInfoView,self.projectView];
    }
    return _viewArr;
}

- (PublishRequirementProjectView *)projectView{
    if (!_projectView) {
        _projectView = [PublishRequirementProjectView projectView];
    }
    return _projectView;
}
@end
