//
//  AddressBookFriendSearchController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/14.
//
//

#import "AddressBookFriendSearchController.h"
#import "AddressBookFriendCell.h"
#import "RKShadowView.h"
#import "AddressBookApi.h"
#import "ValidatePlatformContactModel.h"
#import "MyTableView.h"
@interface AddressBookFriendSearchController ()<AddressBookFriendCellDelegate>
@property (nonatomic, strong)NSMutableArray* models;
@end

@implementation AddressBookFriendSearchController

- (void)setUp {
    [super setUp];
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
    [self.models removeAllObjects];
    for (ValidatePlatformContactModel* model in self.sqliteModels) {
        if ([model.a_userPhoneName containsString:keyWords]) {
            [self.models addObject:model];
            continue;
        }
        if ([model.a_loginTel containsString:keyWords]) {
            [self.models addObject:model];
            continue;
        }
    }
    if(self.models.count ==0){
        [MyTableView reloadDataWithTableView:self.tableView];
        [MyTableView noSearchData:self.tableView];
    }else{
        [MyTableView removeFootView:self.tableView];
        [self.tableView reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressBookFriendCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AddressBookFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" delegate:self];
    }
    ValidatePlatformContactModel* dataModel=self.models[indexPath.row];
    AddressBookFriendCellModel* model=[[AddressBookFriendCellModel alloc]init];
    model.mainLabelText=dataModel.a_userPhoneName;
    model.assistStyle=dataModel.a_isWaiting?2:dataModel.a_isFriend;
    [cell setModel:model indexPath:indexPath];
    
    return cell;
}

-(void)chooseAssistBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath{
    ValidatePlatformContactModel* dataModel=self.models[indexPath.row];
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:dataModel.a_loginId forKey:@"userId"];
    [AddressBookApi PostSendFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            dataModel.a_isWaiting=YES;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } dic:dic noNetWork:^{
        [ErrorCode alert];
    }];
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
}
@end
