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
#import "MJRefresh.h"
#import "RecommendFriendViewController.h"
#import "AddressBookFriendViewController.h"
#import "PersonalDetailViewController.h"
@interface AddFriendViewController ()<AddFriendCellDelegate>
@property(nonatomic,strong)NSMutableArray* models;
@property(nonatomic)int startIndex;
@property(nonatomic,strong)UIButton *addressBookBtn;
@property(nonatomic,strong)UIButton *MyBuildingBtn;
@end

@implementation AddFriendViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.startIndex=0;
    [self initNavi];
    [self initTableView];
    //集成刷新控件
    [self setupRefresh];
    [self firstNetWork];
    
    [self initTopView];
}

-(void)initNavi{
    self.title=@"新的朋友";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"清空"];
}

-(void)initTopView{
    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 74, 320, 82)];
    imageView.image=[GetImagePath getImagePath:@"add_both_button"];
    [self.view addSubview:imageView];
    
    self.addressBookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addressBookBtn.frame = CGRectMake(0, 74, 160, 82);
    [self.addressBookBtn addTarget:self action:@selector(addressBookBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addressBookBtn];
    
    self.MyBuildingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.MyBuildingBtn.frame = CGRectMake(160, 74, 160, 82);
    [self.MyBuildingBtn addTarget:self action:@selector(MyBuildingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.MyBuildingBtn];
    
    self.tableView.frame = CGRectMake(0, 164, 320, kScreenHeight-164);
}

-(void)addressBookBtnAction{
    AddressBookFriendViewController *view = [[AddressBookFriendViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)MyBuildingBtnAction{
    RecommendFriendViewController *view = [[RecommendFriendViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)firstNetWork{
    [AddressBookApi GetFriendRequestListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.models = posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
    } pageIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

-(void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    self.startIndex = 0;
    [AddressBookApi GetFriendRequestListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self.models removeAllObjects];
            self.models = posts;
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
        [self.tableView headerEndRefreshing];
    } pageIndex:0 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
}

- (void)footerRereshing
{
    [AddressBookApi GetFriendRequestListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.startIndex++;
            [self.models addObjectsFromArray:posts];
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
                    [self firstNetWork];
                }];
            }
        }
        [self.tableView footerEndRefreshing];
    } pageIndex:self.startIndex+1 noNetWork:^{
        [ErrorView errorViewWithFrame:CGRectMake(0, 0, 320, kScreenHeight) superView:self.view reloadBlock:^{
            [self firstNetWork];
        }];
    }];
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
    cell.delegate = self;
    ReceiveApplyFreindModel* model=self.models[indexPath.row];
    
    [cell setUserName:model.a_loginName time:model.a_createdTime userImageUrl:model.a_imageId isFinished:model.a_isFinished indexPathRow:indexPath.row status:model.a_status];
    cell.selectionStyle = NO;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        ReceiveApplyFreindModel* model=self.models[indexPath.row];
        
        NSMutableDictionary* dic=[@{
                                    @"messageId":model.a_messageId
                                    } mutableCopy];
        [AddressBookApi DelSingleFriendRequestWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"删除成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil]show];
                [self.models removeObjectAtIndex:indexPath.row];
                NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
                [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }else{
                if([ErrorCode errorCode:error]){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
    }
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
            model.a_isFinished = YES;
            [self.models replaceObjectAtIndex:btn.tag withObject:model];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            if([ErrorCode errorCode:error] ==403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } dic:dic noNetWork:^{
        [ErrorCode alert];
    }];
}

-(void)rightBtnClicked{
    NSLog(@"AddFriend清空");
    [AddressBookApi DelFriendRequestListWithBlock:^(NSMutableArray *posts, NSError *error) {
        if(!error){
            [self.models removeAllObjects];
            [self.tableView reloadData];
        }else{
            if([ErrorCode errorCode:error] == 403){
                [LoginAgain AddLoginView:NO];
            }else{
                [ErrorCode alert];
            }
        }
    } noNetWork:^{
        [ErrorCode alert];
    }];
}

-(NSMutableArray *)models{
    if (!_models) {
        _models=[NSMutableArray array];
    }
    return _models;
}

-(void)headClick:(int)index{
    ReceiveApplyFreindModel* model=self.models[index];
    PersonalDetailViewController *view = [[PersonalDetailViewController alloc] init];
    view.contactId = model.a_createdUser;
    [self.navigationController pushViewController:view animated:YES];
}
@end
