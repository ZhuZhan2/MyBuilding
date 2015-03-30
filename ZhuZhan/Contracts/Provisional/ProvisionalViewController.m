//
//  ProvisionalViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/30.
//
//

#import "ProvisionalViewController.h"
#import "StartManView.h"
#import "LoginSqlite.h"
#import "ReceiveView.h"
#import "OtherView.h"
#import "MoneyView.h"
#import "ContractView.h"
@interface ProvisionalViewController ()<UITableViewDataSource,UITableViewDelegate,OtherViewDelegate,MoneyViewDelegate,ContractViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *viewArr;
@property(nonatomic,strong)StartManView *startMainView;
@property(nonatomic)float startMainViewHeight;
@property(nonatomic,strong)ReceiveView *receiveView;
@property(nonatomic)float receiveViewHeight;
@property(nonatomic,strong)NSString *receiveStr;
@property(nonatomic,strong)OtherView *otherView1;
@property(nonatomic)float otherViewHeight1;
@property(nonatomic,strong)OtherView *otherView2;
@property(nonatomic)float otherViewHeight2;
@property(nonatomic,strong)OtherView *otherView3;
@property(nonatomic)float otherViewHeight3;
//记录旧的textView contentSize Heigth
@property(nonatomic)float previousTextViewContentHeight1;
@property(nonatomic)float previousTextViewContentHeight2;
@property(nonatomic)float previousTextViewContentHeight3;

@property(nonatomic,strong)MoneyView *moneyView;
@property(nonatomic,strong)ContractView *contractView;
@property(nonatomic,strong)UIButton *submitBtn;
@end

@implementation ProvisionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    [self setRightBtnWithText:@"取消"];
    self.title = @"填写临时佣金合同条款";
    // Do any additional setup after loading the view.
    //self.receiveStr=@"阿士大夫撒发生地方撒旦法师打发士大夫阿士大夫撒发生地方撒旦法师打发士大夫阿士大夫撒发生地方撒旦法师打发士大夫";
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
    
    [self.otherView1.textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.otherView2.textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.otherView3.textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)rightBtnClicked{
    self.leftBtnIsBack = YES;
    self.needAnimaiton = YES;
    [self leftBtnClicked];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if(object == self.otherView1.textView){
        [self layoutAndAnimateTextView:object index:2];
    }else if (object == self.otherView2.textView){
        [self layoutAndAnimateTextView:object index:3];
    }else{
        [self layoutAndAnimateTextView:object index:4];
    }
}

-(void)textFiedDidBegin{
    self.view.transform = CGAffineTransformMakeTranslation(0, -(self.startMainViewHeight+self.receiveViewHeight+self.previousTextViewContentHeight1+self.otherViewHeight1-30+self.previousTextViewContentHeight2+self.otherViewHeight2-30+self.previousTextViewContentHeight3+self.otherViewHeight3-30));
}

-(void)textFiedDidEnd:(NSString *)str{
    self.view.transform = CGAffineTransformIdentity;
}

-(void)beginTextView{
    self.view.transform = CGAffineTransformMakeTranslation(0, -(self.startMainViewHeight+self.receiveViewHeight+self.previousTextViewContentHeight1+self.otherViewHeight1-30+self.previousTextViewContentHeight2+self.otherViewHeight2-30+self.previousTextViewContentHeight3+self.otherViewHeight3-30+80));
}

-(void)endTextView:(NSString *)str{
    self.view.transform = CGAffineTransformIdentity;
}

