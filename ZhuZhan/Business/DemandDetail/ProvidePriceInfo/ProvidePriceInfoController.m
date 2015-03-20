//
//  ProvidePriceInfoController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/20.
//
//

#import "ProvidePriceInfoController.h"
#import "TopView.h"
#import "RKLeftAndRightView.h"
#import "RKUpAndDownView.h"
#import "RKShadowView.h"
@interface ProvidePriceInfoController ()
@property(nonatomic,strong)UIView* firstView;
@property(nonatomic,strong)UIView* secondView;
@property(nonatomic,strong)UIView* thirdView;
@property(nonatomic,strong)UIView* fourthView;
@property(nonatomic,strong)UIView* fifthView;
@property(nonatomic,strong)UIView* sixthView;
@property(nonatomic,strong)NSArray* contentViews;

@property(nonatomic,strong)UIView* topView;
@end

@implementation ProvidePriceInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavi];
    [self initTopView];
    [self initTableView];
    [self initTableViewExtra];
}

-(void)initNavi{
    self.title=@"报价资料";
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    [self setRightBtnWithText:@"提交"];
}

-(void)initTopView{
    self.topView=[[TopView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 48) firstStr:@"询价 2013-12-12 12:12" secondStr:@"流水号:12345678" colorArr:@[[UIColor blackColor],AllLightGrayColor]];
    [self.view addSubview:self.topView];
}

-(void)initTableViewExtra{
    CGRect frame=self.tableView.frame;
    CGFloat extraHeight=CGRectGetHeight(self.topView.frame);
    frame.origin.y+=extraHeight;
    frame.size.height-=extraHeight;
    self.tableView.frame=frame;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentViews.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGRectGetHeight([self.contentViews[indexPath.row] frame]);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView* view=self.contentViews[indexPath.row];
    CGRect frame=view.frame;
    frame.origin.x=(kScreenWidth-CGRectGetWidth(view.frame))/2;
    view.frame=frame;
    [cell.contentView addSubview:view];
    
    UIView* seperatorLine=[RKShadowView seperatorLineWithHeight:2];
    frame=seperatorLine.frame;
    frame.origin.y=CGRectGetHeight(view.frame)-CGRectGetHeight(seperatorLine.frame)+1;
    seperatorLine.frame=frame;
    NSLog(@"frame=%@",NSStringFromCGRect(frame));
    [cell.contentView addSubview:seperatorLine];
    
    return cell;
}

-(NSArray *)contentViews{
    if (!_contentViews) {
        _contentViews=@[self.firstView,self.secondView,self.thirdView,self.fourthView,self.fifthView,self.sixthView];
    }
    return _contentViews;
}

-(UIView *)firstView{
    if (!_firstView) {
        _firstView=[RKLeftAndRightView upAndDownViewWithUpContent:@"求购用户" downContent:@"撒旦撒旦撒大师大师大师" topDistance:20 bottomDistance:20 maxWidth:kScreenWidth-50];
    }
    return _firstView;
}

-(UIView *)secondView{
    if (!_secondView) {
        _secondView=[RKUpAndDownView upAndDownViewWithUpContent:@"产品大类" downContent:@"水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水泥" topDistance:14 bottomDistance:14 maxWidth:kScreenWidth-50];
    }
    return _secondView;
}

-(UIView *)thirdView{
    if (!_thirdView) {
        _thirdView=[RKUpAndDownView upAndDownViewWithUpContent:@"产品分类" downContent:@"水泥" topDistance:14 bottomDistance:14 maxWidth:kScreenWidth-50];

    }
    return _thirdView;
}

-(UIView *)fourthView{
    if (!_fourthView) {
        _fourthView=[RKUpAndDownView upAndDownViewWithUpContent:@"需求描述" downContent:@"dddddd水泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水泥" topDistance:20 bottomDistance:20 maxWidth:kScreenWidth-50];

    }
    return _fourthView;
}

-(UIView *)fifthView{
    if (!_fifthView) {
        _fifthView=[RKUpAndDownView upAndDownViewWithUpContent:@"回复" downContent:@"水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水泥" topDistance:20 bottomDistance:20 maxWidth:kScreenWidth-50];

    }
    return _fifthView;
}

-(UIView *)sixthView{
    if (!_sixthView) {
        _sixthView=[RKUpAndDownView upAndDownViewWithUpContent:@"产品大类" downContent:@"水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥水传说中的描述泥" topDistance:14 bottomDistance:14 maxWidth:kScreenWidth-50];
    }
    return _sixthView;
}
@end
