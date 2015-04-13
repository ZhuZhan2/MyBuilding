//
//  AddressBookViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/12.
//
//

#import "AddressBookViewController.h"
#import "AddressBookViewCell.h"
#import "SearchBarCell.h"
#import "AddressBookApi.h"
#import "AddressBookFriendViewController.h"
#import "AddressBookModel.h"
#import "AddressBookSearchBarCell.h"
#import "AddFriendViewController.h"
#import "AddressBookNickNameViewController.h"
#import "ChatViewController.h"
#import "PersonalDetailViewController.h"
#define seperatorLineColor RGBCOLOR(229, 229, 229)
@interface AddressBookViewController()<AddressBookViewCellDelegate,SWTableViewCellDelegate,AddressBookNickNameViewControllerDelegate>
@property(nonatomic,strong)NSMutableArray *groupArr;
@property(nonatomic,strong)NSMutableArray *searchDataArr;
@property(nonatomic,strong)UIButton *addFriendBtn;
@end

@implementation AddressBookViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstNetWork];
    [self initNavi];
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self initTableView];
    [self initaddFriendBtn];
}

-(void)initaddFriendBtn{
    CGFloat y=64+CGRectGetHeight(self.searchBar.frame);
    
    self.addFriendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addFriendBtn.frame = CGRectMake(0, y, kScreenWidth, 50);
    self.addFriendBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.addFriendBtn];
    
    UIView* seperatorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 49, kScreenWidth, 1)];
    seperatorLine.backgroundColor=seperatorLineColor;
    [self.addFriendBtn addSubview:seperatorLine];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    imageView.backgroundColor = [UIColor redColor];
    [self.addFriendBtn addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, 180, 30)];
    titleLabel.text = @"新的朋友";
    titleLabel.font = [UIFont systemFontOfSize:15];
    [self.addFriendBtn addSubview:titleLabel];
    
    [self.addFriendBtn addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat height=kScreenHeight-y;
    self.tableView.frame = CGRectMake(0, y+CGRectGetHeight(self.addFriendBtn.frame), 320, height);
}

-(void)addFriend{
    AddFriendViewController *view = [[AddFriendViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"更多"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    
    return rightUtilityButtons;
}

-(void)firstNetWork{
    [AddressBookApi GetAddressBookListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.groupArr = posts;
            [self.tableView reloadData];
        }
    }keywords:@"" noNetWork:nil];
}

