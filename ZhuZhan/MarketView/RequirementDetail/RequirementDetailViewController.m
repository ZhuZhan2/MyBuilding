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
@interface RequirementDetailViewController ()
@property (nonatomic, strong)RequirementDetailTitleView* titleView;
@property (nonatomic, strong)UIView* categoryView;
@property (nonatomic, strong)UIView* contactsInfoView;
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
}

- (void)firstNetWork{
    [MarketApi GetRequireInfoWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.model = posts[0];
            [self reloadData];
        }
    } reqId:self.targetId noNetWork:nil];
}

- (void)reloadData{
    [self.titleView setUserImageUrl:self.model.a_loginImagesId title:self.model.a_loginName time:self.model.a_createdTime needRound:self.model.a_isPsersonal];
    [self.tableView reloadData];
}

- (void)initNavi{
    self.title = @"需求详情";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"评论"];
}

- (void)rightBtnClicked{
    NSLog(@"评论");
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
    }
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell addSubview:self.viewArr[indexPath.row]];
    return cell;
}

- (NSArray *)viewArr{
    if (!_viewArr) {
        _viewArr = @[self.titleView];
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

- (UIView *)categoryView{
    if (!_categoryView) {
        _categoryView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    }
    return _categoryView;
}
@end
