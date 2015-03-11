//
//  ChooseContactsViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "ChooseContactsViewController.h"
#import "ChooseContactsViewCell.h"
@interface ChooseContactsViewController()<ChooseContactsViewCellDelegate>
@property(nonatomic,strong)NSMutableArray* array;
@end

@implementation ChooseContactsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.array=[NSMutableArray array];
    [self initNavi];
    [self initTableView];
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
    return [self.array containsObject:[NSString stringWithFormat:@"%ld",(long)section]]?0:6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton* view=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    view.backgroundColor=RGBCOLOR(222, 222, 222);
    
    UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 100, 25)];
    label.text=@[@"A",@"B",@"C"][section];
    [view addSubview:label];
    
    [view addTarget:self action:@selector(sectionDidSelectWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    view.tag=section;
    return view;
}

-(void)sectionDidSelectWithBtn:(UIButton*)btn{
    NSString* sectionStr=[NSString stringWithFormat:@"%ld",(long)btn.tag];
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
    NSLog(@"%d,%d",indexPath.section,indexPath.row);
}
@end