-(void)initNavi{
    self.title=@"通讯录";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.needAnimaiton=YES;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groupArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AddressBookModel *model = self.groupArr[section];
    return [self sectionSelectedArrayContainsSection:section]?0:model.contactArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AddressBookModel *model = self.groupArr[section];
    BOOL isShow=![self sectionSelectedArrayContainsSection:section];
    CGFloat sectionHeight=30;
    UIButton* view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeight)];
    view.backgroundColor=[UIColor whiteColor];
    
    NSString* text=model.a_name;
    UIFont* textFont=[UIFont systemFontOfSize:14];
    CGFloat labelWidth=[text boundingRectWithSize:CGSizeMake(9999, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size.width;
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(11, 0, labelWidth, sectionHeight)];
    label.text=text;
    label.textColor=GrayColor;
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    CGFloat imageViewOrginX=CGRectGetWidth(label.frame)+CGRectGetMinX(label.frame)+5;
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewOrginX, 11, 8, 8)];
    imageView.image=[GetImagePath getImagePath:isShow?@"分组打开":@"分组关闭"];
    [view addSubview:imageView];
    
    CGFloat numberLabelWidth=100;
    UILabel* numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-13-numberLabelWidth, 0, numberLabelWidth, sectionHeight)];
    numberLabel.text=model.a_count;
    numberLabel.textAlignment=NSTextAlignmentRight;
    numberLabel.textColor=isShow?[UIColor redColor]:GrayColor;
    numberLabel.font=[UIFont systemFontOfSize:13];
    [view addSubview:numberLabel];
    
    UIView* seperatorLine0=[AddressBookViewCell fullSeperatorLine];
    seperatorLine0.center=CGPointMake(view.center.x, 0);
    [view addSubview:seperatorLine0];
    UIView* seperatorLine1=[AddressBookViewCell fullSeperatorLine];
    seperatorLine1.center=CGPointMake(view.center.x, CGRectGetHeight(view.frame));
    [view addSubview:seperatorLine1];
    
    [view addTarget:self action:@selector(sectionDidSelectWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    view.tag=section;
    return view;
}

-(void)sectionDidSelectWithBtn:(UIButton*)btn{
    NSInteger section=btn.tag;
    [self sectionViewClickedWithSection:section];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressBookViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        //cell=[[AddressBookViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" delegate:self];
        cell=[[AddressBookViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
    }
    cell.delegate = self;
    AddressBookModel *ABmodel = self.groupArr[indexPath.section];
    AddressBookContactModel *contactModel = ABmodel.contactArr[indexPath.row];
    AddressBookCellModel* model=[[AddressBookCellModel alloc]init];
    BOOL hasNickName=![contactModel.a_nickName isEqualToString:@""];
    model.mainLabelText=hasNickName?contactModel.a_nickName:contactModel.a_loginName;
    model.mainImageUrl = contactModel.a_avatarUrl;
    model.isHighlight=arc4random()%2;
    [cell setModel:model indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressBookModel *ABmodel = self.groupArr[indexPath.section];
    AddressBookContactModel *contactModel = ABmodel.contactArr[indexPath.row];
    ChatViewController *view = [[ChatViewController alloc] init];
    view.contactId = contactModel.a_contactId;
    view.type = @"01";
    [self.navigationController pushViewController:view animated:YES];
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    AddressBookModel *model = self.searchDataArr[section];
    return [self sectionSelectedArrayContainsSection:section]?0:model.contactArr.count;
}

-(NSInteger)searchBarNumberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressBookSearchBarCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AddressBookSearchBarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
        cell.delegate = self;
    }
    AddressBookModel *ABmodel = self.searchDataArr[indexPath.section];
    AddressBookContactModel *contactModel = ABmodel.contactArr[indexPath.row];
    AddressBookSearchBarCellModel* model=[[AddressBookSearchBarCellModel alloc]init];
    BOOL hasNickName=![contactModel.a_nickName isEqualToString:@""];
    model.mainLabelText=hasNickName?contactModel.a_nickName:contactModel.a_loginName;
    model.mainImageUrl = contactModel.a_avatarUrl;
    model.isHighlight=arc4random()%2;
    [cell setModel:model indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)searchBarTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self disappearAnimation:self.searchBar];
    AddressBookModel *ABmodel = self.searchDataArr[indexPath.section];
    AddressBookContactModel *contactModel = ABmodel.contactArr[indexPath.row];
    ChatViewController *view = [[ChatViewController alloc] init];
    view.contactId = contactModel.a_contactId;
    view.type = @"01";
    [self.navigationController pushViewController:view animated:YES];
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)searchBarTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AddressBookModel *model = self.searchDataArr[section];
    BOOL isShow=![self sectionSelectedArrayContainsSection:section];
    CGFloat sectionHeight=30;
    UIButton* view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeight)];
    view.backgroundColor=[UIColor whiteColor];
    
    NSString* text=model.a_name;
    UIFont* textFont=[UIFont systemFontOfSize:14];
    CGFloat labelWidth=[text boundingRectWithSize:CGSizeMake(9999, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textFont} context:nil].size.width;
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(11, 0, labelWidth, sectionHeight)];
    label.text=text;
    label.textColor=GrayColor;
    label.font=[UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    CGFloat imageViewOrginX=CGRectGetWidth(label.frame)+CGRectGetMinX(label.frame)+5;
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(imageViewOrginX, 11, 8, 8)];
    imageView.image=[GetImagePath getImagePath:isShow?@"分组打开":@"分组关闭"];
    [view addSubview:imageView];
    
    CGFloat numberLabelWidth=100;
    UILabel* numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-13-numberLabelWidth, 0, numberLabelWidth, sectionHeight)];
    numberLabel.text=model.a_count;
    numberLabel.textAlignment=NSTextAlignmentRight;
    numberLabel.textColor=isShow?[UIColor redColor]:GrayColor;
    numberLabel.font=[UIFont systemFontOfSize:13];
    [view addSubview:numberLabel];
    
    UIView* seperatorLine0=[AddressBookViewCell fullSeperatorLine];
    seperatorLine0.center=CGPointMake(view.center.x, 0);
    [view addSubview:seperatorLine0];
    UIView* seperatorLine1=[AddressBookViewCell fullSeperatorLine];
    seperatorLine1.center=CGPointMake(view.center.x, CGRectGetHeight(view.frame));
    [view addSubview:seperatorLine1];
    
    [view addTarget:self action:@selector(sectionDidSelectWithBtnSearch:) forControlEvents:UIControlEventTouchUpInside];
    view.tag=section;
    return view;
}

