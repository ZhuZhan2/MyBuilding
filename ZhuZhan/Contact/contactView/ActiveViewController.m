//
//  ActiveViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/18.
//
//

#import "ActiveViewController.h"
#import "LoginSqlite.h"
#import "LoginViewController.h"
#import "PublishViewController.h"
#import "RKStageChooseView.h"
#import "AllDynamicListViewController.h"
#import "MyDynamicListViewController.h"

@interface ActiveViewController ()<LoginViewDelegate,RKStageChooseViewDelegate>
@property(nonatomic,strong)RKStageChooseView *stageChooseView;
@property(nonatomic,strong)AllDynamicListViewController *allDynamicListView;
@property(nonatomic,strong)MyDynamicListViewController *myDynamicListView;
@end

@implementation ActiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:19], NSFontAttributeName,nil]];
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 30)];
    //[rightButton setBackgroundImage:[GetImagePath getImagePath:@"项目-首页_03a"] forState:UIControlStateNormal];
    [leftButton setTitle:@"首页" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 60, 22)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitle:@"发布动态" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"人脉";
    
    [self initStageChooseViewWithStages:@[@"全部动态",@"我的动态"] numbers:nil underLineIsWhole:YES normalColor:AllLightGrayColor highlightColor:BlueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftBtnClick{
    if([self.delegate respondsToSelector:@selector(backGotoMarketView)]){
        [self.delegate backGotoMarketView];
    }
}

-(void)publish
{
    NSLog(@"发布产品");
    
    NSString *deviceToken = [LoginSqlite getdata:@"token"];
    
    if ([deviceToken isEqualToString:@""]) {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        //ActivePublishController *publishVC = [[ActivePublishController alloc] init];
        PublishViewController *publishVC = [[PublishViewController alloc] init];
        [self.navigationController pushViewController:publishVC animated:YES];
    }
}

-(void)initStageChooseViewWithStages:(NSArray*)stages numbers:(NSArray*)numbers underLineIsWhole:(BOOL)underLineIsWhole normalColor:(UIColor *)normalColor highlightColor:(UIColor *)highlightColor{
    self.stageChooseView=[RKStageChooseView stageChooseViewWithStages:
                          stages numbers:numbers delegate:self underLineIsWhole:underLineIsWhole normalColor:normalColor highlightColor:highlightColor];
    CGRect frame=self.stageChooseView.frame;
    frame.origin=CGPointMake(0, 64);
    self.stageChooseView.frame=frame;
    [self.view addSubview:self.stageChooseView];
}

- (BOOL)shouldChangeStageToNumber:(NSInteger)stageNumber{
    BOOL canChange = !(stageNumber == 1 && [[LoginSqlite getdata:@"userId"] isEqualToString:@""]);
    if (!canChange) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.delegate = self;
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }
    return canChange;
}

- (void)stageBtnClickedWithNumber:(NSInteger)stageNumber{
    switch (stageNumber) {
        case 0:
            [self.myDynamicListView.view removeFromSuperview];
            self.myDynamicListView = nil;
            [self addAllDynamicListView];
            break;
        case 1:
            if([[LoginSqlite getdata:@"token"] isEqualToString:@""]){
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                loginVC.delegate = self;
                loginVC.needDelayCancel = YES;
                UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
                [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
            }else{
                [self.allDynamicListView.view removeFromSuperview];
                self.allDynamicListView = nil;
                [self addMyDynamicListView];
            }
            break;
        default:
            break;
    }
}

-(void)addAllDynamicListView{
    if(self.allDynamicListView == nil){
        self.allDynamicListView = [[AllDynamicListViewController alloc] init];
        self.allDynamicListView.nowViewController = self;
        self.allDynamicListView.view.center = CGPointMake(160, kScreenHeight/2+64+46);
    }
    [self.view insertSubview:self.allDynamicListView.view atIndex:0];
}

-(void)addMyDynamicListView{
    if(self.myDynamicListView == nil){
        self.myDynamicListView = [[MyDynamicListViewController alloc] init];
        self.myDynamicListView.nowViewController = self;
        self.myDynamicListView.view.center = CGPointMake(160, kScreenHeight/2+64+46);
    }
    [self.view insertSubview:self.myDynamicListView.view atIndex:0];
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{
    [self.allDynamicListView.view removeFromSuperview];
    self.allDynamicListView = nil;
    [self addMyDynamicListView];
    if(block){
        block();
    }
}
@end
