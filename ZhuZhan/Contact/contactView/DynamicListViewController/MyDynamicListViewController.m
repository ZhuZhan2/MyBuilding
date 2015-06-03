//
//  MyDynamicListViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/1.
//
//

#import "MyDynamicListViewController.h"
#import "XHPathCover.h"
#import "LoginSqlite.h"
#import "LoadingView.h"
#import "CompanyApi.h"
#import "CompanyModel.h"
#import "LoginModel.h"
#import "ContactModel.h"
#import "LoginViewController.h"
#import "PersonalCenterViewController.h"
#import "MJRefresh.h"
#import "ContactModel.h"
#import "ContactsActiveCell.h"
#import "ActivesModel.h"
#import "ContactCommentModel.h"
#import "MyTableView.h"
#import "ContactCommentModel.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "ShowViewController.h"
#import "LoginSqlite.h"
#import "UIViewController+MJPopupViewController.h"
#import "CompanyDetailViewController.h"
#import "ChatViewController.h"
#import "PersonalDetailViewController.h"
#import "PorjectCommentTableViewController.h"
#import "ProductDetailViewController.h"
#import "ProgramDetailViewController.h"
@interface MyDynamicListViewController ()<XHPathCoverDelegate,UITableViewDelegate,UITableViewDataSource,LoginViewDelegate,ContactsActiveCellDelegate,showControllerDelegate>
@property(nonatomic,strong)XHPathCover *pathCover;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)LoadingView *loadingView;
@property(nonatomic,strong)NSMutableArray *modelsArr;
@property(nonatomic,strong)UINavigationController *navigationController;
@property(nonatomic)int startIndex;
@end

@implementation MyDynamicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.pathCover;
    self.startIndex = 0;
    
    [self loadUserInfo];
    
    //集成刷新控件
    [self setupRefresh];
    
    __weak MyDynamicListViewController *wself = self;
    [self.pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (changeHeadImage) name:@"changHead" object:nil];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (changeUserName) name:@"changName" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBackgroundImage) name:@"changBackground" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_refreshing {
    // refresh your data sources
    self.startIndex = 0;
    [self loadList];
}

- (void)setupRefresh
{
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(XHPathCover *)pathCover{
    if(!_pathCover){
        _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 154) bannerPlaceholderImageName:@"默认主图"];
        _pathCover.delegate = self;
        [_pathCover setHeadTaget];
        [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"匿名用户", XHUserNameKey,@"想要使用更多功能请登录",XHBirthdayKey, nil]];
    }
    return _pathCover;
}

-(NSMutableArray *)modelsArr{
    if(!_modelsArr){
        _modelsArr = [NSMutableArray array];
    }
    return _modelsArr;
}

//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView isMyDynamicList:YES];
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

-(void)gotoMyCenter{
    NSString *deviceToken = [LoginSqlite getdata:@"token"];
    if ([deviceToken isEqualToString:@""]) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        loginVC.needDelayCancel = YES;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        PersonalCenterViewController *personalVC = [[PersonalCenterViewController alloc] init];
        [self.nowViewController.navigationController pushViewController:personalVC animated:YES];
    }
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,kScreenHeight-160)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivesModel* dataModel = self.modelsArr[indexPath.row];
    ContactsActiveCellModel* cellModel = [ContactsActiveCellModel cellModelWithDataModel:dataModel indexPath:indexPath];
    return [ContactsActiveCell carculateCellHeightWithModel:cellModel];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = [NSString stringWithFormat:@"cell"];
    ContactsActiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[ContactsActiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    ActivesModel* dataModel = self.modelsArr[indexPath.row];
    ContactsActiveCellModel* cellModel = [ContactsActiveCellModel cellModelWithDataModel:dataModel indexPath:indexPath];
    BOOL isActive = dataModel.a_type==0;
    [cell setModel:cellModel isActive:isActive];
    cell.delegate = self;
    cell.selectionStyle = NO;
    return cell;
}

-(void)changeHeadImage{
    [self.pathCover setHeadImageUrl:[NSString stringWithFormat:@"%@",[LoginSqlite getdata:@"userImage"]]];
}

-(void)changeUserName{
    [self.pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:[LoginSqlite getdata:@"userName"], XHUserNameKey, nil]];
}

-(void)changeBackgroundImage{
    [self.pathCover setBackgroundImageUrlString:[LoginSqlite getdata:@"backgroundImage"]];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changHead" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changName" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changBackground" object:nil];
}

