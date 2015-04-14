//
//  AddGroupMemberController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/11.
//
//

#import "AddGroupMemberController.h"
#import "AddImageView.h"
#import "ChooseContactsViewController.h"
#import "ChatMessageApi.h"
#import "ChatGroupMemberModel.h"
#import "LoginSqlite.h"
@interface AddGroupMemberController ()<AddImageViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)AddImageView* addImageView;
@property(nonatomic,strong)UIView* secondView;
@property(nonatomic,strong)NSString *createdUserId;
@property(nonatomic,strong)UIButton* btn;
@property (nonatomic, strong)NSArray* groupMemberModels;
@end

#define backColor RGBCOLOR(240, 239, 245)

@implementation AddGroupMemberController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self firstNetWork];
    [self initNavi];
    [self initTableView];
    self.tableView.backgroundColor=backColor;
}

-(void)firstNetWork{
    [ChatMessageApi GetInfoWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.groupMemberModels=posts[0];
            self.addImageView=nil;
            self.createdUserId = posts[1];
            if([[LoginSqlite getdata:@"userId"] isEqualToString:posts[1]]){
                [self.btn setBackgroundImage:[GetImagePath getImagePath:@"关--闭灰"] forState:UIControlStateNormal];
            }else{
                [self.btn setBackgroundImage:[GetImagePath getImagePath:@"退出本群"] forState:UIControlStateNormal];
            }
            [self.tableView reloadData];
        }
    } groupId:self.contactId noNetWork:nil];
}

-(void)initNavi{
    self.title=@"群成员(等待接口完成再修改)";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.view.backgroundColor=backColor;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height=0;
    switch (indexPath.row) {
        case 0:
            height=CGRectGetHeight(self.addImageView.frame);
            break;
        case 1:
            height=CGRectGetHeight(self.secondView.frame);
            break;
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (indexPath.row==0) {
        [cell.contentView addSubview:self.addImageView];
    }else{
        [cell.contentView addSubview:self.secondView];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(AddImageView *)addImageView{
    if (!_addImageView) {
        NSMutableArray* array=[NSMutableArray array];
        for (int i=0; i<self.groupMemberModels.count; i++) {
            ChatGroupMemberModel* dataModel=self.groupMemberModels[i];
            
            AddImageViewModel* model=[[AddImageViewModel alloc]init];
            model.name=[dataModel.a_nickName isEqualToString:@""]?dataModel.a_loginName:dataModel.a_nickName;
            model.imageUrl=dataModel.a_loginImagesId;
            [array addObject:model];
        }
        _addImageView=[AddImageView addImageViewWithModels:array];
        _addImageView.delegate=self;
    }
    return _addImageView;
}

-(UIView *)secondView{
    if (!_secondView) {
        _secondView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 175)];
        _secondView.backgroundColor=backColor;
        [self setUpSecondView];
    }
    return _secondView;
}

-(void)setUpSecondView{
    NSLog(@"%@",self.createdUserId);
    self.btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 294, 42)];
    //[self.btn setBackgroundImage:[GetImagePath getImagePath:@"退出本群"] forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(exitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    self.btn.center=CGPointMake(kScreenWidth*0.5, 35);
    [_secondView addSubview:self.btn];
}

-(UIView*)seperatorLine{
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    view.backgroundColor=RGBCOLOR(215, 215, 215);
    return view;
}

//-(void)changeNameBtnClicked{
//    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"群聊名称" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认",@"取消", nil];
//    alertView.alertViewStyle=UIAlertViewStylePlainTextInput;
//    [alertView textFieldAtIndex:0].clearButtonMode=UITextFieldViewModeAlways;
//    [alertView show];
//    //    UIView* view=[AlertTextFieldView alertTextFieldViewWithName:@"群聊名称" sureBtnTitle:@"确认" cancelBtnTitle:@"取消" originY:110 delegate:self];
//    //    [self.navigationController.view addSubview:view];
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",(int)buttonIndex);
    if (buttonIndex==0) {
        [self quitGroup];
    }
//    if (buttonIndex==0) {
//        UITextField* field=[alertView textFieldAtIndex:0];
//        NSLog(@"field==%@",field.text);
//    }
}

-(void)quitGroup{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setObject:self.contactId forKey:@"groupId"];
    [ChatMessageApi DismissWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            NSInteger index=self.navigationController.viewControllers.count-3;
            [self.navigationController popToViewController:self.navigationController.viewControllers[index] animated:YES];
        }
    } dic:dic noNetWork:nil];
}

-(void)exitBtnClicked{
    UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"退出本群" message:@"退出后，将不再接受此群聊消息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认",@"取消",nil];
    [alertView show];
}

-(void)sureBtnClickedWithContent:(NSString *)content{
    NSLog(@"content=%@",content);
}

-(void)addImageBtnClicked{
    ChooseContactsViewController* vc=[[ChooseContactsViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
