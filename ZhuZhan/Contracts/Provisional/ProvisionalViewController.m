//
//  ProvisionalViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "ProvisionalViewController.h"
#import "LoginSqlite.h"
#import "StartManView.h"
#import "ReceiveView.h"
#import "MoneyView.h"
#import "ContractView.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "SearchContactViewController.h"
#import "ContractsApi.h"
#import "ConstractListController.h"
@interface ProvisionalViewController ()<UITableViewDataSource,UITableViewDelegate,MoneyViewDelegate,ContractViewDelegate,StartManViewDelegate,ReceiveViewDelegate,UIActionSheetDelegate,SearchContactViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *viewArr;
@property(nonatomic,strong)StartManView *startMainView;
@property(nonatomic,strong)ReceiveView *receiveView;
@property(nonatomic,strong)MoneyView *moneyView;
@property(nonatomic,strong)ContractView *contractView;

@property(nonatomic,strong)NSString *personaStr1;
@property(nonatomic,strong)NSString *personaStr2;
@property(nonatomic,strong)NSString *myCompanyName;
@property(nonatomic,strong)NSString *otherCompanyName;
@property(nonatomic,strong)NSString *personaName;
@property(nonatomic,strong)NSString *moneyStr;
@property(nonatomic,strong)NSString *contractStr;
@property(nonatomic,strong)NSString *personaId;

@property(nonatomic)BOOL isOpen;

@property(nonatomic,weak)UIViewController* targetPopVC;
@property (nonatomic)BOOL isModified;
@property (nonatomic, copy)NSString* modifiedId;
@end

