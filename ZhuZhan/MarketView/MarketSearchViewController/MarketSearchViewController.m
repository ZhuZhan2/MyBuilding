//
//  MarketSearchViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/5/5.
//
//

#import "MarketSearchViewController.h"

@interface MarketSearchViewController ()
@property(nonatomic,strong)NSMutableArray* models;
@end

@implementation MarketSearchViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
//    
//    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeSentences;//控制大小写
//    self.searchBar.autocorrectionType = UITextAutocorrectionTypeYes;
//    self.searchBar.keyboardType = UIKeyboardTypeWebSearch;
//    
//    UITextField* textField = [self.searchBar valueForKeyPath:@"_searchField"];
//    UILabel* placeholderLabel = [textField valueForKeyPath:@"_placeholderLabel"];
//    
//    placeholderLabel.text = @"请搜索";
//    
//    
//    
    [self setSearchBarTableViewBackColor:AllBackDeepGrayColor];
    
    [self.searchBar becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"ConstractListControllerReloadDataNotification" object:nil];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [super searchBarSearchButtonClicked:searchBar];
}

-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}
-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.clipsToBounds=YES;
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%d",(int)indexPath.row];
    return cell;
}

-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"indexpath=%d",indexPath.row);
}

-(void)error{
    [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"请测试记下当前的合同各个状态" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self viewAppearOrDisappear:YES];
}

-(void)viewAppearOrDisappear:(BOOL)isAppear{
    self.navigationController.navigationBarHidden=isAppear;
    [[UIApplication sharedApplication] setStatusBarStyle:isAppear?UIStatusBarStyleDefault:UIStatusBarStyleLightContent];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self viewAppearOrDisappear:NO];
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
        for (int i=0;i<10;i++) {
            [_models addObject:@""];
        }
    }
    return _models;
}

-(void)getSearchBarBackBtn{
    UIView* button=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.searchBar.frame)+64, kScreenWidth, CGRectGetHeight(self.view.frame))];
    button.backgroundColor=[UIColor whiteColor];
    self.searchBarBackBtn=button;
    [self.view addSubview:self.searchBarBackBtn];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ConstractListControllerReloadDataNotification" object:nil];
}
@end
