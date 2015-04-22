//
//  RepealContractsController.m
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/21.
//
//

#import "RepealContractsController.h"
#import "ContractsApi.h"
@interface RepealContractsController ()
//@property (nonatomic, strong)ContractsSalerModel* salerModel;
@end

@implementation RepealContractsController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initNaviExtra{
    self.title=@"佣金撤销流程";
}

-(void)loadList{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    NSString* contractsId=self.listSingleModel.a_id;
    [dic setObject:contractsId forKey:@"contractId"];
    [ContractsApi PostRevocationDetailWithBlock:^(NSMutableArray *posts, NSError *error) {
        if (!error) {
           // self.salerModel=posts[0];
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
@end
