//
//  ProgramDetailViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 14-8-26.
//
//

#import "ProgramDetailViewController.h"
#import "ProjectApi.h"
#import "LandInfo.h"
#import "MainDesign.h"
#import "MainBuild.h"
#import "DecorationProject.h"
#import "MyIndexPath.h"
#import "ProjectImageModel.h"
#import "ProjectContactModel.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "ProgramSelectViewCell.h"
#import "CycleScrollView.h"
#import "ProjectStage.h"
#import "AddCommentViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "CommentApi.h"
#import "LoginSqlite.h"
#import "LoginViewController.h"
#import "ProjectImageModel.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "IsFocusedApi.h"
#import "ProjectSqlite.h"
@interface ProgramDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ShowPageDelegate,UIScrollViewDelegate,ProgramSelectViewCellDelegate,CycleScrollViewDelegate,UIActionSheetDelegate,AddCommentDelegate,LoginViewDelegate>
@property(nonatomic,strong)UIView* themeView;
@property(nonatomic,strong)UITableView* contentTableView;
@property(nonatomic,strong)UITableView* selectTableView;
@property(nonatomic,strong)UIScrollView *selectScrollView;

@property(nonatomic,strong)LandInfo* landInfo;//土地信息
@property(nonatomic,strong)MainDesign* mainDesign;//主体设计
@property(nonatomic,strong)MainBuild* mainBuild;//主体施工
@property(nonatomic,strong)DecorationProject* decorationProject;//装修

@property(nonatomic,strong)UILabel* bigStageLabel;//上导航中 大阶段label
@property(nonatomic,strong)UILabel* smallStageLabel;//上导航中 小阶段label
@property(nonatomic,strong)UIImageView* bigStageImageView;//上导航中大阶段图片

@property(nonatomic,strong)NSMutableArray* contents;

@property(nonatomic,strong)UIActivityIndicatorView* animationView;//加载新view时的菊花动画
@property(nonatomic,strong)UIView* loadingView;
@property(nonatomic)BOOL isNeedAnimation;

@property(nonatomic)CGFloat loadNewViewStandardY;//判断是否需要加载新大阶段view的标准线

@property(nonatomic,strong)NSMutableArray* bigStageStandardY;
@property(nonatomic,strong)NSMutableArray* smallStageStandardY;

@property(nonatomic,strong)UIView* scrollViewBackground;

@property(nonatomic,strong)NSArray* allStages;//判断阶段的数组,包括所有阶段的数组

@property(nonatomic,strong)AddCommentViewController* addCommentVC;

@property(nonatomic,strong)UIActivityIndicatorView* indicatorView;

@property(nonatomic,strong)projectModel* model;

@property(nonatomic,strong)NSArray* bigStages;//不要直接访问该属性，请直接调用以下宏
#define BigStages(section) [self.bigStages[section] boolValue]

@property(nonatomic,strong)NSArray* stageIsNeedLoad;//不要直接访问该属性，请直接调用以下宏
#define StageIsNeedLoad(section) [self.stageIsNeedLoad[section] boolValue]

@property(nonatomic)BOOL needReloadStageIsNeedLoad;

@property(nonatomic,weak)UIView* lastStageView;

@property(nonatomic,strong)NSArray* smallTitles;
@property(nonatomic,strong)NSArray* bigTitles;
@property(nonatomic,strong)NSArray* bigStageImageNames;
@end

@implementation ProgramDetailViewController

-(NSArray *)bigStageImageNames{
    if (!_bigStageImageNames) {
        NSString* firstStage=@"筛选中01";
        NSString* secondStage=@"筛选中02";
        NSString* thirdStage=@"筛选中03";
        NSString* fourthStage=@"筛选中04";
        NSArray* allStages=@[firstStage,secondStage,thirdStage,fourthStage];
        NSMutableArray* tempArray=[NSMutableArray array];
        for (int i=0; i<4; i++) {
            if (BigStages(i)) {
                [tempArray addObject:allStages[i]];
            }
        }
        _bigStageImageNames=[tempArray copy];
    }
    return _bigStageImageNames;
}

-(NSArray *)bigTitles{
    if (!_bigTitles) {
        NSString* firstStage=@"土地信息阶段";
        NSString* secondStage=@"主体设计阶段";
        NSString* thirdStage=@"主体施工阶段";
        NSString* fourthStage=@"装修阶段";
        NSArray* allStages=@[firstStage,secondStage,thirdStage,fourthStage];
        NSMutableArray* tempArray=[NSMutableArray array];
        for (int i=0; i<4; i++) {
            if (BigStages(i)) {
                [tempArray addObject:allStages[i]];
            }
        }
        _bigTitles=[tempArray copy];
    }
    return _bigTitles;
}

