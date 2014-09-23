//
//  ContactViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-5.
//  Copyright (c) 2014年 zpzchina. All rights reserved.
//

#import "ContactViewController.h"
#import "CompanyMemberViewController.h"
#import "PersonalCenterViewController.h"
#import "PersonalDetailViewController.h"
#import "LoginModel.h"
#import "PublishViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "RecommendLetterViewController.h"
#import "ContactProjectTableViewCell.h"
#import "ContactCommentTableViewCell.h"
#import "ContactModel.h"
#import "ContactCommentModel.h"
#import "CommentModel.h"
#import "CommentApi.h"
#import "ConnectionAvailable.h"
#import "BirthDay.h"
#import "LoginSqlite.h"
#import "LoginViewController.h"
#import "ActivesModel.h"

#import "AppDelegate.h"
#import "HomePageViewController.h"
static NSString * const PSTableViewCellIdentifier = @"PSTableViewCellIdentifier";
@interface ContactViewController ()

@end

@implementation ContactViewController
@synthesize showVC,transparent;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 21, 19)];
    [rightButton setImage:[GetImagePath getImagePath:@"人脉_02a"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"人脉";
    
    
    //上拉刷新界面
    _pathCover = [[XHPathCover alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 154)];
    _pathCover.delegate = self;
    [_pathCover setBackgroundImage:[GetImagePath getImagePath:@"bg001"]];
    [_pathCover setHeadImageUrl:@"http://www.faceplusplus.com.cn/wp-content/themes/faceplusplus/assets/img/demo/1.jpg"];
    [_pathCover setHeadTaget];
    [_pathCover setInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"用户名", XHUserNameKey, @"公司名字显示在这里     职位", XHBirthdayKey, nil]];
    self.tableView.tableHeaderView = self.pathCover;
    //时间标签
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];

    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:PSTableViewCellIdentifier];
    
    self.tableView.separatorStyle = NO;
    
    __weak ContactViewController *wself = self;
    [_pathCover setHandleRefreshEvent:^{
        [wself _refreshing];
    }];
    
    startIndex = 0;
    showArr = [[NSMutableArray alloc] init];
    viewArr = [[NSMutableArray alloc] init];
    _datasource = [[NSMutableArray alloc] init];
    [ContactModel AllActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [LoginModel GetUserImagesWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    [_pathCover setHeadImageUrl:[NSString stringWithFormat:@"%s%@",serverAddress,posts[0]]];
                    [LoginSqlite insertData:posts[0] datakey:@"userImageUrl"];
                }
            } userId:@"13756154-7db5-4516-bcc6-6b7842504c81"];
            
            showArr = posts;
            for(int i=0;i<showArr.count;i++){
                ActivesModel *model = showArr[i];
                if([model.a_eventType isEqualToString:@"Actives"]){
                    commentView = [CommentView setFram:model];
                    [viewArr addObject:commentView];
                }else{
                    [viewArr addObject:@""];
                }
                [_datasource addObject:model.a_time];
            }
            [self.tableView reloadData];
        }
    } userId:@"13756154-7db5-4516-bcc6-6b7842504c81" startIndex:startIndex];
}



-(void)publish
{
    NSLog(@"发布产品");
    
    NSString *deviceToken = [LoginSqlite getdata:@"deviceToken" defaultdata:@""];
    
    if ([deviceToken isEqualToString:@""]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[AppDelegate instance] window].rootViewController = naVC;
        [[[AppDelegate instance] window] makeKeyAndVisible];
        return;
    }
    
    PublishViewController *publishVC = [[PublishViewController alloc] init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)_refreshing {
    // refresh your data sources
    __weak ContactViewController *wself = self;
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [wself.pathCover stopRefresh];
    });
}

