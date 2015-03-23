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
#import "AddCategoriesView.h"
#import "AddClassificationView.h"
#import "AddMarkView.h"
#import "SearchContactViewController.h"
#import "ChooseProductBigStage.h"
#import "ChooseProductSmallStage.h"
#import "AskPriceApi.h"
#import "LoginSqlite.h"
#import "LoginViewController.h"
#import "AskPriceViewController.h"
@interface AskPriceMainViewController ()<AddContactViewDelegate,UITableViewDelegate,UITableViewDataSource,AddMarkViewDelegate,SearchContactViewDelegate,ChooseProductBigStageDelegate,ChooseProductSmallStageDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)TopView *topView;
@property(nonatomic,strong)NSMutableArray *laberStrArr;
@property(nonatomic,strong)AddContactView *addContactView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *viewArr;
@property(nonatomic)int addContactViewHeight;
@property(nonatomic,strong)AddCategoriesView *addCategoriesView;
@property(nonatomic)int addCategoriesViewHeight;
@property(nonatomic,strong)NSString *categoryStr;
@property(nonatomic,strong)AddClassificationView *addClassificationView;
@property(nonatomic)int addClassificationViewHeight;
@property(nonatomic,strong)NSString *classifcationStr;
@property(nonatomic)BOOL isSelect2;
@property(nonatomic,strong)AddMarkView *addMarkView;
@property(nonatomic,strong)NSString *remarkStr;
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
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 40, 19.5)];
    [rightButton setTitle:@"提交" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    rightButton.titleLabel.textColor = [UIColor whiteColor];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.laberStrArr = [[NSMutableArray alloc] init];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    self.viewArr = [[NSMutableArray alloc] init];
    [self.viewArr addObject:self.addContactView];
    [self.viewArr addObject:self.addCategoriesView];
    [self.viewArr addObject:self.addClassificationView];
    [self.viewArr addObject:self.addMarkView];
    self.isSelect2 = NO;
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

-(void)rightAction{
    if([[LoginSqlite getdata:@"token"] isEqualToString:@""]){
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"ef190673-0f57-4a78-aa07-e86d3edf2262,4dab083a-3f09-4854-839a-f45995b6047f" forKey:@"invitedUser"];
        [dic setValue:self.categoryStr forKey:@"productBigCategory"];
        [dic setValue:[self.classifcationStr stringByReplacingOccurrencesOfString:@"、" withString:@","] forKey:@"productCategory"];
        [dic setValue:self.remarkStr forKey:@"remark"];
        [AskPriceApi PostAskPriceWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发起成功是否去列表查看" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alertView show];
            }
        } dic:dic noNetWork:nil];
        
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setValue:@"88B756B709D6" forKey:@"tradeCode"];
//        [dic setValue:@"4e05abd0-db44-4b32-a6f3-393952cc1ecc" forKey:@"bookBuildingId"];
//        [dic setValue:@"岳志强fuck" forKey:@"quoteContent"];
//        [dic setValue:self.remarkStr forKey:@"remark"];
//        [AskPriceApi AddQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
//            if(!error){
//            
//            }
//        } dic:dic noNetWork:nil];
        
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:@"4e05abd0-db44-4b32-a6f3-393952cc1ecc" forKey:@"tradeId"];
//        [dic setValue:@"88B756B709D6" forKey:@"tradeCode"];
//        [dic setValue:@"岳志强fuck 2次" forKey:@"contents"];
//        [dic setValue:@"d859009b-51b4-4415-ada1-d5ea09ca4130:ef190673-0f57-4a78-aa07-e86d3edf2262" forKey:@"tradeUserAndCommentUser"];
//        [AskPriceApi AddCommentWithBlock:^(NSMutableArray *posts, NSError *error) {
//            if(!error){
//            
//            }
//        } dic:dic noNetWork:nil];
        
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//        [dic setObject:@"3e18a108-7dca-4c29-9d0a-3fd2a41a8f1b" forKey:@"id"];
//        [AskPriceApi AcceptQuotesWithBlock:^(NSMutableArray *posts, NSError *error) {
//            if(!error){
//            
//            }
//        } dic:dic noNetWork:nil];
    }
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
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 64, 320, 48) firstStr:@"询价需求填写" secondStr:@"流水号:1234567890" colorArr:@[[UIColor blackColor],AllLightGrayColor]];
    }
    return _topView;
}

