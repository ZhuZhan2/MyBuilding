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
    [leftButton setFrame:CGRectMake(0, 0, 29, 28.5)];
    [leftButton setBackgroundImage:[UIImage imageNamed:@"icon_04.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.title = @"搜索";
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0,64, 320, 40)];
    [bgView setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:bgView];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10,5, 300, 30)];
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
    searchField.textColor = [UIColor grayColor];
    // Change the search bar placeholder text color
    [searchField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [bgView addSubview:_searchBar];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, 320, 220)];
    //[_tableView setBackgroundColor:[UIColor colorWithRed:(239/255.0)  green:(237/255.0)  blue:(237/255.0)  alpha:1.0]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //_tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    showArr = [RecordSqlite loadList];
    
    [_searchBar becomeFirstResponder];
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
        NSLog(@"%f",_tableView.frame.size.height);
        toolbarView = [[toolBarView alloc] initWithFrame:CGRectMake(0, 464-kbSize.height+64, 320, 40)];
        toolbarView.delegate = self;
        [self.view addSubview:toolbarView];
    }else{
        [toolbarView setFrame:CGRectMake(0, 464-kbSize.height+64, 320, 40)];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 120, 30)];
    label.text = model.a_name;
    label.textColor = [UIColor blackColor];
    [cell.contentView addSubview:label];
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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:_searchBar.text forKey:@"name"];
    [dic setValue:time forKey:@"time"];
    [RecordSqlite InsertData:dic];
}


-(void)gotoView:(NSInteger)index{
    if(index == 0){
    
        ASRDialogview = [[ASRDialogViewController alloc] init];
        [self.navigationController pushViewController:ASRDialogview animated:YES];
    }else if(index == 1){
        AdvancedSearchViewController *advancedSearchView = [[AdvancedSearchViewController alloc] init];
        [self.navigationController pushViewController:advancedSearchView animated:YES];
    }else if(index == 2){
        BaiDuMapViewController *baiduMapView = [[BaiDuMapViewController alloc] init];
        [self.navigationController pushViewController:baiduMapView animated:YES];
    }
}



-(void)dealloc{
    NSLog(@"dealloc");
}
@end
