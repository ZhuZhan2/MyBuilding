//
//  SalerContractsController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/20.
//
//

#import "SalerContractsController.h"
#import "ContractsApi.h"
#import "RKContractsStagesView.h"
#import "PDFViewController.h"
#import "MainContractsBaseController.h"
#import "ContractsTradeCodeView.h"
@interface SalerContractsController ()
@end

@implementation SalerContractsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviExtra];
    [self loadList];
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
}

-(void)initNaviExtra{
    self.title=self.title;
}

-(NSString *)title{
    return @"销售佣金合同";
}

-(void)PDFBtnClicked{
    PDFViewController *view = [[PDFViewController alloc] init];
    view.ID = self.salerModel.a_id;
    view.type = @"1";
    view.name = self.salerModel.a_fileName;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)loadList{
    if (self.salerModel) {
        //[self reload];
    }else{
        [self startLoadingViewWithOption:0];
        NSMutableDictionary* dic=[NSMutableDictionary dictionary];
#warning 需要查看这个id是否对，可能是contractsRecordId
        NSString* contractsId=self.listSingleModel.a_id;
        [dic setObject:contractsId forKey:@"contractId"];
        [ContractsApi PostSalesDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.salerModel=posts[0];
                [self reload];
            }
            [self stopLoadingView];
        } dic:dic noNetWork:nil];
    }
}

-(void)reload{
    [self.stagesView removeFromSuperview];
    self.stagesView=nil;
    [self initStagesView];
    
    [self.tradeCodeView removeFromSuperview];
    self.tradeCodeView=nil;
    [self initTradeCodeView];
    
    [self.btnToolBar removeFromSuperview];
    self.btnToolBar=nil;
    [self initBtnToolBar];
}

-(void)clauseMainBtnClicked{
    MainContractsBaseController* vc=[[MainContractsBaseController alloc]init];
    vc.contractId=self.salerModel.a_contractsRecordId;
    vc.contractsStagesViewData=[self contractsStagesViewData];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)contractsBtnToolBarClickedWithBtn:(UIButton *)btn index:(NSInteger)index{
    [self startLoadingViewWithOption:1];

    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.salerModel.a_id;
    [dic setObject:contractsId forKey:@"id"];
    //不同意
    if (index==0) {
        [ContractsApi PostSalesDisagreeWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                NSLog(@"不同意成功");
                [self sucessPost];
            }
        } dic:dic noNetWork:nil];
        
        //同意
    }else if (index==1){
        [ContractsApi PostSalesAgreeWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                NSLog(@"同意成功");
                [self sucessPost];
            }
        } dic:dic noNetWork:nil];
    }
}

-(UIView *)stagesView{
    if (!_stagesView) {
        NSInteger const status=self.salerModel.a_status;
        NSArray* bigStages=@[@"合同主要条款",@"供应商佣金合同",@"销售佣金合同"];
        NSArray* array;
        {
            if (status<=2) {
                array=[self stylesWithNumber:2 count:4];
            }else if (status==5){
                array=[self stylesWithNumber:4 count:4];
            }else{
                array=[self stylesWithNumber:3 count:4];
            }
        }
        _stagesView=[RKContractsStagesView contractsStagesViewWithBigStageNames:bigStages smallStageNames:@[@[@"已完成"],@[@"已完成"],@[@"填写合同",@"审核中",@"生成",@"完成"]] smallStageStyles:@[@[@0],@[@0],array] isClosed:self.salerModel.a_archiveStatus==2];
        CGRect frame=_stagesView.frame;
        frame.origin.y=64;
        _stagesView.frame=frame;
    }
    return _stagesView;
}

-(NSMutableArray*)contractsStagesViewData{
    NSMutableArray* datas=[NSMutableArray array];
    {
        NSArray* bigStageNames=@[@"合同主要条款",@"供应商佣金合同",@"销售佣金合同"];
        NSArray* smallStageNames=@[@[@"填写条款",@"待审核",@"生成条款"],@[@"已完成"],@[self.salerModel.a_archiveStatus==1?@"已完成":@"进行中"]];
        BOOL isClosed=self.salerModel.a_archiveStatus==2;
        NSArray* smallStageStyles=@[@[@0,@0,@0],@[@0],@[@0]];
        
        [datas addObject:bigStageNames];
        [datas addObject:smallStageNames];
        [datas addObject:smallStageStyles];
        [datas addObject:@(isClosed)];
    }
    return datas;
}

/*
 同意带字 不同意带字 关闭带字 修改带字
 同意小带字 不同意小带字 上传小带字
 同意迷你带字 不同意迷你带字 上传迷你带字 选项按钮
 */
-(ContractsBtnToolBar *)btnToolBar{
    if (!_btnToolBar) {
        NSMutableArray* btns=[NSMutableArray array];
        NSArray* imageNames;
        if (self.salerModel.a_archiveStatus==2) {
            
        }else if (self.salerModel.a_status==1) {
            imageNames=@[@"不同意带字",@"同意带字"];
        }
        
        for (int i=0;i<imageNames.count;i++) {
            UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage* image=[GetImagePath getImagePath:imageNames[i]];
            btn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btns addObject:btn];
        }
        _btnToolBar=[ContractsBtnToolBar contractsBtnToolBarWithBtns:btns contentMaxWidth:270 top:5 bottom:30 contentHeight:37];
        
        _btnToolBar.delegate=self;
    }
    return _btnToolBar;
}

-(ContractsTradeCodeView *)tradeCodeView{
    if (!_tradeCodeView) {
        NSString* tradeCode=[NSString stringWithFormat:@"流水号:%@",self.salerModel.a_serialNumber];
        _tradeCodeView=[ContractsTradeCodeView contractsTradeCodeViewWithTradeCode:tradeCode time:self.salerModel.a_createdTime];
    }
    return _tradeCodeView;
}
@end
