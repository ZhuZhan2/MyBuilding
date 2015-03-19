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
@interface AskPriceMainViewController ()<AddContactViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)TopView *topView;
@property(nonatomic,strong)NSMutableArray *laberStrArr;
@property(nonatomic,strong)AddContactView *addContactView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *viewArr;
@property(nonatomic)int addContactViewHeight;
@property(nonatomic,strong)AddCategoriesView *addCategoriesView;
@property(nonatomic)int addCategoriesViewHeight;
@property(nonatomic,strong)NSString *categoryStr;
@property(nonatomic)BOOL isSelect1;
@property(nonatomic,strong)AddClassificationView *addClassificationView;
@property(nonatomic)int addClassificationViewHeight;
@property(nonatomic,strong)NSString *classifcationStr;
@property(nonatomic)BOOL isSelect2;
@property(nonatomic,strong)AddMarkView *addMarkView;
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
    [self.view addSubview:self.tableView];
    self.viewArr = [[NSMutableArray alloc] init];
    [self.viewArr addObject:self.addContactView];
    [self.viewArr addObject:self.addCategoriesView];
    [self.viewArr addObject:self.addClassificationView];
    [self.viewArr addObject:self.addMarkView];
    self.isSelect1 = NO;
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
        //_addContactView.backgroundColor = [UIColor yellowColor];
        [_addContactView GetHeightWithBlock:^(double height) {
            if(height<55){
                height = 55;
            }
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
            if(height<55){
                height = 55;
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
            if(height<55){
                height = 55;
            }
            _addClassificationView.frame = CGRectMake(0, 0, 320, height);
            self.addClassificationViewHeight = height;
        } str:self.classifcationStr];
    }
    return _addClassificationView;
}

-(AddMarkView *)addMarkView{
    if(!_addMarkView){
        _addMarkView = [[AddMarkView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    }
    return _addMarkView;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 117, 320, kScreenHeight-114)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
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
    [self.viewArr replaceObjectAtIndex:0 withObject:self.addContactView];
    [self.tableView reloadData];
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
        [self.addCategoriesView removeFromSuperview];
        self.addCategoriesView = nil;
        if(self.isSelect1){
            self.categoryStr = nil;
            self.isSelect1 = NO;
        }else{
            self.categoryStr = @"分类";
            self.isSelect1 = YES;
        }
        [self.viewArr replaceObjectAtIndex:1 withObject:self.addCategoriesView];
        [self.tableView reloadData];
    }else if (indexPath.row == 2){
        [self.addClassificationView removeFromSuperview];
        self.addClassificationView = nil;
        if(self.isSelect2){
            self.classifcationStr = nil;
            self.isSelect2 = NO;
        }else{
            self.classifcationStr = @"分类奥德赛发送到发送到发送到发送到发送到发阿斯顿发送到发送到发分";
            self.isSelect2 = YES;
        }
        [self.viewArr replaceObjectAtIndex:2 withObject:self.addClassificationView];
        [self.tableView reloadData];
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
        return 320;
    }
}
@end