- (void)footerRereshing{
    [ContactModel MyActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.startIndex ++;
            [self.modelsArr addObjectsFromArray:posts];
            [MyTableView reloadDataWithTableView:self.tableView];
            if(self.modelsArr.count == 0){
                [MyTableView hasData:self.tableView];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self loadUserInfo];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        [self.tableView footerEndRefreshing];
    } startIndex:self.startIndex+1 noNetWork:^{
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        [self.tableView footerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadUserInfo];
        }];
    }];
}

-(void)loadUserInfo{
    self.loadingView = [LoadingView loadingViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view];
    if(![[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        if([[LoginSqlite getdata:@"userType"] isEqualToString:@"Company"]){
            [CompanyApi GetCompanyDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    if(posts.count !=0){
                        CompanyModel *model = posts[0];
                        [LoginSqlite insertData:model.a_companyLogo datakey:@"userImage"];
                        [LoginSqlite insertData:model.a_companyName datakey:@"userName"];
                        [_pathCover setHeadImageUrl:model.a_companyLogo];
                        [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:model.a_companyName, XHUserNameKey,@"", XHBirthdayKey, nil]];
                    }
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                            [self loadUserInfo];
                        }];
                    }
                }
            } companyId:[LoginSqlite getdata:@"userId"] noNetWork:^{
                [LoadingView removeLoadingView:self.loadingView];
                self.loadingView = nil;
                __weak MyDynamicListViewController *wself = self;
                [wself.pathCover stopRefresh];
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadUserInfo];
                }];
            }];
        }else{
            [LoginModel GetUserInformationWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    if(posts.count !=0){
                        ContactModel *model = posts[0];
                        [LoginSqlite insertData:model.userImage datakey:@"userImage"];
                        [LoginSqlite insertData:model.userName datakey:@"userName"];
                        [LoginSqlite insertData:model.personalBackground datakey:@"backgroundImage"];
                        
                        [_pathCover setHeadImageUrl:model.userImage];
                        [_pathCover setBackgroundImageUrlString:model.personalBackground];
                        [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:model.userName, XHUserNameKey,model.companyName, XHBirthdayKey,model.position,XHTitkeKey, nil]];
                    }
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                            [self loadUserInfo];
                        }];
                    }
                }
            } userId:[LoginSqlite getdata:@"userId"] noNetWork:^{
                [LoadingView removeLoadingView:self.loadingView];
                self.loadingView = nil;
                __weak MyDynamicListViewController *wself = self;
                [wself.pathCover stopRefresh];
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadUserInfo];
                }];
            }];
        }
    }
    
    [self loadList];
}

-(void)loadList{
    [ContactModel MyActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.modelsArr removeAllObjects];
            self.modelsArr = posts;
            if(self.modelsArr.count == 0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView hasData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 50, 320, kScreenHeight-50) superView:self.view reloadBlock:^{
                    [self loadUserInfo];
                }];
            }
        }
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        __weak MyDynamicListViewController *wself = self;
        [wself.pathCover stopRefresh];
    } startIndex:0 noNetWork:^{
        [LoadingView removeLoadingView:self.loadingView];
        self.loadingView = nil;
        __weak MyDynamicListViewController *wself = self;
        [wself.pathCover stopRefresh];
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadUserInfo];
        }];
    }];
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    
}

- (void)contactsUserImageClickedWithIndexPath:(NSIndexPath *)indexPath{
    [self HeadImageAction:indexPath];
}

