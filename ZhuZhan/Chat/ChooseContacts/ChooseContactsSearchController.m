//
//  ChooseContactsSearchController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/13.
//
//

#import "ChooseContactsSearchController.h"
#import "RKShadowView.h"
#import "AddressBookApi.h"
#import "ChooseContactsViewCell.h"
#import "AddressBookModel.h"
@interface ChooseContactsSearchController ()<ChooseContactsViewCellDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray* models;
@end

@implementation ChooseContactsSearchController

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
    [AddressBookApi GetAddressBookListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.models removeAllObjects];
            [posts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                AddressBookModel *ABmodel = obj;
                [self.models addObjectsFromArray:ABmodel.contactArr];
            }];
            [self.tableView reloadData];
        }
    }keywords:keyWords noNetWork:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseContactsViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ChooseContactsViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" delegate:self];
    }
    ChooseContactsCellModel* model=[[ChooseContactsCellModel alloc]init];

    AddressBookContactModel *contactModel = self.models[indexPath.row];
    BOOL hasNickName=![contactModel.a_nickName isEqualToString:@""];
    model.mainLabelText=hasNickName?contactModel.a_nickName:contactModel.a_loginName;
    model.mainImageUrl = contactModel.a_avatarUrl;
    model.isHighlight=[self.selectedUserIds containsObject:contactModel.a_contactId];
    [cell setModel:model indexPath:indexPath];
    
    return cell;
}

-(void)chooseAssistBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath{
    AddressBookContactModel *contactModel = self.models[indexPath.row];
    NSString* userId=contactModel.a_contactId;
    BOOL hasUserId=[self.selectedUserIds containsObject:userId];
    if (hasUserId) {
        [self.selectedUserIds removeObject:userId];
    }else{
        [self.selectedUserIds addObject:userId];
    }
    [self.tableView reloadData];
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
}
@end