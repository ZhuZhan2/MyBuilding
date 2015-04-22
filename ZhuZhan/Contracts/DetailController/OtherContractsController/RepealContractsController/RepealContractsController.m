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
#import "ContractsRepealModel.h"
@interface RepealContractsController ()
@property (nonatomic, strong)ContractsRepealModel* repealModel;
@end

@implementation RepealContractsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNaviExtra];
    [self loadList];
}

-(void)initNaviExtra{
    self.title=self.title;
}

-(NSString *)title{
    return @"佣金撤销流程";
}

-(void)loadList{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.listSingleModel.a_contractsRecordId;
    [dic setObject:contractsId forKey:@"contractId"];
    [ContractsApi PostRevocationDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.repealModel=posts[0];
            [self reload];
        }
    } dic:dic noNetWork:nil];
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
        [ContractsApi PostRevocationDisagreeWithBlock:^(NSMutableArray *posts, NSError *error) {
            if (!error) {
                NSLog(@"不同意成功");
                [self sucessPost];
            }
        } dic:dic noNetWork:nil];
        
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

/*
 同意带字 不同意带字 关闭带字 修改带字
 同意小带字 不同意小带字 上传小带字
 同意迷你带字 不同意迷你带字 上传迷你带字 选项按钮
 */
-(ContractsBtnToolBar *)btnToolBar{
    if (!_btnToolBar) {
        NSMutableArray* btns=[NSMutableArray array];
        NSArray* imageNames;
        if (self.listSingleModel.a_status==1) {
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
@end
