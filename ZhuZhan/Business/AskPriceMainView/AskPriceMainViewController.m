//
//  AskPriceMainViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/17.
//
//

#import "AskPriceMainViewController.h"
#import "TopView.h"
#import "AddContactView.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
@interface AskPriceMainViewController ()<AddContactViewDelegate>
@property(nonatomic,strong)TopView *topView;
@property(nonatomic,strong)NSMutableArray *laberStrArr;
@property(nonatomic,strong)AddContactView *addContactView;
@end

@implementation AskPriceMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.title=@"发起询价";
    
    self.laberStrArr = [[NSMutableArray alloc] init];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.addContactView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)back{
    [self addAnimation];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)addAnimation{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"rippleEffect";
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

-(TopView *)topView{
    if(!_topView){
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 64.5, 320, 50) firstStr:@"询价需求填写" secondStr:@"流水号:1234567890" colorArr:@[[UIColor blackColor],[UIColor lightGrayColor]]];
    }
    return _topView;
}

-(AddContactView *)addContactView{
    if(!_addContactView){
        _addContactView = [[AddContactView alloc] init];
        _addContactView.delegate = self;
        _addContactView.backgroundColor = [UIColor yellowColor];
        [_addContactView GetHeightWithBlock:^(double height) {
            if(height<55){
                height = 55;
            }
            _addContactView.frame = CGRectMake(0, 64.5+53, 320, height);
        } labelArr:self.laberStrArr];
    }
    return _addContactView;
}

-(void)addContent{
    [self.laberStrArr removeAllObjects];
    [self.addContactView removeFromSuperview];
    self.addContactView = nil;
    int value = arc4random() % (5+1);
    NSLog(@"%d",value);
    for(int i=0;i<value;i++){
        [self.laberStrArr addObject:[NSString stringWithFormat:@"参与用户%d",i+1]];
    }
    [self.view addSubview:self.addContactView];
}

-(void)closeContent:(NSInteger)index{
    [self.laberStrArr removeObjectAtIndex:index];
    [self.addContactView removeFromSuperview];
    self.addContactView = nil;
    [self.view addSubview:self.addContactView];
}
@end