-(void)textViewDidBeginEditing:(MessageTextView *)textView{
    if (!self.previousTextViewContentHeight1){
        self.previousTextViewContentHeight1 = [self getTextViewContentH:textView];
    }
    if(!self.previousTextViewContentHeight2){
        self.previousTextViewContentHeight2 = [self getTextViewContentH:textView];
    }
    if(!self.previousTextViewContentHeight3){
        self.previousTextViewContentHeight3 = [self getTextViewContentH:textView];
    }
    
    if(textView == self.otherView1.textView){
        self.view.transform = CGAffineTransformMakeTranslation(0, -(self.startMainViewHeight+self.receiveViewHeight));
    }else if (textView == self.otherView2.textView){
        self.view.transform = CGAffineTransformMakeTranslation(0, -(self.startMainViewHeight+self.receiveViewHeight+self.previousTextViewContentHeight1+self.otherViewHeight1-30));
    }else{
        self.view.transform = CGAffineTransformMakeTranslation(0, -(self.startMainViewHeight+self.receiveViewHeight+self.previousTextViewContentHeight1+self.otherViewHeight1-30+self.previousTextViewContentHeight2+self.otherViewHeight2-30));
    }
}

-(void)textViewDidEndEditing:(MessageTextView *)textView{
    self.view.transform = CGAffineTransformIdentity;
}

-(void)layoutAndAnimateTextView:(UITextView *)textView index:(int)index{
    CGFloat maxHeight = [OtherView maxHeight];
    CGFloat contentH = [self getTextViewContentH:textView];
    OtherView *view = (OtherView *)[textView superview];
    BOOL isShrinking = NO;
    CGFloat changeInHeight = 0;
    __block CGFloat previousTextViewContentHeight = 0;
    if(index == 2){
        previousTextViewContentHeight = self.previousTextViewContentHeight1;
    }else if (index == 3){
        previousTextViewContentHeight = self.previousTextViewContentHeight2;
    }else{
        previousTextViewContentHeight = self.previousTextViewContentHeight3;
    }
    isShrinking = contentH < previousTextViewContentHeight;
    changeInHeight = contentH - previousTextViewContentHeight;
    
    if (!isShrinking && (previousTextViewContentHeight == maxHeight || textView.text.length == 0)) {
        changeInHeight = 0;
    }else {
        changeInHeight = MIN(changeInHeight, maxHeight - previousTextViewContentHeight);
    }
    
    if (changeInHeight != 0.0f) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             if (isShrinking) {
                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                                     previousTextViewContentHeight = MIN(contentH, maxHeight);
                                 }
                                 // if shrinking the view, animate text view frame BEFORE input view frame
                                 [view adjustTextViewHeightBy:changeInHeight];
                             }
                             
                             CGRect otherViewFrame = view.frame;
                             view.frame = CGRectMake(0,0,320,otherViewFrame.size.height + changeInHeight);
                             if (!isShrinking) {
                                 if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
                                     previousTextViewContentHeight = MIN(contentH, maxHeight);
                                 }
                                 // growing the view, animate the text view frame AFTER input view frame
                                 [view adjustTextViewHeightBy:changeInHeight];
                             }
                         }
                         completion:^(BOOL finished) {
                         }];
        
        previousTextViewContentHeight = MIN(contentH, maxHeight);
        if(index == 2){
            self.previousTextViewContentHeight1 = previousTextViewContentHeight;
        }else if (index == 3){
            self.previousTextViewContentHeight2 = previousTextViewContentHeight;
        }else{
            self.previousTextViewContentHeight3 = previousTextViewContentHeight;
        }
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        [textView becomeFirstResponder];
    }
}

- (CGFloat)getTextViewContentH:(UITextView *)textView {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        return ceilf([textView sizeThatFits:textView.frame.size].height);
    } else {
        return textView.contentSize.height;
    }
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 132, 320, kScreenHeight-192)];
        //_tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(StartManView *)startMainView{
    if(!_startMainView){
        _startMainView = [[StartManView alloc] init];
        [_startMainView GetHeightWithBlock:^(double height) {
            if(height<60){
                height = 60;
            }
            self.startMainViewHeight = height;
            _startMainView.frame = CGRectMake(0, 0, 320, height);
        } str:[LoginSqlite getdata:@"userName"]];
    }
    return _startMainView;
}

