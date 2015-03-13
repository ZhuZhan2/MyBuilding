//
//  AddFriendViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/9.
//
//

#import "AddFriendViewController.h"
#import "AddFriendCell.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
@interface AddFriendViewController ()

@end

@implementation AddFriendViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
}

-(void)initNavi{
    self.title=@"添加好友";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"清空"];
    self.needAnimaiton=YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

#define testContents @[@"开发部的都是好人，产品部设计部测试部都是坏人",@"范俊是帅哥",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发",@"高凌露是美女",@"老板是好人",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发",@"开发部的都是好人，产品部设计部测试部都是坏人",@"范俊是帅哥",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发",@"高凌露是美女",@"老板是好人",@"恭喜发财，红包拿来，深集发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发发"]
static BOOL testIsSelfs[12] = {1,1,0,0,1,0,1,1,0,0,1,0};
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString* content=testContents[indexPath.row];
//    return (arc4random()%100)+150;
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddFriendCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AddFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" needRightBtn:YES];
        [cell.rightBtn addTarget:self action:@selector(chooseApprove:) forControlEvents:UIControlEventTouchUpInside];
    }
    NSDictionary* dic=@{@"userName":@"用户名",@"userImage":@"",@"isFocused":arc4random()%2?@"1":@"0",@"department":@"部门",@"company":@"一分以前哦"};

    
    EmployeesModel* model=[[EmployeesModel alloc]init];
    [model setDict:dic];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setModel:model indexPathRow:indexPath.row needCompanyName:YES];
    return cell;
}

-(void)chooseApprove:(UIButton*)btn{
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)rightBtnClicked{
    NSLog(@"AddFriend清空");
}
@end
