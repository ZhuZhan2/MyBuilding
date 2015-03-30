//
//  ContractsBaseViewController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/3/30.
//
//

#import "ContractsBaseViewController.h"
#import "BaseContractsView.h"
@interface ContractsBaseViewController ()<RKMuchBtnsDelegate,ContractsViewDelegate>
@property (nonatomic, strong)BaseContractsView* providerConstractView;
@property (nonatomic, strong)BaseContractsView* salerConstractView;
@end

@implementation ContractsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initMuchBtns];
    [self initProviderConstractView];
    [self initSalerConstractView];
}

-(void)muchBtnsClickedWithNumber:(NSInteger)number{
    if (number==1) {
        self.providerConstractView.hidden=NO;
        self.salerConstractView.hidden=YES;
    }else if (number==2){
        self.providerConstractView.hidden=YES;
        self.salerConstractView.hidden=NO;
    }
}

-(void)initMuchBtns{
    [self.view addSubview:self.muchBtns];
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
        _muchBtns=[RKMuchBtns muchBtnsWithContents:@[@"临时合同条款",@"供应商佣金合同",@"销售佣金合同"] mainSize:CGSizeMake(kScreenWidth,30) assistSize:CGSizeMake(kScreenWidth,35) assistStageCount:3 delegate:self];
        
        CGRect frame=_muchBtns.frame;
        frame.origin.y=64;
        _muchBtns.frame=frame;
    }
    return _muchBtns;
}
@end