-(void)sectionDidSelectWithBtnSearch:(UIButton*)btn{
    NSInteger section=btn.tag;
    [self sectionViewClickedWithSection:section];
    [self.searchBarTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self ClickedSearchBarSearchButton:searchBar];
    [self searchData:searchBar.text];
}

-(void)searchData:(NSString *)keyWords{
    [AddressBookApi GetAddressBookListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            self.searchDataArr = posts;
            [self reloadSearchBarTableViewData];
        }
    }keywords:keyWords noNetWork:nil];
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSIndexPath* indexPath=[self.tableView indexPathForCell:cell];
            AddressBookModel *ABmodel = self.groupArr[indexPath.section];
            AddressBookContactModel *contactModel = ABmodel.contactArr[indexPath.row];
            
            AddressBookNickNameViewController *view = [[AddressBookNickNameViewController alloc] init];
            view.delegate=self;
            view.targetId=contactModel.a_contactId;
            [self.navigationController pushViewController:view animated:YES];
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            if([cell isKindOfClass:[AddressBookSearchBarCell class]]){
                NSIndexPath *cellIndexPath = [self.searchBarTableView indexPathForCell:cell];
                AddressBookModel *ABmodel = self.searchDataArr[cellIndexPath.section];
                AddressBookContactModel *contactModel = ABmodel.contactArr[cellIndexPath.row];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:contactModel.a_contactId forKey:@"userId"];
                [AddressBookApi DeleteContactsWithBlock:^(NSMutableArray *posts, NSError *error) {
                    if(!error){
                        [self firstNetWork];
                    }else{
                        [LoginAgain AddLoginView:NO];
                    }
                } dic:dic noNetWork:nil];
            }else{
                NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
                AddressBookModel *ABmodel = self.groupArr[cellIndexPath.section];
                AddressBookContactModel *contactModel = ABmodel.contactArr[cellIndexPath.row];
                NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                [dic setObject:contactModel.a_contactId forKey:@"userId"];
                [AddressBookApi DeleteContactsWithBlock:^(NSMutableArray *posts, NSError *error) {
                    if(!error){
                        [self firstNetWork];
                    }else{
                        [LoginAgain AddLoginView:NO];
                    }
                } dic:dic noNetWork:nil];
            };
            break;
        }
        default:
            break;
    }
}

-(void)addressBookNickNameViewControllerFinish{
    [AddressBookApi GetAddressBookListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.groupArr removeAllObjects];
            self.groupArr = posts;
            [self.tableView reloadData];
        }
    }keywords:@"" noNetWork:nil];
}

-(void)headClick:(NSIndexPath *)indexPath{
    AddressBookModel *ABmodel = self.groupArr[indexPath.section];
    AddressBookContactModel *contactModel = ABmodel.contactArr[indexPath.row];
    PersonalDetailViewController *view = [[PersonalDetailViewController alloc] init];
    view.contactId = contactModel.a_contactId;
    [self.navigationController pushViewController:view animated:YES];
}
@end
