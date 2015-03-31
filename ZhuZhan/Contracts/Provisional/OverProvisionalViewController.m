//
//  OverProvisionalViewController.m
//  ZhuZhan
//
//  Created by 汪洋 on 15/3/31.
//
//

#import "OverProvisionalViewController.h"
#import "CodeView.h"
#import "StartManView.h"
#import "ReceiveView.h"
#import "OtherView.h"
#import "MoneyView.h"
#import "ContractView.h"
#import "ButtonView.h"
@interface OverProvisionalViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *viewArr;
@property(nonatomic,strong)CodeView *codeView;
@property(nonatomic,strong)StartManView *startMainView;
@property(nonatomic)float startMainViewHeight;
@property(nonatomic,strong)ReceiveView *receiveView;
@property(nonatomic)float receiveViewHeight;
@property(nonatomic,strong)OtherView *otherView1;
@property(nonatomic)float otherViewHeight1;
@property(nonatomic,strong)OtherView *otherView2;
@property(nonatomic)float otherViewHeight2;
@property(nonatomic,strong)OtherView *otherView3;
@property(nonatomic)float otherViewHeight3;
@property(nonatomic,strong)MoneyView *moneyView;
@property(nonatomic)float moneyViewHeight;
@property(nonatomic,strong)ContractView *contractView;
@property(nonatomic)float contractViewHeight;
@property(nonatomic,strong)ButtonView *buttonView;
@end

@implementation OverProvisionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableView *)tableView{
    if(!_tableView){
        //_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 132, 320, kScreenHeight-132)];
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

-(CodeView *)codeView{
    if(!_codeView){
        _codeView = [[CodeView alloc] initWithFrame:CGRectMake(0, 0, 320, 65)];
        _codeView.timeLabel.text = @"134123412341234";
        _codeView.tradCodeLabel.text = @"2123412341234";
    }
    return _codeView;
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
        } str:@"发起者用户名"];
    }
    return _startMainView;
}

-(ReceiveView *)receiveView{
    if(!_receiveView){
        _receiveView = [[ReceiveView alloc] initWithFrame:CGRectZero isOver:YES];
        [_receiveView GetHeightOverWithBlock:^(double height) {
            if(height<70){
                height = 70;
            }
            self.receiveViewHeight = height;
            _receiveView.frame = CGRectMake(0, 0, 320, height);
        } str:@"参与的人"];
    }
    return _receiveView;
}

-(OtherView *)otherView1{
    if(!_otherView1){
        _otherView1 = [[OtherView alloc] initWithFrame:CGRectZero isOver:YES];
        [_otherView1 GetHeightOverWithBlock:^(double height) {
            if(height<60){
                height = 60;
            }
            self.otherViewHeight1 = height;
            _otherView1.frame = CGRectMake(0, 0, 320, height);
        } titleStr:@"甲方" contentStr:@"asdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadf"];
    }
    return _otherView1;
}

-(OtherView *)otherView2{
    if(!_otherView2){
        _otherView2 = [[OtherView alloc] initWithFrame:CGRectZero isOver:YES];
        [_otherView2 GetHeightOverWithBlock:^(double height) {
            if(height<60){
                height = 60;
            }
            self.otherViewHeight2 = height;
            _otherView2.frame = CGRectMake(0, 0, 320, height);
        } titleStr:@"乙方" contentStr:@"asdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadf"];
    }
    return _otherView2;
}

-(OtherView *)otherView3{
    if(!_otherView3){
        _otherView3 = [[OtherView alloc] initWithFrame:CGRectZero isOver:YES];
        [_otherView3 GetHeightOverWithBlock:^(double height) {
            if(height<60){
                height = 60;
            }
            self.otherViewHeight3 = height;
            _otherView3.frame = CGRectMake(0, 0, 320, height);
        } titleStr:@"开票公司抬头" contentStr:@"asdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadfasdfasdfasdfsadfsdafsadf"];
    }
    return _otherView3;
}

-(MoneyView *)moneyView{
    if(!_moneyView){
        _moneyView = [[MoneyView alloc] initWithFrame:CGRectZero isOver:YES];
        [_moneyView GetHeightOverWithBlock:^(double height) {
            if(height<60){
                height=60;
            }
            self.moneyViewHeight = height;
            _otherView3.frame = CGRectMake(0, 0, 320, height);
        } str:@"asdfasdfasdfasdf"];
    }
    return _moneyView;
}

-(ContractView *)contractView{
    if(!_contractView){
        _contractView = [[ContractView alloc] initWithFrame:CGRectZero isOver:YES];
        [_contractView GetHeightOverWithBlock:^(double height) {
            if(height<60){
                height=60;
            }
            self.contractViewHeight = height;
            _contractView.frame = CGRectMake(0, 0, 320, height);
        } str:@"asdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdfasdf"];
    }
    return _contractView;
}

-(ButtonView *)buttonView{
    if(!_buttonView){
        _buttonView = [[ButtonView alloc] initWithFrame:CGRectMake(0, 0, 320, 48) flag:2];
    }
    return _buttonView;
}

-(NSMutableArray *)viewArr{
    if(!_viewArr){
        _viewArr = [NSMutableArray array];
        [_viewArr addObject:self.codeView];
        [_viewArr addObject:self.startMainView];
        [_viewArr addObject:self.receiveView];
        [_viewArr addObject:self.otherView1];
        [_viewArr addObject:self.otherView2];
        [_viewArr addObject:self.otherView3];
        [_viewArr addObject:self.moneyView];
        [_viewArr addObject:self.contractView];
        [_viewArr addObject:self.buttonView];
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
    if(indexPath.row == 1){
        return self.startMainViewHeight;
    }else if(indexPath.row == 2){
        return self.receiveViewHeight;
    }else if(indexPath.row == 3){
        return self.otherViewHeight1;
    }else if(indexPath.row == 4){
        return self.otherViewHeight2;
    }else if(indexPath.row == 5){
        return self.otherViewHeight3;
    }else if (indexPath.row == 6){
        return self.moneyViewHeight;
    }else if(indexPath.row == 7){
        return self.contractViewHeight;
    }
    return 65;
}
@end