@implementation ProvisionalViewController
-(id)initWithView:(ProvisionalModel *)model targetPopVC:(UIViewController*)targetPopVC{
    if(self = [super init]){
        self.personaStr1 = model.personaStr1;
        self.personaStr2 = model.personaStr2;
        self.myCompanyName = model.myCompanyName;
        self.otherCompanyName = model.otherCompanyName;
        self.personaName = model.personaName;
        self.moneyStr = model.moneyStr;
        self.contractStr = model.contractStr;
        self.modifiedId=model.modifiedId;
        self.targetPopVC=targetPopVC;
        self.isModified=YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.leftBtnIsBack = YES;
    self.needAnimaiton = !self.isModified;
    [self setRightBtnWithText:@"提交"];
    self.title = self.isModified?@"修改佣金合同条款":@"填写佣金合同条款";
    
    [self.view addSubview:self.tableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //恢复tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarRestore];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏tabBar
    AppDelegate* app=[AppDelegate instance];
    HomePageViewController* homeVC=(HomePageViewController*)app.window.rootViewController;
    [homeVC homePageTabBarHide];
}

-(void)rightBtnClicked{
    if (self.isModified) {
        if([self.contractStr isEqualToString:@""] || !self.contractStr){
            [self showAlertView:@"请填写合同条款"];
            return;
        }
        [self sendPostRequest];
        return;
    }
    
    if([self.personaStr1 isEqualToString:@""] || !self.personaStr1){
        [self showAlertView:@"请选择自己的角色"];
        return;
    }
    
    if([self.myCompanyName isEqualToString:@""] || !self.myCompanyName){
        [self showAlertView:@"请填写自己公司抬头"];
        return;
    }
    
    if([self.personaId isEqualToString:@""] || !self.personaId){
        [self showAlertView:@"请选择参与用户"];
        return;
    }
    
    if([self.personaStr2 isEqualToString:@""] || !self.personaStr1){
        [self showAlertView:@"请选择对方的角色"];
        return;
    }
    
    if([self.otherCompanyName isEqualToString:@""] || !self.otherCompanyName){
        [self showAlertView:@"请填写对方公司抬头"];
        return;
    }
    
    if([self.moneyStr isEqualToString:@""] || !self.moneyStr){
        [self showAlertView:@"请填写金额"];
        return;
    }
    
    if([self.contractStr isEqualToString:@""] || !self.contractStr){
        [self showAlertView:@"请填写合同条款"];
        return;
    }
    
    if(![self isPureFloat:self.moneyStr]){
        [self showAlertView:@"金额请填写数字"];
        return;
    }
    
    [self sendPostRequest];
}


- (BOOL)isPureFloat:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

-(void)showAlertView:(NSString *)msg{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)showAlertViewNeedDelegate:(NSString *)msg{
    [[[UIAlertView alloc]initWithTitle:@"提醒" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger index=self.navigationController.viewControllers.count;
    UIViewController* vc=self.navigationController.viewControllers[index-3];
    [self.navigationController popToViewController:vc animated:YES];
}

-(void)sendPostRequest{
    //创建
    if (!self.isModified) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[self.personaStr1 isEqualToString:@"供应商"]?@"1":@"2" forKey:@"createdByType"];
        [dic setObject:[self.personaStr2 isEqualToString:@"供应商"]?@"1":@"2" forKey:@"pecipientType"];
        [dic setObject:self.myCompanyName forKey:@"partyA"];
        [dic setObject:self.otherCompanyName forKey:@"partyB"];
        [dic setObject:self.moneyStr forKey:@"contractsMoney"];
        [dic setObject:self.contractStr forKey:@"contentMain"];
        [dic setObject:self.personaId forKey:@"recipientId"];
        [ContractsApi PostContractWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                ConstractListController *view = [[ConstractListController alloc] init];
                [self.navigationController pushViewController:view animated:YES];
            }
        } dic:dic noNetWork:nil];
    //修改
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:self.contractStr forKey:@"contentMain"];
        [dic setObject:self.modifiedId forKey:@"id"];
        [ContractsApi PostUpdateWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                [self showAlertViewNeedDelegate:@"操作成功"];
            }
        } dic:dic noNetWork:nil];
    }
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    if(object == self.otherView1.textView){
//        [self layoutAndAnimateTextView:object index:2];
//    }else if (object == self.otherView2.textView){
//        [self layoutAndAnimateTextView:object index:3];
//    }else{
//        [self layoutAndAnimateTextView:object index:4];
//    }
//}
//
//-(void)layoutAndAnimateTextView:(UITextView *)textView index:(int)index{
//    CGFloat maxHeight = [OtherView maxHeight];
//    CGFloat contentH = [self getTextViewContentH:textView];
//    OtherView *view = (OtherView *)[textView superview];
//    BOOL isShrinking = NO;
//    CGFloat changeInHeight = 0;
//    __block CGFloat previousTextViewContentHeight = 0;
//    if(index == 2){
//        previousTextViewContentHeight = self.previousTextViewContentHeight1;
//    }else if (index == 3){
//        previousTextViewContentHeight = self.previousTextViewContentHeight2;
//    }else{
//        previousTextViewContentHeight = self.previousTextViewContentHeight3;
//    }
//    isShrinking = contentH < previousTextViewContentHeight;
//    changeInHeight = contentH - previousTextViewContentHeight;
//    
//    if (!isShrinking && (previousTextViewContentHeight == maxHeight || textView.text.length == 0)) {
//        changeInHeight = 0;
//    }else {
//        changeInHeight = MIN(changeInHeight, maxHeight - previousTextViewContentHeight);
//    }
//    
//    if (changeInHeight != 0.0f) {
//        [UIView animateWithDuration:0.25f
//                         animations:^{
//                             if (isShrinking) {
//                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//                                     previousTextViewContentHeight = MIN(contentH, maxHeight);
//                                 }
//                                 // if shrinking the view, animate text view frame BEFORE input view frame
//                                 [view adjustTextViewHeightBy:changeInHeight];
//                             }
//                             
//                             CGRect otherViewFrame = view.frame;
//                             view.frame = CGRectMake(0,0,320,otherViewFrame.size.height + changeInHeight);
//                             if (!isShrinking) {
//                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
//                                     previousTextViewContentHeight = MIN(contentH, maxHeight);
//                                 }
//                                 // growing the view, animate the text view frame AFTER input view frame
//                                 [view adjustTextViewHeightBy:changeInHeight];
//                             }
//                         }
//                         completion:^(BOOL finished) {
//                         }];
//        
//        previousTextViewContentHeight = MIN(contentH, maxHeight);
//        if(index == 2){
//            self.previousTextViewContentHeight1 = previousTextViewContentHeight;
//        }else if (index == 3){
//            self.previousTextViewContentHeight2 = previousTextViewContentHeight;
//        }else{
//            self.previousTextViewContentHeight3 = previousTextViewContentHeight;
//        }
//        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
//        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//        [textView becomeFirstResponder];
//    }
//}
//
//- (CGFloat)getTextViewContentH:(UITextView *)textView {
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
//        return ceilf([textView sizeThatFits:textView.frame.size].height);
//    } else {
//        return textView.contentSize.height;
//    }
//}

-(UITableView *)tableView{
    if(!_tableView){
        //_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, kScreenHeight-64)];
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(StartManView *)startMainView{
    if(!_startMainView){
        _startMainView = [[StartManView alloc] initWithFrame:CGRectMake(0, 0, 320, 180) isModified:self.isModified];
        _startMainView.delegate = self;
        if(self.personaStr1){
            _startMainView.contactLabel.text = self.personaStr1;
        }
        
        if(self.myCompanyName){
            _startMainView.textField.text = self.myCompanyName;
        }
    }
    return _startMainView;
}

-(ReceiveView *)receiveView{
    if(!_receiveView){
        _receiveView = [[ReceiveView alloc] initWithFrame:CGRectMake(0, 0, 320, 180) isModified:self.isModified];
        _receiveView.delegate = self;
        if(self.personaName){
            _receiveView.personaLabel.text = self.personaName;
        }
        
        if(self.personaStr2){
            _receiveView.contactLabel.text = self.personaStr2;
        }
        
        if(self.otherCompanyName){
            _receiveView.textField.text = self.otherCompanyName;
        }
    }
    return _receiveView;
}

-(MoneyView *)moneyView{
    if(!_moneyView){
        _moneyView = [[MoneyView alloc] initWithFrame:CGRectMake(0, 0, 320, 48) isModified:self.isModified];
        _moneyView.delegate = self;
        if(self.moneyStr){
            _moneyView.textFied.text = self.moneyStr;
        }
    }
    return _moneyView;
}

-(ContractView *)contractView{
    if(!_contractView){
        _contractView = [[ContractView alloc] initWithFrame:CGRectMake(0, 0, 320, 290)];
        _contractView.delegate = self;
        if(self.contractStr){
            _contractView.textView.text = self.contractStr;
        }
    }
    return _contractView;
}

-(NSMutableArray *)viewArr{
    if(!_viewArr){
        _viewArr = [NSMutableArray array];
        [_viewArr addObject:self.startMainView];
        [_viewArr addObject:self.receiveView];
        [_viewArr addObject:self.moneyView];
        [_viewArr addObject:self.contractView];
    }
    return _viewArr;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.viewArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.selectionStyle = NO;
    [cell.contentView addSubview:self.viewArr[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0 ||indexPath.row==1){
        return 180;
    }else if (indexPath.row == 2){
        return 48;
    }else{
        return 290;
    }
}

-(void)reloadStartMainView{
    [self.startMainView removeFromSuperview];
    self.startMainView = nil;
    [self.viewArr replaceObjectAtIndex:0 withObject:self.startMainView];
    [self.tableView reloadData];
}

-(void)reloadReceiveView{
    [self.receiveView removeFromSuperview];
    self.receiveView = nil;
    [self.viewArr replaceObjectAtIndex:1 withObject:self.receiveView];
    [self.tableView reloadData];
}

-(void)reloadMoneyView{
    [self.moneyView removeFromSuperview];
    self.moneyView = nil;
    [self.viewArr replaceObjectAtIndex:2 withObject:self.moneyView];
    [self.tableView reloadData];
}

-(void)reloadContractView{
    [self.contractView removeFromSuperview];
    self.contractView = nil;
    [self.viewArr replaceObjectAtIndex:3 withObject:self.contractView];
    [self.tableView reloadData];
}

-(void)textFiedDidBegin:(UITextField *)textField{
    if(textField == self.startMainView.textField){
        NSLog(@"startMainView");
        self.isOpen = NO;
    }else if (textField == self.receiveView.textField){
        NSLog(@"receiveView");
        self.isOpen = YES;
    }else{
        NSLog(@"moneyView");
        self.isOpen = YES;
    }
}

-(void)textFiedDidEnd:(NSString *)str textField:(UITextField *)textField{
    if(textField == self.startMainView.textField){
        self.myCompanyName = str;
    }else if (textField == self.receiveView.textField){
        self.otherCompanyName = str;
    }else{
        self.moneyStr = str;
    }
}

-(void)beginTextView{
    self.isOpen = YES;
}

-(void)endTextView:(NSString *)str{
    NSLog(@"%@",str);
    self.contractStr = str;
}

-(void)showActionSheet:(int)index{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"销售方" otherButtonTitles:@"供应商", nil];
    actionSheet.tag = index;
    [actionSheet showInView:self.view];
}

-(void)showSearchView{
    SearchContactViewController *searchView = [[SearchContactViewController alloc] init];
    searchView.delegate =self;
    [self.navigationController pushViewController:searchView animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag == 0){
        if(buttonIndex == 0){
            self.personaStr1 = @"销售方";
            self.personaStr2 = @"供应商";
        }else if(buttonIndex == 1){
            self.personaStr1 = @"供应商";
            self.personaStr2 = @"销售方";
        }
        [self reloadStartMainView];
        [self reloadReceiveView];
    }else{
        if(buttonIndex == 0){
            self.personaStr2 = @"销售方";
            self.personaStr1 = @"供应商";
        }else if(buttonIndex == 1){
            self.personaStr2 = @"供应商";
            self.personaStr1 = @"销售方";
        }
        [self reloadStartMainView];
        [self reloadReceiveView];
    }
}

-(void)selectContact:(UserOrCompanyModel *)model{
    self.personaId = model.a_loginId;
    self.personaName = model.a_loginName;
    [self reloadReceiveView];
}

#pragma mark - 键盘处理
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    if(self.isOpen){
        CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat ty = - rect.size.height;
        [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]-0.01 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, ty);
        }];
    }
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

-(void)dealloc{
    
}
@end


@implementation ProvisionalModel

@end