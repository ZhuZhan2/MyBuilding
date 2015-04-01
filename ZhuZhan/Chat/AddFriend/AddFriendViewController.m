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
#import "AddressBookApi.h"
#import "ReceiveApplyFreindModel.h"
@interface AddFriendViewController ()
@property(nonatomic,strong)NSMutableArray* models;
@end

@implementation AddFriendViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTableView];
    [self firstNetWork];
}

-(void)initNavi{
    self.title=@"添加好友";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"清空"];
    self.needAnimaiton=YES;
}

-(void)firstNetWork{
    [AddressBookApi GetFriendRequestListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self.models addObjectsFromArray:posts];
            [self.tableView reloadData];
        }
    } pageIndex:0 noNetWork:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.models.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddFriendCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[AddFriendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell" needRightBtn:YES];
        [cell.rightBtn addTarget:self action:@selector(chooseApprove:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    ReceiveApplyFreindModel* model=self.models[indexPath.row];
    
    [cell setUserName:model.a_loginName time:model.a_createdTime userImageUrl:model.a_imageId isFinished:model.a_isFinished indexPathRow:indexPath.row];
    return cell;
}

-(void)chooseApprove:(UIButton*)btn{
    ReceiveApplyFreindModel* model=self.models[btn.tag];
    if (model.a_isFinished) return;
    
    NSMutableDictionary* dic=[@{
                              @"messageId":model.a_messageId
                                } mutableCopy];
    [AddressBookApi PostAgreeFriendWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"成功添加好友" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }
    } dic:dic noNetWork:nil];
}

-(void)rightBtnClicked{
    NSLog(@"AddFriend清空");
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
}
@end