-(NSArray *)smallTitles{
    if (!_smallTitles) {
        NSArray* firstStage=@[@"土地规划/拍卖",@"项目立项"];
        NSArray* secondStage=@[@"地勘阶段",@"设计阶段",@"出图阶段"];
        NSArray* thirdStage=@[@"地平",@"桩基基坑",@"主体施工",@"消防/景观绿化"];
        NSArray* fourthStage=@[@""];
        NSArray* allStages=@[firstStage,secondStage,thirdStage,fourthStage];
        NSMutableArray* tempArray=[NSMutableArray array];
        for (int i=0; i<4; i++) {
            if (BigStages(i)) {
                [tempArray addObjectsFromArray:allStages[i]];
            }
        }
        _smallTitles=[tempArray copy];
    }
    return _smallTitles;
}

-(UIView *)lastStageView{
    if (!_lastStageView) {
        for (NSInteger i=self.bigStages.count-1; i>=0; i--) {
            if (BigStages(i)) {
                switch (i) {
                    case 0:
                        _lastStageView=self.landInfo;
                        break;
                    case 1:
                        _lastStageView=self.mainDesign;
                        break;
                    case 2:
                        _lastStageView=self.mainBuild;
                        break;
                    case 3:
                        _lastStageView=self.decorationProject;
                        break;
                }
                return _lastStageView;
            }
        }
    }
    return _lastStageView;
}

-(NSArray *)stageIsNeedLoad{
    if (self.needReloadStageIsNeedLoad) {
        NSMutableArray* tempArray=[NSMutableArray arrayWithObject:@YES];
        for (int i=1; i<4; i++) {
            BOOL needLoad=YES;
            switch (i) {
                case 1:{
                    if (self.mainDesign||!BigStages(i)) {
                        needLoad=NO;
                    }
                }
                    break;
                case 2:{
                    if (self.mainBuild||!BigStages(i)) {
                        needLoad=NO;
                    }
                }
                    break;
                case 3:{
                    if (self.decorationProject||!BigStages(i)) {
                        needLoad=NO;
                    }
                }
            }
            [tempArray addObject:[NSNumber numberWithBool:needLoad]];
        }
        _stageIsNeedLoad=[tempArray copy];
        self.needReloadStageIsNeedLoad=NO;
    }
    return _stageIsNeedLoad;
}

-(NSArray *)bigStages{
    if (!_bigStages) {
        NSMutableArray* tempArray=[NSMutableArray array];
        int stagesCount[4]={2,3,4,1};
        int temp[4]={0,2,5,9};
        
        for (int i=0; i<4; i++) {
            BOOL stageLight=NO;
            for (NSString* str in [self.allStages subarrayWithRange:NSMakeRange(temp[i], stagesCount[i])]) {
                
                if (![str isEqualToString:@"none"]) {
                    stageLight=YES;
                    break;
                }
            }
            [tempArray addObject:[NSNumber numberWithBool:stageLight]];
        }
        _bigStages=[tempArray copy];
    }
    return _bigStages;
}

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    //恢复tabBar
//    AppDelegate* app=[AppDelegate instance];
//    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
//    [homeVC homePageTabBarRestore];
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    //隐藏tabBar
//    AppDelegate* app=[AppDelegate instance];
//    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
//    [homeVC homePageTabBarHide];
//}

-(void)loadIndicatorView{
    self.indicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicatorView.color=[UIColor blackColor];
    self.indicatorView.center=CGPointMake(160, self.view.frame.size.height*.5);
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
}

-(void)endIndicatorView{
    [self.indicatorView stopAnimating];
    [self.indicatorView removeFromSuperview];
    self.indicatorView=nil;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.needReloadStageIsNeedLoad=YES;
    [self insertData];
    [self initNavi];
    [self loadIndicatorView];
    [self firstNetWork];
}

-(void)insertData{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:self.projectId forKey:@"projectId"];
    [dic setValue:time forKey:@"time"];
    [ProjectSqlite InsertData:dic];
}

-(void)firstNetWork{
    if([[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        [self getContentList];
    }else{
        [IsFocusedApi GetIsFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.isFocused=[NSString stringWithFormat:@"%@",posts[0][@"isFocus"]];
                [self initNavi];
                [self getContentList];
            }else{
                if([ErrorCode errorCode:error] ==403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                        [self firstNetWork];
                    }];
                }
            }
        } userId:[LoginSqlite getdata:@"userId"] targetId:self.projectId noNetWork:^{
            [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                [self firstNetWork];
            }];
        }];
    }
}

-(void)getContentList{
    [ProjectApi SingleProjectWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            if(posts.count !=0){
                self.model = posts[0];
                [self.model getContacts:posts[1]];
                [self.model getImages:posts[2]];
                self.allStages=[ProjectStage JudgmentProjectDetailStage:self.model];
                [self loadSelf];
            }
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
        [self endIndicatorView];
    } projectId:self.projectId noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

-(void)loadSelf{
    [self initLoadingView];
    [self initThemeView];
    [self initContentTableView];
    [self initAnimationView];
    [self initSelectTableView];
}

-(void)initLoadingView{
    self.loadingView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 56)];
    self.loadingView.backgroundColor=RGBCOLOR(229, 229, 229);
    UIImageView* shadow=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 3.5)];
    shadow.image=[GetImagePath getImagePath:@"Shadow-bottom"];
    [self.loadingView addSubview:shadow];
}

