//
//  AdvancedSearchViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 14-8-28.
//
//

#import "AdvancedSearchViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "ProjectApi.h"
#import "SaveConditionsViewController.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "LoginSqlite.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
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
    [leftButton setFrame:CGRectMake(0, 0, 25, 22)];
    [leftButton setBackgroundImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
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
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.backgroundColor = RGBCOLOR(239, 237, 237);
    _tableView.separatorStyle = NO;
    [self.view addSubview:_tableView];
    
    dataDic = [[NSMutableDictionary alloc] init];
    [dataDic setValue:@"" forKey:@"keywords"];
    [dataDic setValue:@"" forKey:@"companyName"];
    [dataDic setValue:@"" forKey:@"landProvince"];
    [dataDic setValue:@"" forKey:@"landCity"];
    [dataDic setValue:@"" forKey:@"landDistrict"];
    [dataDic setValue:@"" forKey:@"projectStage"];
    [dataDic setValue:@"" forKey:@"projectCategory"];
    
    viewArr = [[NSMutableArray alloc] init];
    [self firstNetWork];
}

-(void)firstNetWork{
    [ProjectApi GetSearchConditionsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            showArr = posts;
            for(int i=0;i<posts.count;i++){
                conditionsView = [ConditionsView setFram:posts[i]];
                [viewArr addObject:conditionsView];
            }
            [_tableView reloadData];
        }else{
            [LoginAgain AddLoginView];
        }
    }userId:[LoginSqlite getdata:@"userId"] noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 64, 320, 568-64) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
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

-(void)leftBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    if(![dataDic[@"keywords"] isEqualToString:@""]){
        if([[LoginSqlite getdata:@"deviceToken"] isEqualToString:@""]){
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            loginVC.delegate = self;
            UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:loginVC];
            [self.view.window.rootViewController presentViewController:nv animated:YES completion:nil];
        }else{
            saveView = [[SaveConditionsViewController alloc] init];
            [saveView.view setFrame:CGRectMake(0, 0, 271, 173)];
            saveView.delegate = self;
            saveView.dataDic = dataDic;
            [self presentPopupViewController:saveView animationType:MJPopupViewAnimationFade flag:1];
        }
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请填写关键字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
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
    return 2+showArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return  300;
    }else if (indexPath.row == 1){
        return 44;
    }else{
        if(viewArr.count !=0){
            conditionsView = [viewArr objectAtIndex:indexPath.row-2];
            //NSLog(@"===>%f",conditionsView.frame.size.height);
            if(conditionsView.frame.size.height <44){
                return 44;
            }else{
                return conditionsView.frame.size.height;
            }
        }else{
            return 0;
        }
    }
}

//哪几行可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return NO;
    }else if(indexPath.row == 1){
        return NO;
    }
    return YES;
}

//继承该方法时,左右滑动会出现删除按钮(自定义按钮),点击按钮时的操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    NSLog(@"editingStyle ==> %d",editingStyle);
    if (editingStyle == UITableViewCellEditingStyleDelete){
        ConditionsModel *model = [showArr objectAtIndex:indexPath.row-2];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:model.a_id forKey:@"id"];
        [dic setValue:model.a_createBy forKey:@"DeletedBy"];
        [ProjectApi DeleteSearchConditionsWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                
            }else{
                [LoginAgain AddLoginView];
            }
        } dic:dic noNetWork:nil];
        [showArr removeObjectAtIndex:indexPath.row-2];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }else {
        //我们实现的是在所选行的位置插入一行，因此直接使用了参数indexPath
//        NSArray *insertIndexPaths = [NSArray arrayWithObjects:indexPath,nil];
//        //同样，将数据加到list中，用的row
//        [self.arr insertObject:@"新添加的行" atIndex:0];
//        [tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationRight];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        NSString *CellIdentifier = [NSString stringWithFormat:@"AdvancedSearchConditionsTableViewCell"];
        AdvancedSearchConditionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[AdvancedSearchConditionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.dic = dataDic;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1){
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 7, 100, 30)];
            label.text = @"个人搜索条件";
            label.font = [UIFont systemFontOfSize:12];
            [cell.contentView setBackgroundColor:RGBCOLOR(242, 242, 242)];
            [cell.contentView addSubview:label];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 11.5, 19, 21)];
            [imageView setImage:[GetImagePath getImagePath:@"项目－高级搜索－2_15a-19"]];
            [cell.contentView addSubview:imageView];
            
            UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 5)];
            [lineImage setImage:[GetImagePath getImagePath:@"项目－高级搜索－2_15a"]];
            [cell.contentView addSubview:lineImage];
            
            UIImageView *lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 41, 320, 3)];
            [lineImage2 setImage:[GetImagePath getImagePath:@"项目－高级搜索－2_22a"]];
            [cell.contentView addSubview:lineImage2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        NSString *stringcell = @"Cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell] ;
        }
        for(int i=0;i<cell.contentView.subviews.count;i++) {
            [((UIView*)[cell.contentView.subviews objectAtIndex:i]) removeFromSuperview];
        }
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(viewArr.count !=0){
            conditionsView = [viewArr objectAtIndex:indexPath.row-2];
            [cell.contentView addSubview:conditionsView];
            
        }
        return cell;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row>1){
        ConditionsModel *model = showArr[indexPath.row-2];
        ResultsTableViewController *resultsView = [[ResultsTableViewController alloc] init];
        resultsView.flag = 1;
        NSLog(@"%@",[self setDic:model.a_searchConditions][@"projectCategory"]);
        //return;
        resultsView.dic = [self setDic:model.a_searchConditions];
        [self.navigationController pushViewController:resultsView animated:YES];
    }
}

