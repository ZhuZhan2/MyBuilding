//
//  OtherContractsBaseController.h
//  ZhuZhan
//
//  Created by 孙元侃 on 15/4/10.
//
//

#import "ContractsBaseViewController.h"
#import "ContractsBtnToolBar.h"
@interface OtherContractsBaseController : ContractsBaseViewController<ContractsBtnToolBarDelegate>{
    @protected
    ContractsBtnToolBar* _btnToolBar;
    UIView* _PDFView;
}
@property (nonatomic, strong)UIButton* clauseMainBtn;
@property (nonatomic, strong)UIView* PDFView;
@property (nonatomic, strong)ContractsBtnToolBar* btnToolBar;

//只允许在消息列表传,各合同自身id
@property (nonatomic, copy)NSString* contractId;

-(void)initPDFView;
-(void)initBtnToolBar;
@end
