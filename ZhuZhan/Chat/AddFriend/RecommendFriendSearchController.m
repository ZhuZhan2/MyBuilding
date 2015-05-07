//
//  RecommendFriendSearchController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/10.
//
//

#import "RecommendFriendSearchController.h"
#import "AddressBookApi.h"
#import "FriendModel.h"
#import "RecommendFriendCell.h"
#import "RKShadowView.h"
#import "MyTableView.h"
@interface RecommendFriendSearchController ()
@property (nonatomic)NSInteger startIndex;
@property (nonatomic, strong)NSMutableArray* models;
@end

@implementation RecommendFriendSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableViewHeader];
}

-(void)initTableViewHeader{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 31)];
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 31)];
    label.text=@"联系人";
    label.textColor=AllDeepGrayColor;
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UIView* seperatorLine=[RKShadowView seperatorLine];
    CGRect frame=seperatorLine.frame;
    frame.origin.y=CGRectGetHeight(view.frame)-CGRectGetHeight(frame);
    seperatorLine.frame=frame;
    [view addSubview:seperatorLine];
    
    self.tableView.tableHeaderView=view;
}

-(void)loadListWithKeyWords:(NSString*)keyWords{
    [AddressBookApi SearchUserWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.models = posts;
            if(self.models.count ==0){
                [MyTableView reloadDataWithTableView:self.tableView];
                [MyTableView noSearchData:self.tableView];
            }else{
                [MyTableView removeFootView:self.tableView];
                [self.tableView reloadData];
            }
        }else{
            if([ErrorCode errorCode:error]==403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } keywords:keyWords startIndex:0 noNetWork:^{
        [ErrorCode alert];
    }];
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

- (UIViewController *)nowViewController{
    if (!_nowViewController) {
        _nowViewController = self;
    }
    return _nowViewController;
}

- (UIView *)noDataView{
    return nil;
}
@end