-(ReceiveView *)receiveView{
    if(!_receiveView){
        _receiveView = [[ReceiveView alloc] init];
        [_receiveView GetHeightWithBlock:^(double height) {
            if(height<70){
                height = 70;
            }
            self.receiveViewHeight = height;
            _receiveView.frame = CGRectMake(0, 0, 320, height);
        } str:self.receiveStr];
    }
    return _receiveView;
}


-(OtherView *)otherView1{
    if(!_otherView1){
        _otherView1 = [[OtherView alloc] init];
        _otherView1.delegate = self;
        [_otherView1 GetHeightWithBlock:^(double height) {
            if(height<60){
                height = 60;
            }
            self.otherViewHeight1 = height;
            _otherView1.frame = CGRectMake(0, 0, 320, height);
        } titleStr:@"甲方"];
    }
    return _otherView1;
}

-(OtherView *)otherView2{
    if(!_otherView2){
        _otherView2 = [[OtherView alloc] init];
        _otherView2.delegate = self;
        [_otherView2 GetHeightWithBlock:^(double height) {
            if(height<60){
                height = 60;
            }
            self.otherViewHeight2 = height;
            _otherView2.frame = CGRectMake(0, 0, 320, height);
        } titleStr:@"乙方"];
    }
    return _otherView2;
}

-(OtherView *)otherView3{
    if(!_otherView3){
        _otherView3 = [[OtherView alloc] init];
        _otherView3.delegate = self;
        [_otherView3 GetHeightWithBlock:^(double height) {
            if(height<60){
                height = 60;
            }
            self.otherViewHeight3 = height;
            _otherView3.frame = CGRectMake(0, 0, 320, height);
        } titleStr:@"开票公司抬头"];
    }
    return _otherView3;
}

-(MoneyView *)moneyView{
    if(!_moneyView){
        _moneyView = [[MoneyView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
        _moneyView.delegate = self;
    }
    return _moneyView;
}

-(ContractView *)contractView{
    if(!_contractView){
        _contractView = [[ContractView alloc] initWithFrame:CGRectMake(0, 0, 320, 252)];
    }
    return _contractView;
}

-(NSMutableArray *)viewArr{
    if(!_viewArr){
        _viewArr = [NSMutableArray array];
        [_viewArr addObject:self.startMainView];
        [_viewArr addObject:self.receiveView];
        [_viewArr addObject:self.otherView1];
        [_viewArr addObject:self.otherView2];
        [_viewArr addObject:self.otherView3];
        [_viewArr addObject:self.moneyView];
        [_viewArr addObject:self.contractView];
    }
    return _viewArr;
}

-(UIButton *)submitBtn{
    if(!_submitBtn){
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame = CGRectMake(13, kScreenHeight-48, 294, 38);
        [_submitBtn setImage:[GetImagePath getImagePath:@"submit"] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
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
    if(indexPath.row == 0){
        return self.startMainViewHeight;
    }else if(indexPath.row == 1){
        return self.receiveViewHeight;
    }else if(indexPath.row == 2){
        if(!self.previousTextViewContentHeight1){
            return self.otherViewHeight1;
        }else{
            return self.previousTextViewContentHeight1+self.otherViewHeight1-30;
        }
    }else if (indexPath.row == 3){
        if(!self.previousTextViewContentHeight2){
            return self.otherViewHeight2;
        }else{
            return self.previousTextViewContentHeight2+self.otherViewHeight2-30;
        }
    }else if(indexPath.row == 4){
        if(!self.previousTextViewContentHeight3){
            return self.otherViewHeight3;
        }else{
            return self.previousTextViewContentHeight3+self.otherViewHeight3-30;
        }
    }else if(indexPath.row == 5){
        return 80;
    }else{
        return 252;
    }
}

-(void)submitAction{
    
}

-(void)dealloc{
    [self.otherView1.textView removeObserver:self forKeyPath:@"contentSize" context:nil];
    [self.otherView2.textView removeObserver:self forKeyPath:@"contentSize" context:nil];
    [self.otherView3.textView removeObserver:self forKeyPath:@"contentSize" context:nil];
}
@end
