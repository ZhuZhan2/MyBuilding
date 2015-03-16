//
//  SearchViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-27.
//
//

#import "SearchViewController.h"
#import "RecordSqlite.h"
#import "RecordModel.h"
#define keyBoardHeight (kScreenHeight==480?376:464)
@interface SearchViewController ()

@end

@implementation SearchViewController

int startIndex;
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
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 50, 28.5)];
    [rightButton setTitle:@"清空" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.title = @"搜索";
    self.view.backgroundColor=RGBCOLOR(232, 232, 232);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,64, 320, 40)];
    [bgView setBackgroundColor:RGBCOLOR(222, 222, 222)];
    [self.view addSubview:bgView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,5, 320, 30)];
    _searchBar.delegate =self;
    _searchBar.placeholder = @"请输入搜索内容";
	_searchBar.tintColor = [UIColor grayColor];
	_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.backgroundImage = [self imageWithColor:[UIColor clearColor]];
    //_searchBar.searchBarStyle = UISearchBarStyleMinimal;
	_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_searchBar.keyboardType = UIKeyboardTypeDefault;
    // Get the instance of the UITextField of the search bar
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    // Change search bar text color
    searchField.textColor = RGBCOLOR(162, 162, 162);
    // Change the search bar placeholder text color
    [searchField setValue:RGBCOLOR(162, 162, 162) forKeyPath:@"_placeholderLabel.textColor"];
    [bgView addSubview:_searchBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, 320, 220)];
    _tableView.backgroundColor=RGBCOLOR(232, 232, 232);
    //[_tableView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    showArr = [RecordSqlite loadList];
    
    [_searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [_searchBar becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 鍵盤隐藏時
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    
}

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    //_searchBar.text=@"";
    [RecordSqlite delAll];
    [showArr removeAllObjects];
    [_tableView reloadData];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即為鍵盤尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    if(toolbarView == nil){
        toolbarView = [[toolBarView alloc] initWithFrame:CGRectMake(0, keyBoardHeight-kbSize.height+64, 320, 40)];
        toolbarView.delegate = self;
        [self.view addSubview:toolbarView];
    }else{
        [toolbarView setFrame:CGRectMake(0, keyBoardHeight-kbSize.height+64, 320, 40)];
    }
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //do something
    [toolbarView removeFromSuperview];
    toolbarView = nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return showArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *CellWithIdentifier = [NSString stringWithFormat:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    RecordModel *model = [showArr objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(15, 43, 290, 1)];
        view.backgroundColor=RGBCOLOR(202, 202, 202);
        [cell.contentView addSubview:view];
    }
    cell.imageView.image=[GetImagePath getImagePath:@"项目－搜索_09a"];
    cell.textLabel.text=model.a_name;
    cell.backgroundColor=RGBCOLOR(232, 232, 232);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordModel *model = [showArr objectAtIndex:indexPath.row];
    _searchBar.text = model.a_name;
    ResultsTableViewController *resultView = [[ResultsTableViewController alloc] init];
    resultView.searchStr = model.a_name;
    [self.navigationController pushViewController:resultView animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(![[_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *time = [dateFormatter stringFromDate:[NSDate date]];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:_searchBar.text forKey:@"name"];
        [dic setValue:time forKey:@"time"];
        [RecordSqlite InsertData:dic];
        
        ResultsTableViewController *resultView = [[ResultsTableViewController alloc] init];
        resultView.searchStr = _searchBar.text;
        resultView.flag = 0;
        [self.navigationController pushViewController:resultView animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请输入搜索内容" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        _searchBar.text = @"";
    }
}


-(void)gotoView:(NSInteger)index{
    if(index == 0){
        UnderstandViewController *understandVC = [[UnderstandViewController alloc] init];
        [self.navigationController pushViewController:understandVC animated:YES];
    }else if(index == 1){
        AdvancedSearchViewController *advancedSearchView = [[AdvancedSearchViewController alloc] init];
        [self.navigationController pushViewController:advancedSearchView animated:YES];
    }else if(index == 2){
        if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请先打开定位功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }else{
            BaiDuMapViewController *baiduMapView = [[BaiDuMapViewController alloc] init];
            [self.navigationController pushViewController:baiduMapView animated:YES];
        }
    }
}



-(void)dealloc{
    NSLog(@"dealloc");
}
@end