- (void)contactsCommentBtnClickedWithIndexPath:(NSIndexPath *)indexPath{
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

-(void)HeadImageAction:(NSIndexPath *)indexPath{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    ActivesModel *model = self.modelsArr[indexPath.row];
    if([model.a_dynamicLoginId isEqualToString:[LoginSqlite getdata:@"userId"]]){
        return;
    }
    if([model.a_dynamicUserType isEqualToString:@"Personal"]){
        showVC = [[ShowViewController alloc] init];
        showVC.delegate =self;
        showVC.createdBy = model.a_dynamicLoginId;
        [showVC.view setFrame:CGRectMake(20, 70, 280, 300)];
        showVC.view.layer.cornerRadius = 10;//设置那个圆角的有多圆
        showVC.view.layer.masksToBounds = YES;
        [self.nowViewController presentPopupViewController:showVC animationType:MJPopupViewAnimationFade flag:0];
    }else{
        CompanyDetailViewController *detailView = [[CompanyDetailViewController alloc] init];
        detailView.companyId = model.a_dynamicLoginId;
        [self.nowViewController.navigationController pushViewController:detailView animated:YES];
    }
}

-(void)gotoChatView:(NSString *)contactId name:(NSString *)name{
    [self.nowViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    ChatViewController *view = [[ChatViewController alloc] init];
    view.contactId = contactId;
    view.titleStr = name;
    view.type = @"01";
    [self.nowViewController.navigationController pushViewController:view animated:YES];
    [showVC.view removeFromSuperview];
    showVC = nil;
}

-(void)gotoContactDetailView:(NSString *)contactId{
    [self.nowViewController dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    PersonalDetailViewController *personalVC = [[PersonalDetailViewController alloc] init];
    personalVC.contactId = contactId;
    [self.nowViewController.navigationController pushViewController:personalVC animated:YES];
    [showVC.view removeFromSuperview];
    showVC = nil;
}

-(void)gotoContactDetail:(NSString *)aid userType:(NSString *)userType{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    if([aid isEqualToString:[LoginSqlite getdata:@"userId"]]){
        return;
    }
    if([userType isEqualToString:@"Personal"]){
        showVC = [[ShowViewController alloc] init];
        showVC.delegate =self;
        showVC.createdBy = aid;
        [showVC.view setFrame:CGRectMake(20, 70, 280, 300)];
        showVC.view.layer.cornerRadius = 10;//设置那个圆角的有多圆
        showVC.view.layer.masksToBounds = YES;
        [self.nowViewController presentPopupViewController:showVC animationType:MJPopupViewAnimationFade flag:0];
    }else{
        CompanyDetailViewController *detailView = [[CompanyDetailViewController alloc] init];
        detailView.companyId = aid;
        [self.nowViewController.navigationController pushViewController:detailView animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivesModel *model = self.modelsArr[indexPath.row];
    
    if(model.a_type == 0){
        ActivesModel *model = self.modelsArr[indexPath.row];
        ProductDetailViewController* vc=[[ProductDetailViewController alloc]initWithActivesModel:model];
        vc.type = @"03";
        [self.nowViewController.navigationController pushViewController:vc animated:YES];
    }else if (model.a_type == 1){
        ActivesModel *model = self.modelsArr[indexPath.row];
        ProductModel *productModel = [[ProductModel alloc] init];
        productModel.a_id = model.a_entityId;
        productModel.a_name = model.a_productName;
        productModel.a_content = model.a_content;
        productModel.a_imageUrl = model.a_productImage;
        productModel.a_originImageUrl = model.a_productImage;
        productModel.a_createdBy = model.a_dynamicLoginId;
        productModel.a_imageWidth = model.a_productImageWidth;
        productModel.a_imageHeight = model.a_productImageHeight;
        productModel.a_avatarUrl = model.a_dynamicAvatarUrl;
        productModel.a_userName = model.a_dynamicLoginName;
        productModel.a_userType = model.a_dynamicUserType;
        ProductDetailViewController* vc= [[ProductDetailViewController alloc] initWithProductModel:productModel];
        vc.type = @"01";
        [self.nowViewController.navigationController pushViewController:vc animated:YES];
    }else if(model.a_type == 2 || model.a_type == 5){
        ProgramDetailViewController *vc = [[ProgramDetailViewController alloc] init];
        vc.projectId = model.a_entityId;
        [self.nowViewController.navigationController pushViewController:vc animated:YES];
    }else if (model.a_type == 6){
        PorjectCommentTableViewController *projectCommentView = [[PorjectCommentTableViewController alloc] init];
        projectCommentView.projectId = model.a_entityId;
        projectCommentView.projectName = model.a_projectName;
        [self.nowViewController.navigationController pushViewController:projectCommentView animated:YES];
    }else if (model.a_type == 7){
        ActivesModel *model = self.modelsArr[indexPath.row];
        ProductModel *productModel = [[ProductModel alloc] init];
        productModel.a_id = model.a_entityId;
        productModel.a_name = model.a_productName;
        productModel.a_content = model.a_content;
        productModel.a_imageUrl = model.a_productImage;
        productModel.a_originImageUrl = model.a_productImage;
        productModel.a_createdBy = model.a_dynamicLoginId;
        productModel.a_imageWidth = model.a_productImageWidth;
        productModel.a_imageHeight = model.a_productImageHeight;
        productModel.a_avatarUrl = model.a_dynamicAvatarUrl;
        productModel.a_userName = model.a_dynamicLoginName;
        productModel.a_userType = model.a_dynamicUserType;
        ProductDetailViewController* vc= [[ProductDetailViewController alloc] initWithProductModel:productModel];
        vc.type = @"01";
        [self.nowViewController.navigationController pushViewController:vc animated:YES];
    }
}
@end
