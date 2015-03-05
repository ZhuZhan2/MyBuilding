//
//  PorjectCommentTableViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-9-4.
//
//

#import "PorjectCommentTableViewController.h"
#import "CommentApi.h"
#import "ContactCommentModel.h"
#import "UIViewController+MJPopupViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "LoginSqlite.h"
#import "PersonalDetailViewController.h"
#import "MyTableView.h"
@interface PorjectCommentTableViewController ()
@property(nonatomic,strong)UIButton *button;
@end

@implementation PorjectCommentTableViewController
@synthesize projectId,projectName;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.title=@"评论列表";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"GurmukhiMN-Bold" size:19], NSFontAttributeName,
                                                                     nil]];
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 21, 23)];
    [rightButton setBackgroundImage:[GetImagePath getImagePath:@"+项目详情-3_03a"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    _datasource = [NSMutableArray new];
    viewArr = [[NSMutableArray alloc] init];
    
    //时间标签
    _timeScroller = [[ACTimeScroller alloc] initWithDelegate:self];
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    
    [self firstNetWork];
}

-(void)firstNetWork{
    [CommentApi GetEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            showArr = posts;
            for(int i=0; i<posts.count;i++){
                ContactCommentModel *model = posts[i];
                projectCommentView = [[ProjectCommentView alloc] initWithCommentModel:model];
                projectCommentView.delegate =self;
                [viewArr addObject:projectCommentView];
                [_datasource addObject:model.a_time];
            }
            [MyTableView reloadDataWithTableView:self.tableView];
            if(showArr.count == 0){
                [MyTableView hasData:self.tableView];
            }
            if(showArr.count == 0){
                [MyTableView hasData:self.tableView];
            }
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } entityId:projectId entityType:@"02" noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    NSString *deviceToken = [LoginSqlite getdata:@"token"];
    
    if ([deviceToken isEqualToString:@""]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        addCommentView = [[AddCommentViewController alloc] init];
        addCommentView.delegate = self;
        [self presentPopupViewController:addCommentView animationType:MJPopupViewAnimationFade flag:2];
    }
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
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}


//滚动是触发的事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_timeScroller scrollViewDidScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [_timeScroller scrollViewDidEndDecelerating];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_timeScroller scrollViewWillBeginDragging];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [showArr count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        CGRect bounds=[self.projectName boundingRectWithSize:CGSizeMake(288, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        return 30+bounds.size.height;
    }else{
        return [viewArr[indexPath.row-1] frame].size.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.backgroundColor = RGBCOLOR(239, 237, 237);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(151.5, 10, 17, 17)];
        [imageView setImage:[GetImagePath getImagePath:@"项目－评论列表_03a"]];
        [cell.contentView addSubview:imageView];
        
        CGRect bounds=[self.projectName boundingRectWithSize:CGSizeMake(288, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 27, 290, bounds.size.height)];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label.text = self.projectName;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = BlueColor;
        [cell.contentView addSubview:label];
        cell.selectionStyle = NO;
        //cell.backgroundColor = [UIColor yellowColor];
        return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell2"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        if (cell.contentView.subviews.count) {
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        [cell.contentView addSubview:viewArr[indexPath.row-1]];
        ProjectCommentView *view = viewArr[indexPath.row-1];
        ContactCommentModel *commentModel = showArr[indexPath.row-1];
        if([commentModel.a_createdBy isEqualToString:[LoginSqlite getdata:@"userId"]]){
            UIImageView *delImage = [[UIImageView alloc] initWithFrame:CGRectMake(280, (view.frame.size.height-20)/2, 21, 20)];
            delImage.image = [GetImagePath getImagePath:@"delComment"];
            [cell.contentView addSubview:delImage];
            
            UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            delBtn.frame = CGRectMake(270, delImage.frame.origin.y-10, 40, 40);
            //[delBtn setBackgroundColor:[UIColor yellowColor]];
            [delBtn addTarget:self action:@selector(delComment:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:delBtn];
        }
        cell.selectionStyle = NO;
        return cell;
    }
    return nil;
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
    if(indexPath.row !=0){
        return _datasource[[indexPath row]-1];
    }else{
        return nil;
    }
}

-(void)sureFromAddCommentWithComment:(NSString*)comment{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.projectId forKey:@"paramId"];
    [dic setValue:[NSString stringWithFormat:@"%@",comment] forKey:@"content"];
    [dic setValue:@"02" forKey:@"commentType"];
    [CommentApi AddEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        [addCommentView finishNetWork];
        if(!error){
            ContactCommentModel *model = [[ContactCommentModel alloc] init];
            model.a_id = posts[0];
            model.a_entityId = self.projectId;
            NSLog(@"userImage ==> %@",[LoginSqlite getdata:@"userImage"]);
            model.a_userName = [LoginSqlite getdata:@"userName"];
            model.a_avatarUrl = [LoginSqlite getdata:@"userImage"];
            model.a_commentContents = [NSString stringWithFormat:@"%@",comment];
            model.a_time = [NSDate date];
            [showArr insertObject:model atIndex:0];
            projectCommentView = [[ProjectCommentView alloc] initWithCommentModel:model];
            projectCommentView.delegate = self;
            [viewArr insertObject:projectCommentView atIndex:0];
            [_datasource insertObject:[NSDate date] atIndex:0];
            [MyTableView reloadDataWithTableView:self.tableView];
            if(showArr.count == 0){
                [MyTableView hasData:self.tableView];
            }
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } dic:dic noNetWork:nil];
}

-(void)cancelFromAddComment{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)gotoContactDetail:(NSString *)aid{
    if([aid isEqualToString:[LoginSqlite getdata:@"userId"]]){
        return;
    }
    PersonalDetailViewController *personalVC = [[PersonalDetailViewController alloc] init];
    personalVC.contactId = aid;
    [self.navigationController pushViewController:personalVC animated:YES];
}

-(void)delComment:(UIButton *)button{
    self.button = button;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"是否删除评论" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        UITableViewCell * cell = (UITableViewCell *)[[self.button superview] superview];
        NSIndexPath * path = [self.tableView indexPathForCell:cell];
        ContactCommentModel *model = showArr[path.row-1];
        [CommentApi DelEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                [showArr removeObjectAtIndex:path.row-1];
                [viewArr removeObjectAtIndex:path.row-1];
                [_datasource removeObjectAtIndex:path.row-1];
                NSArray *indexPaths = [NSArray arrayWithObject:path];
                [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }
        } dic:[@{@"commentId":model.a_id,@"commentType":@"02"} mutableCopy] noNetWork:nil];
    }
}

-(void)loginComplete{

}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    
}
@end
