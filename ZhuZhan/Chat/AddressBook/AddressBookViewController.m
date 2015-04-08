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
@interface AddressBookViewController()<AddressBookViewCellDelegate,SWTableViewCellDelegate>
@property(nonatomic,strong)NSMutableArray *groupArr;
@property(nonatomic,strong)NSMutableArray *searchDataArr;
@end

@implementation AddressBookViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstNetWork];
    [self initNavi];
    [self setUpSearchBarWithNeedTableView:YES isTableViewHeader:NO];
    [self initTableView];
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"More"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"Delete"];
    
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
    [self setRightBtnWithImage:[GetImagePath getImagePath:@"Rectangle-3-copy"]];
    self.needAnimaiton=YES;
}

-(void)rightBtnClicked{
    AddressBookFriendViewController* vc=[[AddressBookFriendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
        cell.delegate = self;
    }
    AddressBookModel *ABmodel = self.groupArr[indexPath.section];
    AddressBookContactModel *contactModel = ABmodel.contactArr[indexPath.row];
    AddressBookCellModel* model=[[AddressBookCellModel alloc]init];
    model.mainLabelText=contactModel.a_loginName;
    model.mainImageUrl = contactModel.a_avatarUrl;
    model.isHighlight=arc4random()%2;
    [cell setModel:model indexPath:indexPath];
    
    return cell;
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
    SearchBarCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[SearchBarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    AddressBookModel *ABmodel = self.searchDataArr[indexPath.section];
    AddressBookContactModel *contactModel = ABmodel.contactArr[indexPath.row];
    SearchBarCellModel* model=[[SearchBarCellModel alloc]init];
    model.mainLabelText=contactModel.a_loginName;
    model.mainImageUrl = contactModel.a_avatarUrl;
    model.isHighlight=arc4random()%2;
    [cell setModel:model];
    return cell;
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
@end
