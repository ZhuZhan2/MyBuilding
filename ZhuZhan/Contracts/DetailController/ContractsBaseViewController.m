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
@property (nonatomic, strong)UIAlertView* sucessAlertView;
@end

@implementation ContractsBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self initNavi];
    [self initStagesView];
    [self initTradeCodeView];
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

-(void)sucessPost{
    self.sucessAlertView=[[UIAlertView alloc]initWithTitle:@"提醒" message:@"操作成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [self.sucessAlertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (self.sucessAlertView==alertView) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(UIView *)stagesView{
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
        NSString* tradeCode=[NSString stringWithFormat:@"流水号:%@",self.listSingleModel.a_serialNumber];
        _tradeCodeView=[ContractsTradeCodeView contractsTradeCodeViewWithTradeCode:tradeCode time:self.listSingleModel.a_createdTime];
    }
    return _tradeCodeView;
}
@end
