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
-(void)initPDFView;
-(void)initBtnToolBar;
@end
