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
@interface ContractsBaseViewController ()<ContractsViewDelegate>
@property (nonatomic, strong)RKContractsStagesView* contractsStagesView;
@property (nonatomic, strong)ProvisionalViewController *provisionalView;
@property (nonatomic, strong)BaseContractsView* providerConstractView;
@property (nonatomic, strong)BaseContractsView* salerConstractView;
@end

@implementation ContractsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavi];
    [self initContractsStagesView];
//    [self initProvisionalView];
//    [self initProviderConstractView];
//    [self initSalerConstractView];
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(void)initContractsStagesView{
    [self.view addSubview:self.contractsStagesView];
}

-(void)initProvisionalView{
    [self.view insertSubview:self.provisionalView.view belowSubview:self.contractsStagesView];
}

-(void)initProviderConstractView{
    [self.view addSubview:self.providerConstractView];
    CGRect frame=self.providerConstractView.frame;
    frame.origin.y=CGRectGetMaxY(self.contractsStagesView.frame);
    self.providerConstractView.frame=frame;
}

-(void)initSalerConstractView{
    [self.view addSubview:self.salerConstractView];
    CGRect frame=self.salerConstractView.frame;
    frame.origin.y=CGRectGetMaxY(self.contractsStagesView.frame);
    self.salerConstractView.frame=frame;
}

-(BaseContractsView *)providerConstractView{
    if (!_providerConstractView) {
        _providerConstractView=[BaseContractsView contractsViewWithPDFImageName:@[@"PDF1",@"PDF2"][arc4random()%2] btnImageNmaes:@[@"small不同意",@"small上传我的模版",@"small同--意"] delegate:self size:CGSizeMake(kScreenWidth, kScreenHeight-CGRectGetMaxY(self.contractsStagesView.frame))];
        _providerConstractView.hidden=YES;
    }
    return _providerConstractView;
}

-(BaseContractsView *)salerConstractView{
    if (!_salerConstractView) {
        _salerConstractView=[BaseContractsView contractsViewWithPDFImageName:@"PDF3" btnImageNmaes:@[@"big不同意",@"big同--意"] delegate:self size:CGSizeMake(kScreenWidth, kScreenHeight-CGRectGetMaxY(self.contractsStagesView.frame))];
        _salerConstractView.hidden=YES;
    }
    return _salerConstractView;
}

-(RKContractsStagesView *)contractsStagesView{
    if (!_contractsStagesView) {
        _contractsStagesView=[RKContractsStagesView contractsStagesViewWithBigStageNames:@[@"大标题1",@"大标题2",@"大标题3"] smallStageNames:@[@[@"小标题1",@"小标题2",@"小标题3"],@[@"小标题1",@"小标题2"],@[@"小标题"]] smallStageStyles:@[@[@0,@0,@0],@[@0,@1],@[@1]] isClosed:NO];
        CGRect frame=_contractsStagesView.frame;
        frame.origin.y=64;
        _contractsStagesView.frame=frame;
    }
    return _contractsStagesView;
}

-(ProvisionalViewController *)provisionalView{
    if(!_provisionalView){
        _provisionalView = [[ProvisionalViewController alloc] init];
    }
    return _provisionalView;
}
@end
