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
#import "RKContractsStagesView.h"
#import "ContractsTradeCodeView.h"
@interface ContractsBaseViewController ()<ContractsViewDelegate>

//@property (nonatomic, strong)ProvisionalViewController *provisionalView;
//@property (nonatomic, strong)BaseContractsView* providerConstractView;
//@property (nonatomic, strong)BaseContractsView* salerConstractView;
@end

@implementation ContractsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavi];
    [self initStagesView];
    [self initTradeCodeView];
//    [self initProvisionalView];
//    [self initProviderConstractView];
//    [self initSalerConstractView];
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    self.needAnimaiton=YES;
}

-(void)initStagesView{
    [self.view addSubview:self.stagesView];
}

-(void)initTradeCodeView{
    [self.view insertSubview:self.tradeCodeView belowSubview:self.stagesView];
    CGRect frame=self.tradeCodeView.frame;
    frame.origin.y=CGRectGetMaxY(self.stagesView.frame);
    self.tradeCodeView.frame=frame;
}

//-(void)initProvisionalView{
//    [self.view insertSubview:self.provisionalView.view belowSubview:self.contractsStagesView];
//}
//
//-(void)initProviderConstractView{
//    [self.view addSubview:self.providerConstractView];
//    CGRect frame=self.providerConstractView.frame;
//    frame.origin.y=CGRectGetMaxY(self.contractsStagesView.frame);
//    self.providerConstractView.frame=frame;
//}
//
//-(void)initSalerConstractView{
//    [self.view addSubview:self.salerConstractView];
//    CGRect frame=self.salerConstractView.frame;
//    frame.origin.y=CGRectGetMaxY(self.contractsStagesView.frame);
//    self.salerConstractView.frame=frame;
//}

//-(BaseContractsView *)providerConstractView{
//    if (!_providerConstractView) {
//        _providerConstractView=[BaseContractsView contractsViewWithPDFImageName:@[@"PDF1",@"PDF2"][arc4random()%2] btnImageNmaes:@[@"small不同意",@"small上传我的模版",@"small同--意"] delegate:self size:CGSizeMake(kScreenWidth, kScreenHeight-CGRectGetMaxY(self.contractsStagesView.frame))];
//        _providerConstractView.hidden=YES;
//    }
//    return _providerConstractView;
//}
//
//-(BaseContractsView *)salerConstractView{
//    if (!_salerConstractView) {
//        _salerConstractView=[BaseContractsView contractsViewWithPDFImageName:@"PDF3" btnImageNmaes:@[@"big不同意",@"big同--意"] delegate:self size:CGSizeMake(kScreenWidth, kScreenHeight-CGRectGetMaxY(self.contractsStagesView.frame))];
//        _salerConstractView.hidden=YES;
//    }
//    return _salerConstractView;
//}

-(RKContractsStagesView *)stagesView{
    if (!_stagesView) {
        _stagesView=[RKContractsStagesView contractsStagesViewWithBigStageNames:@[@"大标题1",@"大标题2",@"大标题3"] smallStageNames:@[@[@"小标题1",@"小标题2",@"小标题3"],@[@"小标题1",@"小标题2"],@[@"小标题"]] smallStageStyles:@[@[@0,@0,@0],@[@0,@1],@[@1]] isClosed:NO];
        CGRect frame=_stagesView.frame;
        frame.origin.y=64;
        _stagesView.frame=frame;
    }
    return _stagesView;
}

-(ContractsTradeCodeView *)tradeCodeView{
    if (!_tradeCodeView) {
        _tradeCodeView=[ContractsTradeCodeView contractsTradeCodeViewWithTradeCode:@"流水号:32948238476283" time:@"2015-03-21 22:34"];
    }
    return _tradeCodeView;
}

//-(ProvisionalViewController *)provisionalView{
//    if(!_provisionalView){
//        _provisionalView = [[ProvisionalViewController alloc] init];
//    }
//    return _provisionalView;
//}
@end