-(void)initAnimationView{
    //动画view控制初始
    self.animationView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.animationView.color=[UIColor blackColor];
    [self.contentTableView addSubview:self.animationView];
    
    //是否需要动画初始
    self.isNeedAnimation=YES;
}

-(void)initContentTableView{
    self.landInfo=[LandInfo getLandInfoWithDelegate:self part:0];
    [[[self.landInfo.firstView.subviews[0] subviews][0]subviews][0] removeFromSuperview];
    
    self.contents=[[NSMutableArray alloc]init];
    [self contentsAddObject:self.landInfo];
    
    self.contentTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+50, 320, kScreenHeight-64-50) style:UITableViewStylePlain];
    self.contentTableView.dataSource=self;
    self.contentTableView.delegate=self;
    self.contentTableView.backgroundColor=RGBCOLOR(229, 229, 229);
    
    self.contentTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.contentTableView.showsVerticalScrollIndicator=NO;
    [self.view insertSubview:self.contentTableView belowSubview:self.themeView];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

//关注项目
-(void)rightBtnClick1{
    NSLog(@"rightBtnClick");
    if(![[LoginSqlite getdata:@"userId"] isEqualToString:@""]){
        if([self.isFocused isEqualToString:@"0"]){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.model.a_id forKey:@"targetId"];
            [dic setObject:@"03" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"1";
                    [self initNavi];
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:nil];
        }else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.model.a_id forKey:@"targetId"];
            [dic setObject:@"03" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"0";
                    [self initNavi];
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
    }else{
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.needDelayCancel=YES;
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
}

//分享
-(void)rightBtnClick2{
    NSLog(@"rightBtnClick1");
}

//评论列表
-(void)rightBtnClick3{
    NSLog(@"rightBtnClick");
    PorjectCommentTableViewController *projectCommentView = [[PorjectCommentTableViewController alloc] init];
    projectCommentView.projectId = self.projectId;
    projectCommentView.projectName = self.model.a_projectName;
    [self.navigationController pushViewController:projectCommentView animated:YES];
}

-(void)initNavi{
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];

    //RightButton设置属性
    UIButton *rightButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    BOOL isNoticed = [self.isFocused isEqualToString:@"1"];
    [rightButton1 setFrame:CGRectMake(65+(isNoticed?48:56), 0, 70, 44)];
    [rightButton1 setTitle:isNoticed?@"取消关注":@"加关注" forState:UIControlStateNormal];
    [rightButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton1.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton1 addTarget:self action:@selector(rightBtnClick1) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *rightButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton2 setFrame:CGRectMake(135, 0, 45, 44)];
//    [rightButton2 setTitle:@"分享" forState:UIControlStateNormal];
//    [rightButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    rightButton2.titleLabel.font = [UIFont systemFontOfSize:16];
//    [rightButton2 addTarget:self action:@selector(rightBtnClick2) forControlEvents:UIControlEventTouchUpInside];

    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 44)];
    [view addSubview:rightButton1];
    //[view addSubview:rightButton2];
    
    self.navigationItem.titleView = view;

    UIButton *rightButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton3 setFrame:CGRectMake(0, 0, 32, 44)];
    [rightButton3 setTitle:@"评论" forState:UIControlStateNormal];
    [rightButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton3.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightButton3 addTarget:self action:@selector(rightBtnClick3) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton3];
    
    self.navigationItem.rightBarButtonItem = barBtnItem;
}

-(void)initThemeView{
    //画布themeView初始
    self.themeView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, 320, 50)];
    self.themeView.backgroundColor=AllBackMiddleGrayColor;//[UIColor whiteColor];
    [self.view addSubview:self.themeView];
    
    //大标题左边的大阶段图片
    UIImage* image=[GetImagePath getImagePath:@"筛选中01"];
    CGRect frame=CGRectMake(20, 15, image.size.width, image.size.height);
    self.bigStageImageView=[[UIImageView alloc]initWithFrame:frame];
    self.bigStageImageView.image=image;
    [self.themeView addSubview:self.bigStageImageView];
    
    //大阶段标题label
    self.bigStageLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 150, 30)];
    self.bigStageLabel.text=@"土地信息阶段";
    self.bigStageLabel.font=[UIFont systemFontOfSize:16];
    [self.themeView addSubview:self.bigStageLabel];
    
    //小阶段标题label
    self.smallStageLabel=[[UILabel alloc]initWithFrame:CGRectMake(170, 10, 110, 30)];
    self.smallStageLabel.text=@"土地规划/拍卖";
    self.smallStageLabel.textColor=[UIColor grayColor];
    self.smallStageLabel.font=[UIFont systemFontOfSize:14];
    self.smallStageLabel.textAlignment=NSTextAlignmentRight;
    [self.themeView addSubview:self.smallStageLabel];
    
    //右箭头imageView
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(280, 14, 25, 22)];
    imageView.image=[GetImagePath getImagePath:@"012"];
    [self.themeView addSubview:imageView];
    
    //上导航栏themeView第二部分,上导航下方阴影
    UIImageView* shadowView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 320, 3)];
    shadowView.image=[GetImagePath getImagePath:@"Shadow-top"];
    //shadowView.alpha=.5;
    [self.themeView addSubview:shadowView];
    
    //使该view被点击可以触发
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    [button addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.themeView addSubview:button];
}