-(NSMutableDictionary *)setDic:(NSString *)str{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSArray *arr = [str componentsSeparatedByString:@","];
    [dic setValue:arr[0] forKey:@"keywords"];
    [dic setValue:arr[1] forKey:@"companyName"];
    [dic setValue:arr[2] forKey:@"landProvince"];
    [dic setValue:arr[3] forKey:@"landCity"];
    [dic setValue:arr[4] forKey:@"landDistrict"];
    [dic setValue:arr[5] forKey:@"projectStage"];
    [dic setValue:arr[6] forKey:@"projectCategory"];
    return dic;
}

-(void)multipleChose:(int)index{
    if(index == 0){
        [locationview removeFromSuperview];
        locationview = nil;
        multipleChoseView = [[MultipleChoiceViewController alloc] init];
        multipleChoseView.arr = [[NSMutableArray alloc] initWithObjects:@"土地信息阶段",@"主体设计阶段",@"主体施工阶段",@"装修阶段", nil];
        multipleChoseView.flag = 0;
        multipleChoseView.delegate = self;
        [multipleChoseView.view setFrame:CGRectMake(0, 0, 272, 270)];
        [self presentPopupViewController:multipleChoseView animationType:MJPopupViewAnimationFade flag:0];
    }else if(index == 1){
        [locationview removeFromSuperview];
        locationview = nil;
        multipleChoseView = [[MultipleChoiceViewController alloc] init];
        multipleChoseView.arr = [[NSMutableArray alloc] initWithObjects:@"工业",@"酒店及餐饮",@"商务办公",@"住宅/经济适用房",@"公用事业设施（教育、医疗、科研、基础建设等）",@"其他", nil];
        multipleChoseView.flag = 1;
        multipleChoseView.delegate = self;
        [multipleChoseView.view setFrame:CGRectMake(0, 0, 272, 370)];
        [self presentPopupViewController:multipleChoseView animationType:MJPopupViewAnimationFade flag:0];
    }else if (index == 2){
        if(locationview == nil){
            locationview = [[LocateView alloc] initWithTitle:CGRectMake(0, 0, 320, 260) title:nil delegate:self];
            [locationview showInView:self.view];
        }
    }
}

-(void)setTextFieldStr:(NSString *)str index:(int)index{
    if(index == 0){
        [dataDic setValue:str forKey:@"keywords"];
    }else{
        [dataDic setValue:str forKey:@"companyName"];
    }
    [_tableView reloadData];
}

-(void)choiceData:(NSMutableArray *)arr index:(int)index{
    NSMutableString *string = [[NSMutableString alloc] init];
    NSString *aStr = nil;
    for(int i=0;i<arr.count;i++){
        if(![[arr objectAtIndex:i] isEqualToString:@""]){
            [string appendString:[NSString stringWithFormat:@"%@+",[arr objectAtIndex:i]]];
        }
    }
    if(string.length !=0){
        aStr = [string substringToIndex:([string length]-1)];
        if(index == 0){
            [dataDic setObject:aStr forKey:@"projectStage"];
        }else{
            [dataDic setObject:aStr forKey:@"projectCategory"];
        }
    }
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [_tableView reloadData];
}


-(void)backMChoiceViewController{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)finshSave{
    if (![ConnectionAvailable isConnectionAvailable]) {
        [MBProgressHUD myShowHUDAddedTo:self.view animated:YES];
        return;
    }
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [viewArr removeAllObjects];
    [ProjectApi GetSearchConditionsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            showArr = posts;
            for(int i=0;i<posts.count;i++){
                conditionsView = [ConditionsView setFram:posts[i]];
                [viewArr addObject:conditionsView];
            }
            [_tableView reloadData];
        }else{
            [LoginAgain AddLoginView];
        }
    }userId:[LoginSqlite getdata:@"userId"] noNetWork:nil];
}

-(void)backView{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)startSearch{
    if(![dataDic[@"keywords"] isEqualToString:@""]){
        ResultsTableViewController *resultView = [[ResultsTableViewController alloc] init];
        resultView.dic = dataDic;
        resultView.flag = 1;
        [self.navigationController pushViewController:resultView animated:YES];
    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"请填写关键字" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    locationview = (LocateView *)actionSheet;
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
        [locationview removeFromSuperview];
        locationview = nil;
    }else {
        [dataDic setValue:locationview.proviceDictionary[@"provice"] forKey:@"landProvince"];
        [dataDic setValue:locationview.proviceDictionary[@"city"] forKey:@"landCity"];
        [dataDic setValue:locationview.proviceDictionary[@"county"] forKey:@"landDistrict"];
        [locationview removeFromSuperview];
        locationview = nil;
    }
    [_tableView reloadData];
}

-(void)loginComplete{
    
}

-(void)loginCompleteWithDelayBlock:(void (^)())block{

}
@end
