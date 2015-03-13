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
@interface AddressBookViewController()<AddressBookViewCellDelegate>
@end

@implementation AddressBookViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self setUpSearchBarWithNeedTableView:YES];
    [self initTableView];
}

-(void)firstNetWork{
    [AddressBookApi GetAddressBookListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.tableView reloadData];
        }
    } noNetWork:nil];
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
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self sectionSelectedArrayContainsSection:section]?0:6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BOOL isShow=![self sectionSelectedArrayContainsSection:section];
    CGFloat sectionHeight=30;
    UIButton* view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, sectionHeight)];
    view.backgroundColor=[UIColor whiteColor];
    
    NSString* text=@[@"家庭",@"单位同事",@"高中同学"][section];
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
    numberLabel.text=@"6";
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
        cell=[[AddressBookViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" delegate:self];
    }
    AddressBookCellModel* model=[[AddressBookCellModel alloc]init];
    model.mainLabelText=@"用户名显示";
    model.isHighlight=arc4random()%2;
    [cell setModel:model indexPath:indexPath];
    
    return cell;
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(UITableViewCell *)searchBarTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchBarCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[SearchBarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    SearchBarCellModel* model=[[SearchBarCellModel alloc]init];
    model.mainLabelText=@"用户名显示";
    
    [cell setModel:model];
    return cell;
}
@end
