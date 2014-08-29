//
//  AdvancedSearchViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-28.
//
//

#import "AdvancedSearchViewController.h"
#import "UIViewController+MJPopupViewController.h"
@interface AdvancedSearchViewController ()

@end

@implementation AdvancedSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //LeftButton设置属性
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    //RightButton设置属性
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 19.5)];
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"高级搜索";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 504)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    
    dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:@"" forKey:@"keywords"];
    [dataDic setValue:@"" forKey:@"landDistrict"];
    [dataDic setValue:@"" forKey:@"landProvince"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    NSLog(@"rightBtnClick");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return  355;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        NSString *CellIdentifier = [NSString stringWithFormat:@"AdvancedSearchConditionsTableViewCell"];
        AdvancedSearchConditionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[AdvancedSearchConditionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 7, 100, 30)];
        label.text = @"个人搜索条件";
        label.font = [UIFont systemFontOfSize:14];
        [cell.contentView setBackgroundColor:[UIColor grayColor]];
        [cell.contentView addSubview:label];
        return cell;
    }
    
    return nil;
}

-(void)multipleChose:(int)index{
    if(index == 0){
        MultipleChoiceViewController *multipleChoseView = [[MultipleChoiceViewController alloc] init];
        multipleChoseView.arr = [[NSMutableArray alloc] initWithObjects:@"工业",@"酒店及餐饮",@"商务办公",@"住宅/经济适用房",@"公用事业设施（教育、医疗、科研、基础建设等）",@"其他", nil];
        [multipleChoseView.view setFrame:CGRectMake(0, 0, 260, 310)];
        [self presentPopupViewController:multipleChoseView animationType:MJPopupViewAnimationFade];
    }else{
        MultipleChoiceViewController *multipleChoseView = [[MultipleChoiceViewController alloc] init];
        multipleChoseView.arr = [[NSMutableArray alloc] initWithObjects:@"土地信息阶段",@"主体设计阶段",@"主体施工阶段",@"装修阶段", nil];
        [multipleChoseView.view setFrame:CGRectMake(0, 0, 260, 310)];
        [self presentPopupViewController:multipleChoseView animationType:MJPopupViewAnimationFade];
    }
}
@end