-(void)initSelectTableView{
    self.selectTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568-64) style:UITableViewStylePlain];
    self.selectTableView.delegate=self;
    self.selectTableView.dataSource=self;
    //self.selectTableView.center=CGPointMake(160, -(568-64)*.5);
    [self.selectTableView registerClass:[ProgramSelectViewCell class] forCellReuseIdentifier:@"Cell"];
    self.selectTableView.showsVerticalScrollIndicator=NO;
    self.selectTableView.scrollEnabled=NO;
    self.selectTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.selectTableView.backgroundColor=[UIColor colorWithWhite:1 alpha:.90];
    
    self.selectScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight-64.5)];
    self.selectScrollView.contentSize = self.selectTableView.frame.size;
    self.selectScrollView.center=CGPointMake(160, -(kScreenHeight-64.5)*.5);
    [self.selectScrollView addSubview:self.selectTableView];
    
    [self.view addSubview:self.selectScrollView];
    //用于存放使sectionHeader可以被点击的button的array
    //self.sectionButtonArray=[NSMutableArray array];
}

//******************************************************************
//UIActionSheetDelegate,AddCommentDelegate
//******************************************************************

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    if (buttonIndex==0) {
        if([self.isFocused isEqualToString:@"0"]){
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.model.a_id forKey:@"targetId"];
            [dic setObject:@"03" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"1";
                }else{
                    if([ErrorCode errorCode:error] == 403){
                        [LoginAgain AddLoginView:NO];
                    }else{
                        [ErrorCode alert];
                    }
                }
            } dic:dic noNetWork:nil];
        }else{
            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
            [dic setObject:self.model.a_id forKey:@"targetId"];
            [dic setObject:@"03" forKey:@"targetCategory"];
            [IsFocusedApi AddFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
                if(!error){
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"取消关注成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                    self.isFocused = @"0";
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
        
    }else if (buttonIndex==1){
        NSLog(@"评论");
        self.addCommentVC=[[AddCommentViewController alloc]init];
        self.addCommentVC.delegate=self;
        [self presentPopupViewController:self.addCommentVC animationType:MJPopupViewAnimationFade flag:2];
    }else if (buttonIndex==2){
        PorjectCommentTableViewController *projectCommentView = [[PorjectCommentTableViewController alloc] init];
        projectCommentView.projectId = self.projectId;
        projectCommentView.projectName = self.model.a_projectName;
        [self.navigationController pushViewController:projectCommentView animated:YES];
    }else{
        NSLog(@"取消");
    }
}

-(void)cancelFromAddComment{
    NSLog(@"cancelFromAddComment");
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
// "EntityId": ":entity ID", （项目，产品，公司，动态等）
// "entityType": ":”entityType", Personal,Company,Project,Product 之一
// "CommentContents": "评论内容",
// "CreatedBy": ":“评论人"
-(void)sureFromAddCommentWithComment:(NSString *)comment{
    NSLog(@"sureFromAddCommentWithCommentModel:");
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    
    [CommentApi AddEntityCommentsWithBlock:^(NSMutableArray *posts, NSError *error) {
        [self.addCommentVC finishNetWork];
        if (!error) {
            NSLog(@"sucess");
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } dic:[@{@"paramId":self.model.a_id,@"commentType":@"02",@"content":comment} mutableCopy] noNetWork:^{
        [ErrorCode alert];
    }];
}

//***************************************************************
//***************************************************************
//***************************************************************

-(void)change{
    NSLog(@"用户选择了筛选");
    self.isNeedAnimation=NO;
    //[self.view addSubview:self.selectTableView];
    [self.view addSubview:self.selectScrollView];
    [UIView animateWithDuration:0.5 animations:^{
        self.selectScrollView.center=CGPointMake(160, (kScreenHeight-64)*.5+64);
    }];
}

-(CGFloat)loadNewViewStandardY{
    if (1) {
        if (StageIsNeedLoad(1)) {
            return self.landInfo.frame.size.height+56;
        }else if (StageIsNeedLoad(2)){
            return self.landInfo.frame.size.height+self.mainDesign.frame.size.height+56;
        }else if (StageIsNeedLoad(3)){
            return  self.landInfo.frame.size.height+self.mainDesign.frame.size.height+self.mainBuild.frame.size.height+56;
        }else{
            return CGFLOAT_MAX;
        }
    }else{
        if (!self.mainDesign) {
            return self.landInfo.frame.size.height+56;
        }else if (!self.mainBuild){
            return self.landInfo.frame.size.height+self.mainDesign.frame.size.height+56;
        }else if (!self.decorationProject){
            return  self.landInfo.frame.size.height+self.mainDesign.frame.size.height+self.mainBuild.frame.size.height+56;
        }else{
            return CGFLOAT_MAX;
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y+568-64-50>=self.loadNewViewStandardY) {
        for (int i=1; i<4; i++) {
            BOOL sucess=[self addNewViewWithStage:i scrollView:scrollView];
            if(sucess) break;
        }
    }
    
    // NSArray* smallTitles=@[@"土地规划/拍卖",@"项目立项",@"地勘阶段",@"设计阶段",@"出图阶段",@"地平",@"桩基基坑",@"主体施工",@"消防/景观绿化",@""];
    // NSArray* bigTitles=@[@"土地信息阶段",@"主体设计阶段",@"主体施工阶段",@"装修阶段"];
    //NSArray* bigStageImageNames=@[@"筛选中01",@"筛选中02",@"筛选中03",@"筛选中04"];
    
    for (int i=0; i<self.bigStageStandardY.count; i++) {
        if (scrollView.contentOffset.y+568-64-50<[self.bigStageStandardY[i] floatValue]) {
            //大阶段名称
            self.bigStageLabel.text=self.bigTitles[i];
            
            //大阶段左边图标
            UIImage* image=[GetImagePath getImagePath:self.bigStageImageNames[i]];
            CGPoint center=self.bigStageImageView.center;
            CGRect frame=CGRectMake(0, 0, image.size.width, image.size.height);
            self.bigStageImageView.frame=frame;
            self.bigStageImageView.image=image;
            self.bigStageImageView.center=center;
            
            break;
        }
    }
    
    for (int i=0; i<self.smallStageStandardY.count; i++) {
        //小阶段名称
        if (scrollView.contentOffset.y+568-64-50<[self.smallStageStandardY[i] floatValue]) {
            self.smallStageLabel.text=self.smallTitles[i];
            break;
        }
    }
}

-(UIView*)loadSpecifiedViewWithStage:(NSInteger)stage{
    if (!StageIsNeedLoad(stage)) return nil;
    self.needReloadStageIsNeedLoad=YES;
    UIView* view;
    switch (stage) {
        case 1:{
            view=self.mainDesign=[MainDesign getMainDesignWithDelegate:self part:stage];
        }
            break;
        case 2:{
            view=self.mainBuild=[MainBuild getMainBuildWithDelegate:self part:stage];
        }
            break;
        case 3:{
            view=self.decorationProject=[DecorationProject getDecorationProjectWithDelegate:self part:stage];
        }
            break;
    }
    return view;
}

-(BOOL)addNewViewWithStage:(NSInteger)stage scrollView:(UIScrollView*)scrollView{
    UIView* view=[self loadSpecifiedViewWithStage:stage];
    if (!view) return NO;
    //根据是否需要动画情况进行加载
    if (self.isNeedAnimation) {
        self.animationView.center=CGPointMake(160, scrollView.contentSize.height-40);
        if (!self.animationView.isAnimating) {
            [self.animationView startAnimating];
        }
        
        //动画区域显示正在加载哪个view的label
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        NSString* tempStr;
        if (view==self.mainDesign) {
            tempStr=@"主体设计";
        }else if(view==self.mainBuild){
            tempStr=@"主体施工";
        }else{
            tempStr=@"装修";
        }
        tempStr=[NSString stringWithFormat:@"正在加载 %@ 阶段",tempStr];
        NSMutableAttributedString* attStr=[[NSMutableAttributedString alloc]initWithString:tempStr];
        [attStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(82, 125, 237) range:NSMakeRange(4, tempStr.length-6)];
        label.attributedText=[attStr copy];
        label.font=[UIFont systemFontOfSize:15];
        label.textAlignment=NSTextAlignmentCenter;
        label.center=CGPointMake(160, self.contentTableView.contentSize.height-20);
        [self.contentTableView addSubview:label];
        
        UIView* tempView=[[UIView alloc]initWithFrame:self.selectScrollView.bounds];
        [self.selectScrollView addSubview:tempView];
        
        CGRect frame=self.animationView.frame;
        frame.size.height+=.000001;
        [UIView animateWithDuration:1 animations:^{
            self.animationView.frame=frame;
        } completion:^(BOOL finished) {
            if (self.animationView.isAnimating) {
                [self.animationView stopAnimating];
            }
            [tempView removeFromSuperview];
            [label removeFromSuperview];
            [self contentsAddObject:view];
        }];
    }else{
        //将内容添加进cell的内容数组
        [self contentsAddObject:view];
    }
    return YES;
}

-(void)contentsAddObject:(UIView*)view{
    //用于判断现在是哪个大阶段和小阶段的标准线
    if (!self.bigStageStandardY) {
        self.bigStageStandardY=[[NSMutableArray alloc]init];
        self.smallStageStandardY=[[NSMutableArray alloc]init];
    }
    
    CGFloat height=0;
    for (int i=0; i<view.subviews.count; i++) {
        height+=[view.subviews[i] frame].size.height;
        CGFloat tempHeight=self.bigStageStandardY.count>0?[self.bigStageStandardY.lastObject floatValue]:0;
        
        [self.smallStageStandardY addObject:[NSNumber numberWithFloat:(tempHeight+height)]];
    }
    
    height=0;
    height=self.bigStageStandardY.count?[self.bigStageStandardY.lastObject floatValue]:0;
    height+=view.frame.size.height;
    [self.bigStageStandardY addObject:[NSNumber numberWithFloat:height]];
    
    
    if (self.contents.count) {
        [self.contents removeLastObject];
    }
    for (int i=0; i<view.subviews.count; i++) {
        [self.contents addObject:view.subviews[i]];
    }
    if (view!=self.lastStageView) {
        [self.contents addObject:self.loadingView];
    }
    if (view!=self.landInfo) {
        [self.contentTableView reloadData];
    }
}

//筛选界面拉回去
-(void)selectCancel{
    self.isNeedAnimation=YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.selectScrollView.center=CGPointMake(160, -(kScreenHeight-64)*.5);
    } completion:^(BOOL finished){
        [self.selectScrollView removeFromSuperview];
    }];
}

//***************************************************************
//***************************************************************
//***************************************************************

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contentTableView) {
    }else{
        if (BigStages(indexPath.section)) {
            
            //为了让sectionHeader可以被点击,所以将cell被点击之后实现的跳转加载功能封装到其他方法
            [self didchangeStageSection:indexPath.section row:indexPath.row];
        }
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BOOL stageLight=BigStages(section);
    NSArray* path=stageLight?@[@"筛选中01",@"筛选中02",@"筛选中03",@"筛选中04"]:@[@"01",@"02",@"03",@"04"];
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 37.5)];
    
    UIImage* image=[GetImagePath getImagePath:path[section]];
    CGRect frame=CGRectMake(0, 0, image.size.width, image.size.height);
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.center=CGPointMake(23.5, 39.5*.5);
    imageView.image=image;
    [view addSubview:imageView];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(47, 12, 200, 16)];
    NSArray* ary=@[@"土地信息阶段",@"主体设计阶段",@"主体施工阶段",@"装修阶段"];
    label.text=ary[section];
    label.textColor=stageLight?[UIColor blackColor]:RGBCOLOR(197, 197, 197);
    label.font=[UIFont boldSystemFontOfSize:16];
    [view addSubview:label];
    
    UIView* separatorLine=[[UIView alloc]initWithFrame:CGRectMake(47, 36.5, 273, 1)];
    separatorLine.backgroundColor=stageLight?RGBCOLOR(96, 96, 96):RGBCOLOR(190, 190, 190);
    [view addSubview:separatorLine];
    
    //使该sectionHeader可以被点击
    if (stageLight) {
        UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 37.5)];
        button.tag=section;
        [button addTarget:self action:@selector(selectSection:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
    }
    return view;
}

