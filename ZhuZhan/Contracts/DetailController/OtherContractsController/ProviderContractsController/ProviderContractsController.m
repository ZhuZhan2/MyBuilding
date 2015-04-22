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
    view.ID = self.listSingleModel.a_id;
    view.type = @"0";
    view.name = self.listSingleModel.a_fileName;
    [self.navigationController pushViewController:view animated:YES];
}

-(void)loadList{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setObject:self.listSingleModel.a_id forKey:@"contractId"];
    [ContractsApi PostDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.mainClauseModel=posts[0];
            [self reload];
        }
    } dic:dic noNetWork:nil];
}

-(void)reload{
    [self.stagesView removeFromSuperview];
    self.stagesView=nil;
    [self initStagesView];
    
    [self.btnToolBar removeFromSuperview];
    self.btnToolBar=nil;
    [self initBtnToolBar];
}

-(void)contractsBtnToolBarClickedWithBtn:(UIButton *)btn index:(NSInteger)index{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.listSingleModel.a_id;
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

-(void)closeBtnClicked{
    if (self.mainClauseModel.a_status==3) {
            [[[UIAlertView alloc]initWithTitle:@"提醒" message:@"目前状态无法进行关闭" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
            return;
    }
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.listSingleModel.a_id;
    [dic setObject:contractsId forKey:@"id"];
    [ContractsApi PostCommissionCloseWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            [self sucessPost];
        }
    } dic:dic noNetWork:nil];
}

-(UIView *)stagesView{
    if (!_stagesView) {
        NSInteger status=self.mainClauseModel.a_status;
        BOOL hasSalerFile=self.listSingleModel.a_saleHas;
        NSArray* bigStages=@[@"合同主要条款",@"供应商佣金合同",@"销售佣金合同"];
        NSArray* array;
        {
            if (status==5||status==7||status==8) {
                array=[self stylesWithNumber:3 count:4];
            }else if (status==9){
                array=[self stylesWithNumber:4 count:4];
            }else if (status==3||status==4||status==6){
                array=[self stylesWithNumber:2 count:4];
            }else{
                array=[self stylesWithNumber:1 count:4];
            }
        }
        
        _stagesView=[RKContractsStagesView contractsStagesViewWithBigStageNames:bigStages smallStageNames:@[@[@"已完成"],@[@"填写合同",@"审核中",@"生成",@"上传"],@[hasSalerFile?(self.listSingleModel.a_archiveStatusInt==1?@"已完成":@"进行中"):@"未开始"]] smallStageStyles:@[@[@0],array,@[hasSalerFile?@0:@1]] isClosed:NO];
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
        NSArray* smallStageNames=@[@[@"填写条款",@"待审核",@"生成条款"],@[self.listSingleModel.a_archiveStatus],@[@"未开始"]];
        NSArray* smallStageStyles=@[@[@0,@0,@0],@[@0],@[@1]];
        
        [datas addObject:bigStageNames];
        [datas addObject:smallStageNames];
        [datas addObject:smallStageStyles];
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

        if (self.mainClauseModel.a_status==3) {
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
@end