/******************************************************************************************************************/
//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidScroll:scrollView];
    [_timeScroller scrollViewDidScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_pathCover scrollViewDidEndDecelerating:scrollView];
    [_timeScroller scrollViewDidEndDecelerating];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_pathCover scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_pathCover scrollViewWillBeginDragging:scrollView];
    [_timeScroller scrollViewWillBeginDragging];
}
/******************************************************************************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [showArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PSTableViewCellIdentifier];
    ActivesModel *model = showArr[indexPath.row];
    if([model.a_category isEqualToString:@"Project"]){
        NSString *CellIdentifier = [NSString stringWithFormat:@"ContactProjectTableViewCell"];
        ContactProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[ContactProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.delegate = self;
        cell.selectionStyle = NO;
        cell.model = model;
        return cell;
    }else if([model.a_category isEqualToString:@"Personal"]){
        if([model.a_eventType isEqualToString:@"Actives"]){
            NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.selectionStyle = NO;
            for(int i=0;i<cell.contentView.subviews.count;i++) {
                [((UIView*)[cell.contentView.subviews objectAtIndex:i]) removeFromSuperview];
            }
            commentView = viewArr[indexPath.row];
            [cell.contentView addSubview:commentView];
            return cell;
        }else{
            NSString *CellIdentifier = [NSString stringWithFormat:@"ContactTableViewCell"];
            ContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if(!cell){
                cell = [[ContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.delegate = self;
            cell.selectionStyle = NO;
            cell.model = model;
            return cell;
        }
    }else if([model.a_category isEqualToString:@"Company"]){
        if([model.a_eventType isEqualToString:@"Actives"]){
            
        }else{
            
        }
    }else{
        
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivesModel *model = showArr[indexPath.row];
    if([model.a_category isEqualToString:@"Project"]){
        return 50;
    }else if([model.a_category isEqualToString:@"Personal"]){
        if([model.a_eventType isEqualToString:@"Actives"]){
            commentView = viewArr[indexPath.row];
            return commentView.frame.size.height;
        }else{
            return 50;
        }
    }else if([model.a_category isEqualToString:@"Company"]){
        if([model.a_eventType isEqualToString:@"Actives"]){
            return 100;
        }else{
            return 50;
        }
    }else{
        return 50;
    }
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

//时间标签
- (UITableView *)tableViewForTimeScroller:(ACTimeScroller *)timeScroller
{
    return [self tableView];
}
//传入时间标签的date
- (NSDate *)timeScroller:(ACTimeScroller *)timeScroller dateForCell:(UITableViewCell *)cell
{
    NSIndexPath *indexPath = [[self tableView] indexPathForCell:cell];
    return _datasource[[indexPath row]];
}

//点击自己头像去个人中心
-(void)gotoMyCenter{
    NSLog(@"gotoMyCenter");

    NSString *deviceToken = [LoginSqlite getdata:@"deviceToken" defaultdata:@""];

    if ([deviceToken isEqualToString:@""]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[AppDelegate instance] window].rootViewController = naVC;
        [[[AppDelegate instance] window] makeKeyAndVisible];
        return;
    }
    
    PersonalCenterViewController *personalVC = [[PersonalCenterViewController alloc] init];
    [self.navigationController pushViewController:personalVC animated:YES];
}

-(void)HeadImageAction:(UIButton *)button{
    showVC = [[ShowViewController alloc] init];
    showVC.delegate =self;
    [showVC.view setFrame:CGRectMake(40, 70, 220, 240)];
    showVC.view.layer.cornerRadius = 10;//设置那个圆角的有多圆
    showVC.view.layer.masksToBounds = YES;//设为NO去试试。设置YES是保证添加的图片覆盖视图的效果
    
    [self presentPopupViewController:showVC animationType:MJPopupViewAnimationFade flag:0];
}

- (void)jumpToGoToDetail:(UIButton *)button
{
        NSLog(@"访问个人详情");
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    PersonalDetailViewController *personalVC = [[PersonalDetailViewController alloc] init];
    [self.navigationController pushViewController:personalVC animated:YES];
}

- (void)jumpToGotoConcern:(UIButton *)button
{

        NSLog(@"关注好友");
       [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSLog(@"*******%@",userId);
       NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithObjectsAndKeys:userId,@"userId",@"bfc78202-8ac9-447a-a99d-783606d25668",@"focusId", nil];
    [LoginModel PostInformationImprovedWithBlock:^(NSMutableArray *posts, NSError *error) {
        NSDictionary *responseObject = [posts objectAtIndex:0];
        NSString *statusCode = [[[responseObject objectForKey:@"d"] objectForKey:@"status"] objectForKey:@"statusCode"];
        if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1300"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加关注成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        else if ([[NSString stringWithFormat:@"%@",statusCode] isEqualToString:@"1308"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已经添加关注" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"关注失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        
    } dic:parameter];
}

-(void)jumpToGetRecommend:(NSDictionary *)dic
{
    NSLog(@"获得推荐");
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    RecommendLetterViewController *recommendLetterVC = [[RecommendLetterViewController alloc] init];
    [self.navigationController pushViewController:recommendLetterVC animated:YES];//跳转到推荐信页面
}



-(void)addCommentView:(NSIndexPath *)indexPath{
    indexpath = indexPath;
    addCommentView = [[AddCommentViewController alloc] init];
    addCommentView.delegate = self;
    [self presentPopupViewController:addCommentView animationType:MJPopupViewAnimationFade flag:2];
}

-(void)sureFromAddCommentWithComment:(NSString*)comment{
    
    NSString *deviceToken = [LoginSqlite getdata:@"deviceToken" defaultdata:@""];
    
    if ([deviceToken isEqualToString:@""]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [[AppDelegate instance] window].rootViewController = naVC;
        [[[AppDelegate instance] window] makeKeyAndVisible];
        return;
    }

    
    CommentModel *model = [[CommentModel alloc] init];
    model.a_content = [NSString stringWithFormat:@"%@",comment];
    model.a_type = @"comment";
    [self.tableView deselectRowAtIndexPath:indexpath animated:YES];
    NSIndexPath *path = [NSIndexPath indexPathForItem:(indexpath.row+1) inSection:indexpath.section];
    [showArr insertObject:model atIndex:path.row];
    [viewArr insertObject:@"" atIndex:path.row];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
    CommentModel *model2 = showArr[indexpath.row];
    NSLog(@"%@",model2.a_id);
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:model2.a_id forKey:@"EntityId"];
    [dic setValue:[NSString stringWithFormat:@"%@",comment] forKey:@"CommentContents"];
    [dic setValue:model2.a_type forKey:@"EntityType"];
    [dic setValue:@"a8909c12-d40e-4cdb-b834-e69b7b9e13c0" forKey:@"CreatedBy"];
    [CommentApi AddEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            
        }
    } dic:dic];
}

-(void)cancelFromAddComment{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)reloadView{
    startIndex = 0;
    [showArr removeAllObjects];
    [viewArr removeAllObjects];
    [_datasource removeAllObjects];
    if (![ConnectionAvailable isConnectionAvailable]) {
        errorview = [[ErrorView alloc] initWithFrame:CGRectMake(0, 0, 320, 500)];
        errorview.delegate = self;
        [self.tableView addSubview:errorview];
        self.tableView.scrollEnabled = NO;
    }else{
        [errorview removeFromSuperview];
        errorview = nil;
        self.tableView.scrollEnabled = YES;
        [ContactModel AllActivesWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                showArr = posts;
                [self.tableView reloadData];
            }
        } userId:@"13756154-7db5-4516-bcc6-6b7842504c81" startIndex:startIndex];
    }
}
@end
