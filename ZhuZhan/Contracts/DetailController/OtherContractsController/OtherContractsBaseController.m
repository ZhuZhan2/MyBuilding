//
//  OtherContractsBaseController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/10.
//
//

#import "OtherContractsBaseController.h"
#import "ContractsBtnToolBar.h"
#import "RKShadowView.h"
#import "ContractsTradeCodeView.h"
#import "MainContractsBaseController.h"
@interface OtherContractsBaseController ()

@end

@implementation OtherContractsBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=AllBackDeepGrayColor;
    [self initClauseMainBtn];
    [self initPDFView];
    [self initBtnToolBar];
}

-(void)PDFBtnClicked{
    NSLog(@"pdfBtnClicked");
}

-(void)contractsBtnToolBarClickedWithBtn:(UIButton *)btn index:(NSInteger)index{
    NSLog(@"index=%d",(int)index);
}

-(void)clauseMainBtnClicked{
    NSLog(@"合同主要条款点击");
    return;
    MainContractsBaseController* vc=[[MainContractsBaseController alloc]init];
    vc.listSingleModel=self.listSingleModel;
    vc.contractsStagesViewData=[self contractsStagesViewData];
    [self.navigationController pushViewController:vc animated:YES];
}

-(NSMutableArray*)contractsStagesViewData{
    NSMutableArray* datas=[NSMutableArray array];
    {
        NSArray* bigStageNames=@[@"合同主要条款",@"供应商佣金合同",@"销售佣金合同"];
        NSArray* smallStageNames=@[@[@"填写条款",@"待审核",@"生成条款"],@[@"未开始"],@[@"未开始"]];
        NSArray* smallStageStyles=@[@[@0,@0,@0],@[@1],@[@1]];
        
        [datas addObject:bigStageNames];
        [datas addObject:smallStageNames];
        [datas addObject:smallStageStyles];
    }
    return datas;
}

-(void)initClauseMainBtn{
    [self.view addSubview:self.clauseMainBtn];
    CGRect frame=self.clauseMainBtn.frame;
    frame.origin.y=CGRectGetMaxY(self.tradeCodeView.frame);
    self.clauseMainBtn.frame=frame;
}

-(void)initPDFView{
    [self.view addSubview:self.PDFView];
    CGRect frame=self.PDFView.frame;
    frame.origin.y=CGRectGetMaxY(self.clauseMainBtn.frame);
    self.PDFView.frame=frame;
}

-(void)initBtnToolBar{
    [self.view addSubview:self.btnToolBar];
    NSLog(@"frame=%@",NSStringFromCGRect(self.btnToolBar.frame));
    CGRect frame=self.btnToolBar.frame;
    frame.origin.y=CGRectGetMaxY(self.PDFView.frame);
    self.btnToolBar.frame=frame;
    NSLog(@"frame=%@",NSStringFromCGRect(self.btnToolBar.frame));
}

-(UIButton *)clauseMainBtn{
    if (!_clauseMainBtn) {
        _clauseMainBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _clauseMainBtn.frame=CGRectMake(0, 0, kScreenWidth, 50);
        _clauseMainBtn.backgroundColor=[UIColor whiteColor];
        
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 40)];
        label.text=@"点击查看合同主要条款";
        label.textColor=AllDeepGrayColor;
        label.font=[UIFont systemFontOfSize:15];
        
        UIImageView* assistView=[[UIImageView alloc]initWithFrame:CGRectMake(295, 14, 8, 14)];
        assistView.image=[GetImagePath getImagePath:@"绿色箭头"];
        
        UIView* line=[RKShadowView seperatorLineShadowViewWithHeight:10];
        CGRect frame=line.frame;
        frame.origin.y=CGRectGetMaxY(label.frame);
        line.frame=frame;
        
        [_clauseMainBtn addSubview:label];
        [_clauseMainBtn addSubview:assistView];
        [_clauseMainBtn addSubview:line];
        
        [_clauseMainBtn addTarget:self action:@selector(clauseMainBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clauseMainBtn;
}

-(UIView *)PDFView{
    if (!_PDFView) {
        UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 265+10)];
        view.backgroundColor=[UIColor whiteColor];
        
        {
            UIButton* PDFBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160, 194)];
            PDFBtn.center=CGPointMake(kScreenWidth*0.5, 140);
            [PDFBtn setBackgroundImage:[GetImagePath getImagePath:@"PDF"] forState:UIControlStateNormal];
            [PDFBtn addTarget:self action:@selector(PDFBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:PDFBtn];
            
            {
                UILabel* label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 40)];
                label1.center=CGPointMake(80, 141);
                label1.text=@"点击预览";
                label1.textAlignment=NSTextAlignmentCenter;
                label1.textColor=AllDeepGrayColor;
                label1.font=[UIFont systemFontOfSize:16];
                [PDFBtn addSubview:label1];
            }
            {
                UILabel* label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 140, 40)];
                label1.center=CGPointMake(80, 166);
                label1.text=self.title;
                label1.textAlignment=NSTextAlignmentCenter;
                label1.textColor=AllDeepGrayColor;
                label1.font=[UIFont systemFontOfSize:16];
                [PDFBtn addSubview:label1];
            }
        }
        
        {
            UIView* line=[RKShadowView seperatorLineShadowViewWithHeight:10];
            CGRect frame=line.frame;
            frame.origin.y=265;
            line.frame=frame;
            [view addSubview:line];
        }
        
        _PDFView=view;
    }
    return _PDFView;
}

/*
 同意带字 不同意带字 关闭带字 修改带字
 同意小带字 不同意小带字 上传小带字
 同意迷你带字 不同意迷你带字 上传迷你带字 选项按钮
 */
-(ContractsBtnToolBar *)btnToolBar{
    if (!_btnToolBar) {
        NSMutableArray* btns=[NSMutableArray array];
        NSArray* imageNames=@[@"不同意小带字",@"同意小带字",@"上传小带字"];
        
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
@end