-(AddContactView *)addContactView{
    if(!_addContactView){
        _addContactView = [[AddContactView alloc] init];
        _addContactView.delegate = self;
        //_addContactView.backgroundColor = [UIColor yellowColor];
        [_addContactView GetHeightWithBlock:^(double height) {
            if(height<=60){
                height = 60;
            }
            NSLog(@"%f",height);
            _addContactView.frame = CGRectMake(0, 0, 320, height);
            self.addContactViewHeight = height;
        } labelArr:self.laberStrArr];
    }
    return _addContactView;
}

-(AddCategoriesView *)addCategoriesView{
    if(!_addCategoriesView){
        _addCategoriesView = [[AddCategoriesView alloc] init];
        [_addCategoriesView GetHeightWithBlock:^(double height) {
            if(height<46){
                height = 46;
            }
            _addCategoriesView.frame = CGRectMake(0, 0, 320, height);
            self.addCategoriesViewHeight = height;
        } str:self.categoryStr];
    }
    return _addCategoriesView;
}

-(AddClassificationView *)addClassificationView{
    if(!_addClassificationView){
        _addClassificationView = [[AddClassificationView alloc] init];
        [_addClassificationView GetHeightWithBlock:^(double height) {
            if(height<46){
                height = 46;
            }
            _addClassificationView.frame = CGRectMake(0, 0, 320, height);
            self.addClassificationViewHeight = height;
        } str:self.classifcationStr];
    }
    return _addClassificationView;
}

-(AddMarkView *)addMarkView{
    if(!_addMarkView){
        _addMarkView = [[AddMarkView alloc] initWithFrame:CGRectMake(0, 0, 320, 260)];
        _addMarkView.delegate = self;
    }
    return _addMarkView;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 112, 320, kScreenHeight-112)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(void)addContent{
    SearchContactViewController *searchView = [[SearchContactViewController alloc] init];
    searchView.delegate =self;
    [self.navigationController pushViewController:searchView animated:YES];
}

-(void)closeContent:(NSInteger)index{
    [self.laberStrArr removeObjectAtIndex:index];
    [self.addContactView removeFromSuperview];
    self.addContactView = nil;
    [self.viewArr replaceObjectAtIndex:0 withObject:self.addContactView];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1){
        ChooseProductBigStage *categoryView = [[ChooseProductBigStage alloc] init];
        categoryView.delegate = self;
        [self.navigationController pushViewController:categoryView animated:YES];
    }else if (indexPath.row == 2){
        if(self.categoryStr !=nil){
            ChooseProductSmallStage *classificationView = [[ChooseProductSmallStage alloc] init];
            classificationView.delegate = self;
            [self.navigationController pushViewController:classificationView animated:YES];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请先选择产品大类" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.viewArr[indexPath.row]];
    cell.selectionStyle = NO;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return self.addContactViewHeight;
    }else if(indexPath.row == 1){
        return self.addCategoriesViewHeight;
    }else if(indexPath.row == 2){
        return self.addClassificationViewHeight;
    }else{
        return 260;
    }
}

-(void)beginTextView{
    self.view.transform = CGAffineTransformMakeTranslation(0, -200);
}

-(void)endTextView:(NSString *)str{
    self.view.transform = CGAffineTransformIdentity;
    self.remarkStr = str;
}

-(void)selectContact:(NSString *)str{
    [self.addContactView removeFromSuperview];
    self.addContactView = nil;
    [self.laberStrArr insertObject:str atIndex:0];
    [self.viewArr replaceObjectAtIndex:0 withObject:self.addContactView];
    [self.tableView reloadData];
}

-(void)chooseProductBigStage:(NSString *)str{
    self.categoryStr = str;
    [self.addCategoriesView removeFromSuperview];
    self.addCategoriesView = nil;
    [self.viewArr replaceObjectAtIndex:1 withObject:self.addCategoriesView];
    [self.tableView reloadData];
}

-(void)chooseProductSmallStage:(NSArray *)arr{
    NSMutableString *str = [[NSMutableString alloc] init];
    [arr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendString:[NSString stringWithFormat:@"%@、",obj]];
    }];
    if(str.length !=0){
        self.classifcationStr = [str substringWithRange:NSMakeRange(0,str.length-1)];
    }
    [self.addClassificationView removeFromSuperview];
    self.addClassificationView = nil;
    [self.viewArr replaceObjectAtIndex:2 withObject:self.addClassificationView];
    [self.tableView reloadData];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        [self addAnimation];
        [self.navigationController popViewControllerAnimated:NO];
    }else{
        AskPriceViewController *view = [[AskPriceViewController alloc] init];
        [self.navigationController pushViewController:view animated:YES];
    }
}
@end
