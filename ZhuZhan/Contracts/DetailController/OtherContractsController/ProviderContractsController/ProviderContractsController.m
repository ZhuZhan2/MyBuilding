//
//  ProviderContractsController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/20.
//
//

#import "ProviderContractsController.h"
#import "ContractsApi.h"
#import "RKContractsStagesView.h"
#import "PDFViewController.h"
#import "MainContractsBaseController.h"
#import "ContractsTradeCodeView.h"
@interface ProviderContractsController ()

@end

@implementation ProviderContractsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviExtra];
    [self loadList];
}

-(void)initNaviExtra{
    self.title=self.title;
}

-(NSString *)title{
    return @"供应商佣金合同";
}

-(void)PDFBtnClicked{
    PDFViewController *view = [[PDFViewController alloc] init];
    view.ID = self.mainClauseModel.a_id;
    view.type = @"0";
    view.name = self.mainClauseModel.a_fileName;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)loadList{
    //消息页进来
    if (self.mainClauseModel) {
//        [self reload];
        
    //全部佣金列表页进来
    }else{
        [self startLoadingViewWithOption:0];
        NSMutableDictionary* dic=[NSMutableDictionary dictionary];
        [dic setObject:self.listSingleModel.a_id forKey:@"contractId"];
        [ContractsApi PostDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.mainClauseModel=posts[0];
                [self reload];
            }
            [self stopLoadingView];
        } dic:dic noNetWork:nil];
    }
}

-(void)reload{
    [self initNavi];
    
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
    vc.contractId=self.mainClauseModel.a_id;
    vc.isFromDetailView=YES;
//    vc.contractsStagesViewData=[self contractsStagesViewData];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)initNavi{
    [self setLeftBtnWithImage:[GetImagePath getImagePath:@"013"]];
    if ([self canClose]) {
        [self setRightBtnWithText:@"更多"];
    }
}

-(void)contractsBtnToolBarClickedWithBtn:(UIButton *)btn index:(NSInteger)index{
    [self startLoadingViewWithOption:1];

    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.mainClauseModel.a_id;
    [dic setObject:contractsId forKey:@"id"];
    
    //不同意
    if (index==0) {
        [ContractsApi PostCommissionDisagreeWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                NSLog(@"不同意成功");
                [self sucessPost];
            }else{
                if([ErrorCode errorCode:error]==403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:^{
            [ErrorCode alert];
        }];
        //同意
    }else if (index==1){
        [ContractsApi PostCommissionAgreeWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                NSLog(@"同意成功");
                [self sucessPost];
            }else{
                if([ErrorCode errorCode:error]==403){
                    [LoginAgain AddLoginView:NO];
                }else{
                    [ErrorCode alert];
                }
            }
        } dic:dic noNetWork:nil];
    }
}

-(BOOL)canClose{
//    BOOL hasSaleFile=self.listSingleModel.a_saleHas;
    BOOL canClose=self.mainClauseModel.a_status==4;//&&!hasSaleFile;
    return canClose;
}

-(void)closeBtnClickedWithContent:(NSString*)content{
    [self startLoadingViewWithOption:1];

    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.mainClauseModel.a_id;
    [dic setObject:contractsId forKey:@"id"];
    [dic setObject:content forKey:@"remark"];
    [ContractsApi PostCommissionCloseWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self sucessPost];
        }
    } dic:dic noNetWork:nil];
}

-(UIView *)stagesView{
    if (!_stagesView) {
        NSInteger const status=self.mainClauseModel.a_status;
        NSInteger const saleStatus=self.mainClauseModel.a_salestatus;
        NSInteger const saleArchiveStatus=self.mainClauseModel.a_saleArchiveStatus;
        NSInteger const archiveStatus=self.mainClauseModel.a_archiveStatus;
        BOOL const hasSalerFile=saleStatus;
        
        NSArray* bigStages=@[@"合同主要条款",@"供应商佣金合同",@"销售佣金合同"];
        NSArray* array;
        
            if (status==9||hasSalerFile) {
                array=[self stylesWithNumber:4 count:4];
            }else if (status==5||status==7||status==8){
                array=[self stylesWithNumber:3 count:4];
            }else{
                array=[self stylesWithNumber:2 count:4];
            }
        
        
        if (self.mainClauseModel.a_saleArchiveStatus==2&&self.mainClauseModel.a_archiveStatus!=2) {
            _stagesView=[RKContractsStagesView contractsStagesViewWithBigStageNames:bigStages smallStageNames:@[@[@"已完成"],@[@"填写合同",@"审核中",@"生成",@"上传"],@[@"已关闭"]] smallStageStyles:@[@[@0],@[@0,@0,@0,@0],@[@2]] isClosed:NO];
        }else{
            NSString* smallStageName=[ContractsMainClauseModel getArchiveStatusStringWithArchiveStatus:saleArchiveStatus];
            
            _stagesView=[RKContractsStagesView contractsStagesViewWithBigStageNames:bigStages smallStageNames:@[@[@"已完成"],@[@"填写合同",@"审核中",@"生成",@"上传"],@[smallStageName]] smallStageStyles:@[@[@0],array,@[saleArchiveStatus==-1?@1:@0]] isClosed:archiveStatus==2||saleArchiveStatus==2];
        }
        
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
        
        NSArray* smallStageNames=@[@[@"填写条款",@"待审核",@"生成条款"],@[self.mainClauseModel.a_archiveStatus==2?@"已关闭":(self.mainClauseModel.a_archiveStatus==1?@"已完成":@"进行中")],@[self.mainClauseModel.a_salestatus==0?@"未开始":(self.mainClauseModel.a_saleArchiveStatus==1?@"已完成":@"进行中")]];
        BOOL isClosed=self.mainClauseModel.a_archiveStatus==2||self.mainClauseModel.a_saleArchiveStatus==2;
        NSArray* smallStageStyles=@[@[@0,@0,@0],@[@0],@[self.mainClauseModel.a_salestatus==0?@1:@0]];
        
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
        
        if (self.mainClauseModel.a_archiveStatus==2) {
            
        }else if (self.mainClauseModel.a_status==3||self.mainClauseModel.a_status==6) {
            imageNames=@[@"不同意带字",@"同意带字"];
        }
        
        for (int i=0;i<imageNames.count;i++) {
            UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
            UIImage* image=[GetImagePath getImagePath:imageNames[i]];
            btn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btns addObject:btn];
        }
        _btnToolBar=[ContractsBtnToolBar contractsBtnToolBarWithBtns:btns contentMaxWidth:295 top:5 bottom:30 contentHeight:37];
        
        _btnToolBar.delegate=self;
    }
    return _btnToolBar;
}

-(ContractsTradeCodeView *)tradeCodeView{
    if (!_tradeCodeView) {
        NSString* tradeCode=[NSString stringWithFormat:@"流水号:%@",self.mainClauseModel.a_serialNumber];
        _tradeCodeView=[ContractsTradeCodeView contractsTradeCodeViewWithTradeCode:tradeCode time:self.mainClauseModel.a_createdTime];
    }
    return _tradeCodeView;
}
@end
