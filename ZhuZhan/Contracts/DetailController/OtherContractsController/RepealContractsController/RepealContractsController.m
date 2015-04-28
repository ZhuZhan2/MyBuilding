//
//  RepealContractsController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/21.
//
//

#import "RepealContractsController.h"
#import "ContractsApi.h"
#import "PDFViewController.h"
#import "RKContractsStagesView.h"
#import "ContractsTradeCodeView.h"
#import "MainContractsBaseController.h"
#import "RKShadowView.h"
@interface RepealContractsController ()
@property (nonatomic, strong)UIAlertView* sureModifiAlertView;
@end

@implementation RepealContractsController

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
    return @"佣金撤销流程";
}

-(void)loadList{
    if (self.repealModel) {
        //[self reload];
    }else{
        [self startLoadingViewWithOption:0];
        NSMutableDictionary* dic=[NSMutableDictionary dictionary];
        NSString* contractsId=self.listSingleModel.a_contractsRecordId;
        [dic setObject:contractsId forKey:@"contractId"];
        [ContractsApi PostRevocationDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                self.repealModel=posts[0];
                [self reload];
            }
            [self stopLoadingView];
        } dic:dic noNetWork:nil];
    }
}

-(void)clauseMainBtnClicked{
    MainContractsBaseController* vc=[[MainContractsBaseController alloc]init];
    vc.contractId=self.repealModel.a_contractsRecordId;
    vc.isFromDetailView=YES;
    //vc.contractsStagesViewData=[self contractsStagesViewData];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)PDFBtnClicked{
    PDFViewController *view = [[PDFViewController alloc] init];
    view.ID = self.repealModel.a_id;
    view.type = @"2";
    view.name = self.repealModel.a_fileName;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)reload{
    [self.stagesView removeFromSuperview];
    self.stagesView=nil;
    [self initStagesView];
    
    [self.tradeCodeView removeFromSuperview];
    self.tradeCodeView=nil;
    [self initTradeCodeView];
    
    [self.PDFView removeFromSuperview];
    self.PDFView=nil;
    [self initPDFView];
    
    [self.btnToolBar removeFromSuperview];
    self.btnToolBar=nil;
    [self initBtnToolBar];
}

-(UIView *)PDFView{
    if (!_PDFView) {
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 265+10)];
        view.backgroundColor=[UIColor whiteColor];
        
        {
            UITextView* textView=[[UITextView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 255)];
            textView.text=self.repealModel.a_content;
            textView.userInteractionEnabled=NO;
            [view addSubview:textView];
        }
        
        {
            UIView* line=[RKShadowView seperatorLineShadowViewWithHeight:10];
            CGRect frame1=line.frame;
            frame1.origin.y=CGRectGetHeight(view.frame)-10;
            line.frame=frame1;
            [view addSubview:line];
        }
        
        _PDFView=view;
    }
    return _PDFView;
}

-(void)contractsBtnToolBarClickedWithBtn:(UIButton *)btn index:(NSInteger)index{
    [self startLoadingViewWithOption:1];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.repealModel.a_id;
    [dic setObject:contractsId forKey:@"id"];
    //不同意
    if (index==0) {
        NSLog(@"不同意成功");
        self.sureModifiAlertView=[[UIAlertView alloc]initWithTitle:@"" message:@"是否接受客服修改合同？" delegate:self cancelButtonTitle:nil otherButtonTitles:@"不接受",@"接受", nil];
        [self.sureModifiAlertView show];
    
    //同意
    }else if (index==1){
        [ContractsApi PostRevocationAgreeWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                NSLog(@"同意成功");
                [self sucessPost];
            }
        } dic:dic noNetWork:nil];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (self.sureModifiAlertView==alertView) {
        NSMutableDictionary* dic=[NSMutableDictionary dictionary];
        NSString* contractsId=self.repealModel.a_id;
        [dic setObject:contractsId forKey:@"id"];
        //不同意修改
        if (buttonIndex) {
            [ContractsApi PostRevocationModifyWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    NSLog(@"同意客服修改成功");
                    [self sucessPost];
                }
            } dic:dic noNetWork:nil];
            //同意修改
        }else{            
            [ContractsApi PostRevocationDisagreeWithBlock:^(NSMutableArray *posts, NSError *error) {
                if (!error) {
                    NSLog(@"不同意客服修改成功");
                    [self sucessPost];
                }
            } dic:dic noNetWork:nil];
        }
    }
}

-(UIView *)stagesView{
    if (!_stagesView) {
        NSInteger const status=self.repealModel.a_status;
        NSArray* bigStages=@[@"合同主要条款",@"供应商佣金合同",@"合同撤销流程"];
        NSArray* array;
        {
            if (self.repealModel.a_archiveStatus==1) {
                array=[self stylesWithNumber:4 count:4];
            }else if (status==4||status==5||status==6){
                array=[self stylesWithNumber:3 count:4];
            }else{
                array=[self stylesWithNumber:2 count:4];
            }
        }
        
        _stagesView=[RKContractsStagesView contractsStagesViewWithBigStageNames:bigStages smallStageNames:@[@[@"已完成"],@[@"已完成"],@[@"填写撤销协议",@"审核中",@"生成",@"完成"]] smallStageStyles:@[@[@0],@[@0],array] isClosed:self.repealModel.a_archiveStatus==2];
        CGRect frame=_stagesView.frame;
        frame.origin.y=64;
        _stagesView.frame=frame;
    }
    return _stagesView;
}

-(NSMutableArray*)contractsStagesViewData{
    NSMutableArray* datas=[NSMutableArray array];
    {
        NSArray* bigStageNames=@[@"合同主要条款",@"供应商佣金合同",@"填写撤销协议"];
        NSArray* smallStageNames=@[@[@"填写条款",@"待审核",@"生成条款"],@[@"已完成"],@[self.repealModel.a_archiveStatus==1?@"已完成":@"进行中"]];
        BOOL isClosed=self.repealModel.a_archiveStatus==2;
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
        
        if (self.repealModel.a_archiveStatus==2) {
            
        }else if (self.repealModel.a_status==1) {
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
        NSString* tradeCode=[NSString stringWithFormat:@"流水号:%@",self.repealModel.a_serialNumber];
        _tradeCodeView=[ContractsTradeCodeView contractsTradeCodeViewWithTradeCode:tradeCode time:self.repealModel.a_createdTime];
    }
    return _tradeCodeView;
}
@end
