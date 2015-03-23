//
//  AskPriceDetailViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/21.
//
//

#import "AskPriceDetailViewController.h"
#import "CatoryTableViewCell.h"
#import "ClassificationView.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "RemarkViewController.h"
@interface AskPriceDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)ClassificationView *classificationView;
@property(nonatomic)int classificationViewHeight;
@property(nonatomic,strong)NSMutableArray *viewArr;
@end

@implementation AskPriceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.title=@"询价详情";
    
    self.viewArr = [[NSMutableArray alloc] initWithObjects:self.classificationView, nil];
    self.showArr = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate =self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = AllBackDeepGrayColor;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(ClassificationView *)classificationView{
    if(!_classificationView){
        _classificationView = [[ClassificationView alloc] init];
        _classificationView.isNeedCutLine = YES;
        [_classificationView GetHeightWithBlock:^(double height) {
            _classificationView.frame = CGRectMake(0, 0, 320, height);
            self.classificationViewHeight = height;
        } str:self.askPriceModel.a_productBigCategory name:@"产品分类"];
    }
    return _classificationView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 3+self.showArr.count+5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 70;
    }else if (indexPath.row == 1){
        return self.classificationViewHeight;
    }else if(indexPath.row == 2){
        return 60;
    }else{
        return 50;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 2){
        RemarkViewController *remarkView = [[RemarkViewController alloc] init];
        [self.navigationController pushViewController:remarkView animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        NSString *CellIdentifier = [NSString stringWithFormat:@"CatoryTableViewCell"];
        CatoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[CatoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = NO;
        cell.catoryStr = self.askPriceModel.a_productBigCategory;
        return cell;
    }else if(indexPath.row == 1){
        NSString *CellIdentifier = [NSString stringWithFormat:@"classificationCell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = NO;
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:self.viewArr[0]];
        return cell;
    }else if(indexPath.row == 2){
        NSString *CellIdentifier = [NSString stringWithFormat:@"remarkCell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = NO;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 17, 180, 16)];
        label.text = @"需求描述";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(287, 17.5, 7, 15)];
        arrowImageView.image = [GetImagePath getImagePath:@"交易_箭头"];
        [cell.contentView addSubview:arrowImageView];
        
        UIView *shadowView = [RKShadowView seperatorLineShadowViewWithHeight:10];
        shadowView.center = CGPointMake(160, 55);
        [cell.contentView addSubview:shadowView];
        return cell;
    }else{
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = NO;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 17, 180, 16)];
        label.text = @"名字";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(240, 17, 80, 16)];
        label2.text = @"名字";
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label2];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(287, 17.5, 7, 15)];
        arrowImageView.image = [GetImagePath getImagePath:@"交易_箭头"];
        [cell.contentView addSubview:arrowImageView];
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49, 320, 1)];
        lineImageView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lineImageView];
        return cell;
    }
}
@end