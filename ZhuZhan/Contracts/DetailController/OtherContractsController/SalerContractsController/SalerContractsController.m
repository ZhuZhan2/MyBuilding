//
//  SalerContractsController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/20.
//
//

#import "SalerContractsController.h"
#import "ContractsApi.h"
#import "ContractsSalerModel.h"
@interface SalerContractsController ()
@property (nonatomic, strong)ContractsSalerModel* salerModel;
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

-(void)loadList{
    self.btnToolBar.userInteractionEnabled=NO;
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.listSingleModel.a_id;
    [dic setObject:contractsId forKey:@"contractId"];
    [ContractsApi PostSalesDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
            self.salerModel=posts[0];
            self.btnToolBar.userInteractionEnabled=YES;
            [self reload];
        }
    } dic:dic noNetWork:nil];
}

-(void)reload{
    [self.btnToolBar removeFromSuperview];
    self.btnToolBar=nil;
    [self initBtnToolBar];
}

-(void)contractsBtnToolBarClickedWithBtn:(UIButton *)btn index:(NSInteger)index{
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

/*
 同意带字 不同意带字 关闭带字 修改带字
 同意小带字 不同意小带字 上传小带字
 同意迷你带字 不同意迷你带字 上传迷你带字 选项按钮
 */
-(ContractsBtnToolBar *)btnToolBar{
    if (!_btnToolBar) {
        NSMutableArray* btns=[NSMutableArray array];
        NSArray* imageNames;
        if (self.salerModel.a_status==1) {
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