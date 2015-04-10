//
//  RecommendFriendViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/4/9.
//
//

#import "RecommendFriendViewController.h"
#import "RecommendFriendCell.h"
#import "AddressBookApi.h"
#import "FriendModel.h"
#import "RecommendFriendSearchController.h"
#define seperatorLineColor RGBCOLOR(229, 229, 229)
@interface RecommendFriendViewController ()
@property(nonatomic,strong)NSMutableArray* models;
@property(nonatomic)int startIndex;
@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)RecommendFriendSearchController* searchBarTableViewController;
@end

@implementation RecommendFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.startIndex = 0;
    [self initNavi];
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self initTableView];
    [self firstNetWork];
    [self initTopView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTopView{
    CGFloat y=64+CGRectGetHeight(self.searchBar.frame);
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, y, 320, 40)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    UIView* seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 39, kScreenWidth, 1)];
    seperatorLine.backgroundColor=seperatorLineColor;
    [self.topView addSubview:seperatorLine];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 180, 30)];
    label.text = @"推荐用户";
    label.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:label];
    
    CGFloat height=kScreenHeight-y;
    self.tableView.frame = CGRectMake(0, y+CGRectGetHeight(self.topView.frame), 320, height);
}

-(void)initNavi{
    self.title=@"添加好友";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(void)firstNetWork{
    [AddressBookApi GetUserRecommendInfoWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.models = posts;
            [self.tableView reloadData];
        }
    } startIndex:0 noNetWork:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 57;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendFriendCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[RecommendFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    FriendModel *model = self.models[indexPath.row];
    cell.model = model;
    cell.selectionStyle = NO;
    
    return cell;
}

-(void)setUpSearchBarTableView{
    self.searchBarTableViewController=[[RecommendFriendSearchController alloc]initWithTableViewBounds:CGRectMake(0, 0, kScreenWidth, kScreenHeight-CGRectGetMinY(self.searchBar.frame))];
    self.searchBarTableViewController.delegate=self;
}
@end
