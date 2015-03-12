//
//  ChooseContactsViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "ChooseContactsViewController.h"
#import "ChooseContactsViewCell.h"
#import "SearchBarCell.h"
@interface ChooseContactsViewController()<ChooseContactsViewCellDelegate>
@property(nonatomic,strong)NSMutableArray* array;
@end

@implementation ChooseContactsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array=[NSMutableArray array];
    [self initNavi];
    [self setUpSearchBarWithNeedTableView:YES];
    [self initTableView];
}

-(void)initTableView{
    [super initTableView];
}

-(void)initNavi{
    self.title=@"选择联系人";
    [self setLeftBtnWithText:@"取消"];
    [self setRightBtnWithText:@"确定"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array containsObject:[NSString stringWithFormat:@"%d",(int)section]]?0:6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BOOL isShow=![self.array containsObject:[NSString stringWithFormat:@"%d",(int)section]];
    UIButton* view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 25)];
    label.text=@[@"A",@"B",@"C"][section];
    [view addSubview:label];
    
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(40, 4, 16, 16)];
    imageView.image=[GetImagePath getImagePath:isShow?@"分组打开":@"分组关闭"];
    [view addSubview:imageView];
    
    UIView* seperatorLine=[ChooseContactsViewCell fullSeperatorLine];
    seperatorLine.center=CGPointMake(view.center.x, CGRectGetHeight(view.frame)-CGRectGetHeight(seperatorLine.frame)*0.5);
    [view addSubview:seperatorLine];
    
    [view addTarget:self action:@selector(sectionDidSelectWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    view.tag=section;
    return view;
}

-(void)sectionDidSelectWithBtn:(UIButton*)btn{
    NSString* sectionStr=[NSString stringWithFormat:@"%d",(int)btn.tag];
    if ([self.array containsObject:sectionStr]) {
        [self.array removeObject:sectionStr];
    }else{
        [self.array addObject:sectionStr];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:btn.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChooseContactsViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ChooseContactsViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" delegate:self];
    }
    ChooseContactsCellModel* model=[[ChooseContactsCellModel alloc]init];
    model.mainLabelText=@"用户名显示";
    model.isHighlight=NO;
    [cell setModel:model indexPath:indexPath];
    
    return cell;
}

-(void)chooseAssistBtn:(UIButton *)btn indexPath:(NSIndexPath *)indexPath{
   
}

-(NSInteger)searchBarTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)searchBarTableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
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
