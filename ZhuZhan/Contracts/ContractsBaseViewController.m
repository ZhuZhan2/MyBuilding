//
//  ContractsBaseViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import "ContractsBaseViewController.h"
#import "BaseContractsView.h"
#import "ProvisionalViewController.h"
#import "OverProvisionalViewController.h"
@interface ContractsBaseViewController ()<RKMuchBtnsDelegate,ContractsViewDelegate>
@property (nonatomic, strong)ProvisionalViewController *provisionalView;
@property (nonatomic, strong)BaseContractsView* providerConstractView;
@property (nonatomic, strong)BaseContractsView* salerConstractView;
@end

@implementation ContractsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavi];
    [self initMuchBtns];
    [self initProvisionalView];
    [self initProviderConstractView];
    [self initSalerConstractView];
    [self.muchBtns contentBtnsClickedWithNumber:0];
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(void)muchBtnsClickedWithNumber:(NSInteger)number{
    NSArray* views=@[self.provisionalView.view,self.providerConstractView,self.salerConstractView];
    [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj setHidden:!(idx==number)];
    }];
    
    NSArray* titles=@[@"主要合同条款",@"供应商佣金合同",@"销售佣金合同"];
    self.title=titles[number];
    
    if (number) {
        [self.provisionalView.view endEditing:YES];
    }
}

-(void)initMuchBtns{
    [self.view addSubview:self.muchBtns];
}

-(void)initProvisionalView{
    [self.view insertSubview:self.provisionalView.view belowSubview:self.muchBtns];
}

-(void)initProviderConstractView{
    [self.view addSubview:self.providerConstractView];
    CGRect frame=self.providerConstractView.frame;
    frame.origin.y=CGRectGetMaxY(self.muchBtns.frame);
    self.providerConstractView.frame=frame;
}

-(void)initSalerConstractView{
    [self.view addSubview:self.salerConstractView];
    CGRect frame=self.salerConstractView.frame;
    frame.origin.y=CGRectGetMaxY(self.muchBtns.frame);
    self.salerConstractView.frame=frame;
}

-(BaseContractsView *)providerConstractView{
    if (!_providerConstractView) {
        _providerConstractView=[BaseContractsView contractsViewWithPDFImageName:@[@"PDF1",@"PDF2"][arc4random()%2] btnImageNmaes:@[@"small不同意",@"small上传我的模版",@"small同--意"] delegate:self size:CGSizeMake(kScreenWidth, kScreenHeight-CGRectGetMaxY(self.muchBtns.frame))];
        _providerConstractView.hidden=YES;
    }
    return _providerConstractView;
}

-(BaseContractsView *)salerConstractView{
    if (!_salerConstractView) {
        _salerConstractView=[BaseContractsView contractsViewWithPDFImageName:@"PDF3" btnImageNmaes:@[@"big不同意",@"big同--意"] delegate:self size:CGSizeMake(kScreenWidth, kScreenHeight-CGRectGetMaxY(self.muchBtns.frame))];
        _salerConstractView.hidden=YES;
    }
    return _salerConstractView;
}

-(RKMuchBtns *)muchBtns{
    if (!_muchBtns) {
        _muchBtns=[RKMuchBtns muchBtnsWithContents:@[@"主要合同条款",@"供应商佣金合同",@"销售佣金合同"] mainSize:CGSizeMake(kScreenWidth,30) assistSize:CGSizeMake(kScreenWidth,35) assistStageCounts:@[@2,@3,@2] delegate:self];
        CGRect frame=_muchBtns.frame;
        frame.origin.y=64;
        _muchBtns.frame=frame;
        
        [_muchBtns setContentLabelWithNumber:2 enabled:NO];
    }
    return _muchBtns;
}

-(ProvisionalViewController *)provisionalView{
    if(!_provisionalView){
        _provisionalView = [[ProvisionalViewController alloc] init];
    }
    return _provisionalView;
}
@end
