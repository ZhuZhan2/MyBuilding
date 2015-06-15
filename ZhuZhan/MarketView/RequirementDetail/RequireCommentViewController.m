//
//  RequireCommentViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/6/10.
//
//

#import "RequireCommentViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "MJRefresh.h"
#import "MarketApi.h"
#import "RequireCommentTableViewCell.h"
#import "AddCommentViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "CommentApi.h"
@interface RequireCommentViewController ()<UITableViewDelegate,UITableViewDataSource,AddCommentDelegate,RequireCommentTableViewCellDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *modelsArr;
@property(nonatomic,strong)NSString *commentCount;
@property(nonatomic,strong)AddCommentViewController *addCommentView;
@property(nonatomic)int startIndex;
@property(nonatomic,strong)NSIndexPath *delIndexPath;
@end

@implementation RequireCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.commentCount = @"0";
    self.startIndex = 0;
    [self initNav];
    [self initTitle];
    [self.view addSubview:self.tableView];
    //集成刷新控件
    [self setupRefresh];
    [self loadList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initNav{
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 20)];
    [rightButton setTitle:@"发评论" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

-(void)initTitle{
    self.title = [NSString stringWithFormat:@"评论"];
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClick{
    self.addCommentView = [[AddCommentViewController alloc]init];
    self.addCommentView.delegate=self;
    [self presentPopupViewController:self.addCommentView animationType:MJPopupViewAnimationFade flag:2];
}

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

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelsArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [RequireCommentTableViewCell carculateCellHeightWithModel:self.modelsArr[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellIdentifier = [NSString stringWithFormat:@"Cell"];
    RequireCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell = [[RequireCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.model = self.modelsArr[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

-(void)loadList{
    self.startIndex = 0;
    [MarketApi GetCommentListWithBlock:^(NSMutableArray *posts, NSString *total, NSError *error) {
        if(!error){
            self.commentCount = total;
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
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    } startIndex:0 paramId:self.paramId commentType:@"04" noNetWork:^{
        [self.tableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing{
    [self loadList];
}

- (void)footerRereshing{
    [MarketApi GetCommentListWithBlock:^(NSMutableArray *posts, NSString *total, NSError *error) {
        if(!error){
            self.startIndex ++;
            [self.modelsArr addObjectsFromArray:posts];
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
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self loadList];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    } startIndex:self.startIndex+1 paramId:self.paramId commentType:@"04" noNetWork:^{
        [self.tableView headerEndRefreshing];
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self loadList];
        }];
    }];
}



//=============================================================
//AddCommentDelegate
//=============================================================
//点击添加评论并点取消的回调方法
-(void)cancelFromAddComment{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

// "EntityId": ":entity ID", （项目，产品，公司，动态等）
// "entityType": ":”entityType", Personal,Company,Project,Product 之一
// "CommentContents": "评论内容",
// "CreatedBy": ":“评论人"
// }
//点击添加评论并点确认的回调方法
-(void)sureFromAddCommentWithComment:(NSString *)comment{
    NSLog(@"sureFromAddCommentWithCommentModel:");
    [self addActivesComment:comment];
}

//post完成之后的操作
-(void)finishAddComment:(NSString*)comment aid:(NSString *)aid{
    [self loadList];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

//添加动态详情的评论
-(void)addActivesComment:(NSString*)comment{
    [CommentApi AddEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        [self.addCommentView finishNetWork];
        if(!error){
            [self finishAddComment:comment aid:posts[0]];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } dic:[@{@"paramId":self.paramId,@"content":comment,@"commentType":@"04"} mutableCopy] noNetWork:^{
        [ErrorCode alert];
    }];
}

-(void)deleteComment:(NSIndexPath *)indexPath{
    self.delIndexPath = indexPath;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"是否删除评论" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        ContactCommentModel *model = self.modelsArr[self.delIndexPath.row];
        [CommentApi DelEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [self loadList];
            }else{
                if([ErrorCode errorCode:error] == 403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:[@{@"commentId":model.a_id,@"commentType":@"04"} mutableCopy] noNetWork:^{
            [ErrorCode alert];
        }];
    }
}
@end