//判断用户点击的是哪个sectionHeader,然后将section传过去
-(void)selectSection:(UIButton*)button{
    [self didchangeStageSection:button.tag row:0];
}

-(void)didchangeStageSection:(NSInteger)section row:(NSInteger)row{
#warning 考虑以下for循环是否可优化
    for (int i=1; i<=section; i++) {//土地信息阶段必存在，不用判断和操作
        [self addNewViewWithStage:i scrollView:self.contentTableView];
    }
    //如果导致装修的界面需要被动画加载出来，则进行无动画加载装修view
    //if (!self.decorationProject&&section==2&&row==3) {
        //计算坐标比较复杂，直接从结果中判断是否需要加载装修页面,判断下来,当用户点击第三大阶段第四小阶段时,需要无动画加载装修
        //[self addNewViewWithStage:3 scrollView:self.contentTableView];
        //        self.decorationProject=[DecorationProject getDecorationProjectWithDelegate:self part:3];
        //        [self addNewView:self.decorationProject scrollView:self.contentTableView];
    //}
    NSInteger smallStageCount[4]={2,3,4,1};
    NSInteger sumSmallStage=0;
    for (int i=0; i<section; i++) {
        if (BigStages(i)) {
            sumSmallStage+=smallStageCount[i];
        }
    }
    sumSmallStage+=row;
    
    CGFloat height=0;
    for (int j=0; j<sumSmallStage; j++) {
        height+=[self.contents[j] frame].size.height;
    }
    
    [self.contentTableView setContentOffset:CGPointMake(0, height) animated:YES];
    [self selectCancel];
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contentTableView) {
        return NO;
    }else{
        if (indexPath.section==3) {
            return NO;
        }else{
            return BigStages(indexPath.section);
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return tableView==self.contentTableView?1:4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.contentTableView) {
        return self.contents.count;
    }else{
        NSInteger count[4]={2,3,4,1};
        return count[section];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contentTableView) {
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        if (cell.contentView.subviews.count) {
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
        [cell.contentView addSubview:self.contents[indexPath.row]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        BOOL first,second,third;
        BOOL stageLight=BigStages(indexPath.section);
        int temp[4]={0,2,5,9};
        
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                first=self.model.auctionContacts.count?YES:NO;
                second=self.model.auctionImages.count?YES:NO;
                third=[self.allStages[temp[indexPath.section]+indexPath.row] isEqualToString:@"all"]?YES:NO;
            }else{
                first=self.model.ownerContacts.count?YES:NO;
                second=NO;
                third=[self.allStages[temp[indexPath.section]+indexPath.row] isEqualToString:@"all"]?YES:NO;
            }
        }else if (indexPath.section==1){
            if (indexPath.row==0) {
                first=self.model.explorationContacts.count?YES:NO;
                second=self.model.explorationImages.count?YES:NO;
                third=[self.allStages[temp[indexPath.section]+indexPath.row] isEqualToString:@"all"]?YES:NO;
            }else if (indexPath.row==1){
                first=self.model.designContacts.count?YES:NO;
                second=NO;
                third=[self.allStages[temp[indexPath.section]+indexPath.row] isEqualToString:@"all"]?YES:NO;
            }else{
                first=self.model.ownerContacts.count?YES:NO;
                second=NO;
                third=[self.allStages[temp[indexPath.section]+indexPath.row] isEqualToString:@"all"]?YES:NO;
            }
        }else{
            if (indexPath.row==0){
                first=self.model.constructionContacts.count?YES:NO;
                second=self.model.constructionImages.count?YES:NO;
                third=[self.allStages[temp[indexPath.section]+indexPath.row] isEqualToString:@"all"]?YES:NO;
            }else if (indexPath.row==1){
                first=self.model.pileContacts.count?YES:NO;
                second=self.model.pileImages.count?YES:NO;
                third=[self.allStages[temp[indexPath.section]+indexPath.row] isEqualToString:@"all"]?YES:NO;
            }else if (indexPath.row==2){
                first=NO;
                second=self.model.mainBulidImages.count?YES:NO;
                third=[self.allStages[temp[indexPath.section]+indexPath.row] isEqualToString:@"all"]?YES:NO;
            }else{
                first=NO;
                second=NO;
                third=[self.allStages[temp[indexPath.section]+indexPath.row] isEqualToString:@"all"]?YES:NO;
            }
        }
        //图片本来是分阶段的，所以需要在参数secondIcon中传入对应的有无图片的值去判断，现在图片全部到第一个阶段了，所以不用区分图片在哪个阶段里有了，所以全部secondIcon全部传NO
        //原代码为
        //ProgramSelectViewCell* cell=[ProgramSelectViewCell dequeueReusableCellWithTabelView:tableView identifier:@"Cell" indexPath:indexPath firstIcon:first secondIcon:second thirdIcon:third stageLight:stageLight];
        ProgramSelectViewCell* cell=[ProgramSelectViewCell dequeueReusableCellWithTabelView:tableView identifier:@"Cell" indexPath:indexPath firstIcon:first secondIcon:NO thirdIcon:third stageLight:stageLight];

        cell.delegate=self;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.contentTableView) {
        CGRect frame=[self.contents[indexPath.row] frame];
        return frame.size.height;
    }else{
        if (indexPath.section==3) {
            return 40;
        }else{
            return 34;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableView==self.contentTableView?0:37.5;
}

-(void)chooseImageViewWithIndexPath:(MyIndexPath *)indexPath{
//    以下为每个阶段都有图片时的代码，关键在于temp的赋值
//    NSArray* part0=@[self.model.auctionImages];
//    NSArray* part1=@[self.model.explorationImages];
//    NSArray* part2=@[self.model.constructionImages,self.model.pileImages,self.model.mainBulidImages];
//    NSArray* part3=@[self.model.decorationImages];
//    NSArray* array=@[part0,part1,part2,part3];
    
    //以下为只有第一个阶段需要图片的代码，关键在于temp的赋值
    NSMutableArray* array = [NSMutableArray array];
    [array addObjectsFromArray:self.model.auctionImages];
    [array addObjectsFromArray:self.model.explorationImages];
    [array addObjectsFromArray:self.model.constructionImages];
    [array addObjectsFromArray:self.model.pileImages];
    [array addObjectsFromArray:self.model.mainBulidImages];
    [array addObjectsFromArray:self.model.decorationImages];
    
    [self addScrollViewWithUrls:array];
//    [self addScrollViewWithUrls:array[indexPath.part][indexPath.section]];
}

-(void)addScrollViewWithUrls:(NSMutableArray*)imageModels{
    self.scrollViewBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    self.scrollViewBackground.backgroundColor=[UIColor blackColor];
    
    AppDelegate* app=[AppDelegate instance];
    [app.window.rootViewController.view addSubview:self.scrollViewBackground];
    
    CycleScrollView* scrollView =[[CycleScrollView alloc]initWithFrame:self.scrollViewBackground.frame cycleDirection:CycleDirectionLandscape pictures:imageModels];
    scrollView.delegate=self;
    [self.scrollViewBackground addSubview:scrollView];
}

-(void)cycleScrollViewDelegate:(CycleScrollView *)cycleScrollView didSelectImageView:(int)index{
    [self.scrollViewBackground removeFromSuperview];
    self.scrollViewBackground=nil;
}

//***************************************************************
//***************************************************************
//***************************************************************

//program大块 三行
-(NSArray*)getThreeLinesTitleViewWithThreeStrsWithIndexPath:(MyIndexPath*)indexPath{
    if (indexPath.section==0) {
        return @[self.model.a_landName,[NSString stringWithFormat:@"%@ %@ %@",self.model.a_province,self.model.a_city,self.model.a_district],self.model.a_landAddress];
    }else{
        return @[self.model.a_projectName,[NSString stringWithFormat:@"%@ %@ %@",self.model.a_city,self.model.a_district,self.model.a_landAddress],self.model.a_description];
    }
}

//图加图的数量
-(NSArray*)getImageViewWithImageAndCountWithIndexPath:(MyIndexPath*)indexPath{
//以下为每个阶段都有图片时的代码，关键在于temp的赋值
//    NSArray* part0=@[self.model.auctionImages];
//    NSArray* part1=@[self.model.explorationImages];
//    NSArray* part2=@[self.model.constructionImages,self.model.pileImages,self.model.mainBulidImages];
//    NSArray* part3=@[self.model.decorationImages];
//    NSArray* array=@[part0,part1,part2,part3];
//    NSArray* temp=array[indexPath.part][indexPath.section];
    
    //以下为只有第一个阶段需要图片的代码，关键在于temp的赋值
    NSMutableArray* temp = [NSMutableArray array];
    [temp addObjectsFromArray:self.model.auctionImages];
    [temp addObjectsFromArray:self.model.explorationImages];
    [temp addObjectsFromArray:self.model.constructionImages];
    [temp addObjectsFromArray:self.model.pileImages];
    [temp addObjectsFromArray:self.model.mainBulidImages];
    [temp addObjectsFromArray:self.model.decorationImages];
    
    NSMutableArray* imageUrls=[[NSMutableArray alloc]init];
    for (int i=0; i<temp.count; i++) {
        ProjectImageModel* model=temp[i];
        NSLog(@"a_imageOriginalLocation====%@",model.a_imageOriginalLocation);
        [imageUrls addObject:model.a_imageOriginalLocation];
    }
    return imageUrls;
}

//第一行蓝，第二行黑的view
-(NSArray*)getBlueTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath{
    //NSLog(@"------> %@,%@",self.model.a_area,self.model.a_storeyArea);
    if (indexPath.section==0) {
        return @[self.model.a_area,self.model.a_plotRatio,self.model.a_usage];
    }else{
        return @[self.model.a_exceptStartTime,self.model.a_storeyHeight,self.model.a_foreignInvestment,self.model.a_exceptFinishTime,self.model.a_investment,self.model.a_storeyArea];
    }
}

//联系人view
-(NSArray*)getThreeContactsViewThreeTypesFiveStrsWithIndexPath:(MyIndexPath*)indexPath{
    NSArray* array;
    if (indexPath.part==0) {
        array=@[self.model.auctionContacts,self.model.ownerContacts];
    }else if (indexPath.part==1){
        array=@[self.model.explorationContacts,self.model.designContacts,self.model.ownerContacts];
    }else{
        array=@[self.model.constructionContacts,self.model.pileContacts];
    }
    return array[indexPath.section];
}

//program大块 二行
-(NSArray*)getTwoLinesTitleViewFirstStrsAndSecondStrsWithIndexPath:(MyIndexPath*)indexPath{
    if (indexPath.part==1) {
        NSArray* array=@[@[self.model.a_mainDesignStage],@[self.model.a_exceptStartTime,self.model.a_exceptFinishTime]];
        return array[indexPath.section-1];
    }else{
        NSArray* array=@[self.model.a_actureStartTime];
        return array;
    }
}

//硬件设备以及yes和no
-(NSArray*)getDeviceAndBoolWithDevicesAndBoolStrsWithIndexPath:(MyIndexPath*)indexPath{
    return @[self.model.a_elevator,self.model.a_airCondition,self.model.a_heating,self.model.a_externalWallMeterial,self.model.a_stealStructure];
}

//第一行黑，第二行灰的view
-(NSArray*)getBlackTwoLinesWithStrsWithIndexPath:(MyIndexPath*)indexPath{
    if (indexPath.part==2) {
        return @[self.model.a_fireControl,self.model.a_green];
    }else{
        return @[self.model.a_electorWeakInstallation,self.model.a_decorationSituation,self.model.a_decorationProcess];
    }
}

//业主类型内容
-(NSArray*)getOwnerTypeViewWithImageAndOwnersWithIndexPath:(MyIndexPath*)indexPath{
    return [self.model.a_ownerType componentsSeparatedByString:@","];
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    [IsFocusedApi GetIsFocusedListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.isFocused = [NSString stringWithFormat:@"%@",posts[0][@"isFocus"]];
            [self initNavi];
            if (block) {
                block();
            }
        }else{
            [LoginAgain AddLoginView:NO];
        }
    } userId:[LoginSqlite getdata:@"userId"] targetId:self.projectId noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}
@end
