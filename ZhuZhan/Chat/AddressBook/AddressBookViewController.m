//
//  AddressBookViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/9.
//
//

#import "AddressBookViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "AddressBookModel.h"
#import "AddressBookApi.h"
@interface AddressBookViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArr;//所有分组
@property(nonatomic,strong)NSMutableArray *selectedArr;//二级列表是否展开状态
@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0,5,25,22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    self.title = @"通讯录";
    
    [self initDataSource];
    [self initTableView];
    [self firstNetWork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)leftBtnClick{
    [self addAnimation];
    [self.navigationController popViewControllerAnimated:NO];
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

-(void)firstNetWork{
    [AddressBookApi GetAddressBookListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.titleArr addObjectsFromArray:posts];
            [self.tableView reloadData];
        }
    } noNetWork:nil];
}

-(void)addAnimation{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"rippleEffect";
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,kScreenHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

-(void)initDataSource{
    self.titleArr = [[NSMutableArray alloc] init];
    AddressBookModel *ABModel = [[AddressBookModel alloc] init];
    ABModel.a_id = @"111";
    ABModel.a_name = @"未分组";
    [self.titleArr addObject:ABModel];
    self.selectedArr = [[NSMutableArray alloc] init];
}

//返回多少分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArr.count;
}

//每一个表头下返回几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    
    if ([self.selectedArr containsObject:string]) {
        AddressBookModel *ABModel = self.titleArr[section];
        return ABModel.contactArr.count;
    }
    return 0;
}

//设置表头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

//Section Footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.2;
}

//设置view，将替代titleForHeaderInSection方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, tableView.frame.size.width-20, 30)];
    AddressBookModel *ABModel = self.titleArr[section];
    if(self.titleArr.count !=0){
        titleLabel.text = ABModel.a_name;
    }
    [view addSubview:titleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 12, 15, 15)];
    imageView.tag = 20000+section;
    
    //判断是不是选中状态
    NSString *string = [NSString stringWithFormat:@"%ld",(long)section];
    
    if ([self.selectedArr containsObject:string]) {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_down@2x.png"];
    }
    else
    {
        imageView.image = [UIImage imageNamed:@"buddy_header_arrow_right@2x.png"];
    }
    [view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 320, 40);
    button.tag = section;
    [button addTarget:self action:@selector(doButton:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, 320, 1)];
    lineImage.backgroundColor = [UIColor blackColor];
    lineImage.alpha = 0.2;
    [view addSubview:lineImage];
    
    return view;
}

-(void)doButton:(UIButton *)sender
{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    //数组selectedArr里面存的数据和表头想对应，方便以后做比较
    if ([self.selectedArr containsObject:string])
    {
        [self.selectedArr removeObject:string];
    }
    else
    {
        [self.selectedArr addObject:string];
    }
    
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddressBookCell";
    
    AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[AddressBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    AddressBookModel *model = self.titleArr[indexPath.section];
    cell.model = model.contactArr[indexPath.row];
    return cell;
}
@end
