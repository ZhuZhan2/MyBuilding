//
//  QuotesDetailViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/23.
//
//

#import "QuotesDetailViewController.h"
#import "CatoryTableViewCell.h"
#import "ClassificationView.h"
#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "AskPriceApi.h"
#import "ProvidePriceInfoController.h"
#import "DemandDetailProvidePriceController.h"
@interface QuotesDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DemandDetailProvidePriceDelegate,ProvidePriceInfoControllerDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *showArr;
@property(nonatomic,strong)UIView *classificationView;
@property(nonatomic,strong)UIView * remarkView;
@property(nonatomic)int classificationViewHeight;
@property(nonatomic)int remarkViewHeight;
@property(nonatomic,strong)NSMutableArray *viewArr;
@property(nonatomic,strong)NSString *isQuoted;
@property(nonatomic,strong)NSMutableArray *invitedUserArr;
@end

@implementation QuotesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(0,5,25,22)];
    [button setImage:[GetImagePath getImagePath:@"013"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.title=@"询价详情";
    
    [self loadList];
    
    self.viewArr = [[NSMutableArray alloc] init];
    [self.viewArr addObject:self.classificationView];
    [self.viewArr addObject:self.remarkView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)loadList{
    [AskPriceApi GetAskPriceDetailsWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.invitedUserArr = posts[0];
            self.isQuoted = posts[1];
            [self.tableView reloadData];
        }
    } tradeId:self.askPriceModel.a_id noNetWork:nil];
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

-(UIView *)classificationView{
    if(!_classificationView){
        ClassificationView *view = [[ClassificationView alloc] init];
        view.isNeedCutLine = YES;
        [view GetHeightWithBlock:^(double height) {
            _classificationView.frame = CGRectMake(0, 0, 320, height);
            self.classificationViewHeight = height;
        } str:self.askPriceModel.a_productCategory name:@"产品分类"];
        _classificationView = view;
    }
    return _classificationView;
}

-(UIView *)remarkView{
    if(!_remarkView){
        ClassificationView *view = [[ClassificationView alloc] init];
        view.isNeedCutLine = NO;
        [view GetHeightWithBlock:^(double height) {
            _classificationView.frame = CGRectMake(0, 0, 320, height);
            self.remarkViewHeight = height;
        } str:self.askPriceModel.a_remark name:@"询价说明"];
        _remarkView = view;
    }
    return _remarkView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 70;
    }else if (indexPath.row == 1){
        return self.classificationViewHeight;
    }else if(indexPath.row == 2){
        return self.remarkViewHeight;
    }else{
        return 55;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuotesModel *model = self.invitedUserArr[indexPath.row-3];
    if(indexPath.row == 3){
        if([self.isQuoted isEqualToString:@"0"]){
            ProvidePriceInfoController *view = [[ProvidePriceInfoController alloc] init];
            view.askPriceModel = self.askPriceModel;
            view.quotesModel = model;
            view.isFirstQuote=YES;
            view.delegate=self;
            [self.navigationController pushViewController:view animated:YES];
        }else{
            DemandDetailProvidePriceController *view = [[DemandDetailProvidePriceController alloc] init];
            view.askPriceModel = self.askPriceModel;
            view.quotesModel = model;
            view.delegate = self;
            [self.navigationController pushViewController:view animated:YES];
        }
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
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:self.viewArr[1]];
        return cell;
    }else{
        QuotesModel *model = self.invitedUserArr[indexPath.row-3];
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell"];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        cell.selectionStyle = NO;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(26, 13, 180, 20)];
        label.text = self.askPriceModel.a_requestName;
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(230, 15, 80, 16)];
        label2.text = model.a_status;
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label2];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(287, 17.5, 9, 15)];
        arrowImageView.image = [GetImagePath getImagePath:@"交易_箭头"];
        [cell.contentView addSubview:arrowImageView];
        
        UIView *shadowView = [RKShadowView seperatorLineShadowViewWithHeight:10];
        shadowView.center = CGPointMake(160, 50);
        [cell.contentView addSubview:shadowView];
        return cell;
    }
}

-(void)backAndLoad{
    [self loadList];
}
@end
